
const path = require("path");
const fs = require("fs/promises");
const crypto = require("crypto");
const express = require("express");
const cors = require("cors");
const swaggerUi = require("swagger-ui-express");
const swaggerJsdoc = require("swagger-jsdoc");
const pool = require("./db");

const app = express();
const PORT = process.env.PORT || 5000;
let AUTH_SECRET = process.env.AUTH_SECRET || null;

const allowedOrigins = new Set((process.env.CORS_ORIGINS || "").split(",").map((origin) => origin.trim()).filter(Boolean));
app.use(cors({
    origin(origin, callback) {
        const localDevelopmentOrigin = origin && /^https?:\/\/(localhost|127\.0\.0\.1)(:\d+)?$/i.test(origin);
        callback(null, !origin || allowedOrigins.has(origin) || localDevelopmentOrigin);
    },
    methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allowedHeaders: ["Content-Type", "Authorization"]
}));
app.use((_req, res, next) => {
    res.set({
        "X-Content-Type-Options": "nosniff",
        "X-Frame-Options": "DENY",
        "Referrer-Policy": "strict-origin-when-cross-origin",
        "Permissions-Policy": "camera=(), microphone=(), geolocation=()",
        "Content-Security-Policy": "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; font-src 'self' https://fonts.gstatic.com; img-src 'self' data: https:; connect-src 'self' http://localhost:5000 http://127.0.0.1:5000; object-src 'none'; base-uri 'self'; frame-ancestors 'none'; form-action 'self'"
    });
    next();
});
app.use("/api", (_req, res, next) => {
    res.set("Cache-Control", "no-store");
    next();
});
app.use(express.json({ limit: "4mb" }));
app.use((req, res, next) => {
    if (req.body === undefined) req.body = {};
    if (req.body !== undefined && (req.body === null || typeof req.body !== "object" || Array.isArray(req.body))) {
        return res.status(400).json({ error: "Send the request body as a JSON object." });
    }
    return next();
});

const initializeAuthSecret = async () => {
    if (AUTH_SECRET) {
        if (Buffer.byteLength(AUTH_SECRET) < 32) throw new Error("AUTH_SECRET must contain at least 32 bytes.");
        return;
    }
    const secretPath = path.join(__dirname, ".auth-secret");
    try {
        AUTH_SECRET = (await fs.readFile(secretPath, "utf8")).trim();
    } catch (error) {
        if (error.code !== "ENOENT") throw error;
        const generatedSecret = crypto.randomBytes(32).toString("hex");
        try {
            await fs.writeFile(secretPath, generatedSecret, { encoding: "utf8", flag: "wx", mode: 0o600 });
            AUTH_SECRET = generatedSecret;
        } catch (writeError) {
            if (writeError.code !== "EEXIST") throw writeError;
            AUTH_SECRET = (await fs.readFile(secretPath, "utf8")).trim();
        }
    }
    if (Buffer.byteLength(AUTH_SECRET) < 32) throw new Error("The local auth secret is invalid; remove backend/.auth-secret and restart.");
};

const withTransaction = async (operation) => {
    const client = await pool.connect();
    try {
        await client.query("BEGIN");
        const result = await operation(client);
        await client.query("COMMIT");
        return result;
    } catch (error) {
        await client.query("ROLLBACK").catch(() => {});
        throw error;
    } finally {
        client.release();
    }
};

const transactionQuery = (query, values = []) => withTransaction((client) => client.query(query, values));

const isIsoDate = (value) => typeof value === "string" && /^\d{4}-\d{2}-\d{2}$/.test(value) &&
    !Number.isNaN(Date.parse(`${value}T00:00:00.000Z`)) &&
    new Date(`${value}T00:00:00.000Z`).toISOString().slice(0, 10) === value;

/* =========================
   SWAGGER CONFIGURATION
   ========================= */

const swaggerSpec = swaggerJsdoc({
    definition: {
        openapi: "3.0.0",
        info: {
            title: "CancerCare API",
            version: "1.0.0",
            description: "Backend API for the CancerCare application"
        },
        servers: [
            {
                url: `http://localhost:${PORT}`
            }
        ]
    },
    apis: [__filename]
});

app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));

/* =========================
   PASSWORD FUNCTIONS
   ========================= */

const hashPassword = (password, salt = crypto.randomBytes(16).toString("hex")) => {
    // 24 bytes keeps the encoded hash within the schema's VARCHAR(100) limit.
    const hash = crypto.scryptSync(password, salt, 24).toString("hex");
    return `scrypt$${salt}$${hash}`;
};

const passwordMatches = (password, storedHash) => {
    if (!storedHash || !storedHash.startsWith("scrypt$")) return false;

    const [, salt, expected] = storedHash.split("$");
    if (!/^[a-f0-9]{32}$/i.test(salt || "") || !/^[a-f0-9]{48}$/i.test(expected || "")) return false;
    const actual = hashPassword(password, salt).split("$")[2];

    return crypto.timingSafeEqual(
        Buffer.from(actual, "hex"),
        Buffer.from(expected, "hex")
    );
};

const asyncRoute = (handler) => async (req, res) => {
    try {
        await handler(req, res);
    } catch (error) {
        console.error(error);
        res.status(500).json({
            error: "We could not load that information right now."
        });
    }
};

const createAuthToken = (userId, role) => {
    const expiresAt = Date.now() + 12 * 60 * 60 * 1000;
    const value = `${userId}.${expiresAt}.${role}`;
    const signature = crypto.createHmac("sha256", AUTH_SECRET).update(value).digest("hex");
    return `${value}.${signature}`;
};

const loginFailures = new Map();
const LOGIN_WINDOW_MS = 15 * 60 * 1000;
const LOGIN_MAX_FAILURES = 10;
const loginRateLimit = (req, res, next) => {
    if (loginFailures.size > 10000) {
        for (const [ip, attempt] of loginFailures) {
            if (Date.now() - attempt.startedAt >= LOGIN_WINDOW_MS) loginFailures.delete(ip);
        }
    }
    const key = req.ip || req.socket.remoteAddress || "unknown";
    const attempt = loginFailures.get(key);
    if (attempt && Date.now() - attempt.startedAt < LOGIN_WINDOW_MS && attempt.count >= LOGIN_MAX_FAILURES) {
        return res.status(429).json({ error: "Too many sign-in attempts. Wait 15 minutes and try again." });
    }
    if (attempt && Date.now() - attempt.startedAt >= LOGIN_WINDOW_MS) loginFailures.delete(key);
    return next();
};
const recordLoginFailure = (req) => {
    const key = req.ip || req.socket.remoteAddress || "unknown";
    const current = loginFailures.get(key);
    if (!current || Date.now() - current.startedAt >= LOGIN_WINDOW_MS) {
        loginFailures.set(key, { startedAt: Date.now(), count: 1 });
    } else {
        current.count += 1;
    }
};
const clearLoginFailures = (req) => loginFailures.delete(req.ip || req.socket.remoteAddress || "unknown");

const authenticate = async (req, res, next) => {
    try {
        const [userId, expiresAt, tokenRole, signature] = (req.headers.authorization || "")
            .replace(/^Bearer\s+/i, "")
            .split(".");
        const value = `${userId}.${expiresAt}.${tokenRole}`;
        const expected = crypto.createHmac("sha256", AUTH_SECRET).update(value).digest("hex");
        const validSignature = /^[a-f0-9]{64}$/i.test(signature || "") && signature.length === expected.length &&
            crypto.timingSafeEqual(Buffer.from(signature), Buffer.from(expected));

        if (!/^\d+$/.test(userId || "") || !Number.isSafeInteger(Number(expiresAt)) ||
            Number(expiresAt) <= Date.now() || !["Patient", "Doctor", "Admin"].includes(tokenRole) || !validSignature) {
            return res.status(401).json({ error: "Please sign in again to continue." });
        }

        const result = await pool.query(`SELECT u.user_id, u.first_name, u.last_name,
            CASE WHEN p.patient_id IS NOT NULL THEN 'Patient'
                 WHEN d.doctor_id IS NOT NULL THEN 'Doctor'
                 WHEN a.admin_id IS NOT NULL THEN 'Admin' END AS role
            FROM users u
            LEFT JOIN patient p ON p.patient_id = u.user_id
            LEFT JOIN doctors d ON d.doctor_id = u.user_id
            LEFT JOIN admins a ON a.admin_id = u.user_id
            WHERE u.user_id = $1`, [userId]);
        const account = result.rows[0];
        if (!account || account.role !== tokenRole) {
            return res.status(403).json({ error: "You do not have permission to do that." });
        }

        req.authUser = {
            id: Number(userId),
            role: account.role,
            name: `${account.first_name} ${account.last_name || ""}`.trim()
        };
        return next();
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "We could not verify your account right now." });
    }
};

const requireRole = (role) => (req, res, next) => authenticate(req, res, () => {
    if (req.authUser.role !== role) return res.status(403).json({ error: "You do not have permission to do that." });
    return next();
});

const initializeBlogSubmissions = async () => {
    await pool.query(`CREATE TABLE IF NOT EXISTS blog_submissions (
        submission_id SERIAL PRIMARY KEY,
        patient_id INTEGER NOT NULL REFERENCES patient(patient_id) ON DELETE CASCADE,
        title VARCHAR(200) NOT NULL,
        body TEXT NOT NULL,
        status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
        submitted_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        reviewed_by INTEGER REFERENCES admins(admin_id),
        reviewed_at TIMESTAMPTZ,
        blog_id INTEGER REFERENCES blogposts(blog_id) ON DELETE SET NULL
    )`);
    await pool.query(`ALTER TABLE blog_submissions ADD COLUMN IF NOT EXISTS doctor_id INTEGER REFERENCES doctors(doctor_id) ON DELETE SET NULL`);
    await pool.query(`ALTER TABLE blog_submissions ADD COLUMN IF NOT EXISTS doctor_rating INTEGER CHECK (doctor_rating BETWEEN 1 AND 5)`);
    await pool.query(`ALTER TABLE blog_submissions ADD COLUMN IF NOT EXISTS doctor_review TEXT`);
    await pool.query(`ALTER TABLE blog_submissions ADD COLUMN IF NOT EXISTS hospital_id INTEGER REFERENCES hospitals(hospital_id) ON DELETE SET NULL`);
    await pool.query(`ALTER TABLE blog_submissions ADD COLUMN IF NOT EXISTS hospital_rating INTEGER CHECK (hospital_rating BETWEEN 1 AND 5)`);
    await pool.query(`ALTER TABLE blog_submissions ADD COLUMN IF NOT EXISTS hospital_review TEXT`);
};

const initializeLearnArticles = async () => {
    await pool.query(`CREATE TABLE IF NOT EXISTS learn_articles (
        article_id SERIAL PRIMARY KEY,
        doctor_id INTEGER NOT NULL REFERENCES doctors(doctor_id) ON DELETE CASCADE,
        title VARCHAR(200) NOT NULL,
        category VARCHAR(80) NOT NULL DEFAULT 'General education',
        body TEXT NOT NULL,
        sources TEXT,
        photo_bytes BYTEA,
        photo_mime VARCHAR(30),
        published_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
    )`);
    await pool.query(`CREATE TABLE IF NOT EXISTS learn_submissions (
        submission_id SERIAL PRIMARY KEY,
        doctor_id INTEGER NOT NULL REFERENCES doctors(doctor_id) ON DELETE CASCADE,
        title VARCHAR(200) NOT NULL,
        category VARCHAR(80) NOT NULL DEFAULT 'General education',
        body TEXT NOT NULL,
        sources TEXT,
        photo_bytes BYTEA,
        photo_mime VARCHAR(30),
        status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
        submitted_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        reviewed_by INTEGER REFERENCES admins(admin_id),
        reviewed_at TIMESTAMPTZ,
        article_id INTEGER REFERENCES learn_articles(article_id) ON DELETE SET NULL
    )`);
};

const initializeContentUpdates = async () => {
    await pool.query(`CREATE TABLE IF NOT EXISTS content_update_submissions (
        update_id SERIAL PRIMARY KEY,
        content_type VARCHAR(20) NOT NULL CHECK (content_type IN ('patient_story', 'learn_article')),
        content_id INTEGER NOT NULL,
        author_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
        title VARCHAR(200) NOT NULL,
        category VARCHAR(80),
        body TEXT NOT NULL,
        sources TEXT,
        photo_bytes BYTEA,
        photo_mime VARCHAR(30),
        status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
        submitted_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        reviewed_by INTEGER REFERENCES admins(admin_id),
        reviewed_at TIMESTAMPTZ
    )`);
    await pool.query(`CREATE UNIQUE INDEX IF NOT EXISTS one_pending_content_edit_idx
        ON content_update_submissions (content_type, content_id, author_id)
        WHERE status = 'pending'`);
};

const initializeDoctorApplications = async () => {
    await pool.query(`ALTER TABLE doctors ADD COLUMN IF NOT EXISTS qualification VARCHAR(250)`);
    await pool.query(`CREATE TABLE IF NOT EXISTS doctor_registration_applications (
        application_id SERIAL PRIMARY KEY,
        first_name VARCHAR(30) NOT NULL,
        last_name VARCHAR(30),
        contact VARCHAR(15) NOT NULL,
        password_hash VARCHAR(100),
        hospital_id INTEGER NOT NULL REFERENCES hospitals(hospital_id) ON DELETE CASCADE,
        license_no VARCHAR(50) NOT NULL,
        qualification VARCHAR(250) NOT NULL,
        license_document BYTEA NOT NULL,
        document_mime VARCHAR(40) NOT NULL CHECK (document_mime IN ('application/pdf', 'image/jpeg', 'image/png', 'image/webp')),
        email VARCHAR(100),
        fees NUMERIC(10,2) NOT NULL CHECK (fees > 0),
        gender VARCHAR(10),
        address VARCHAR(255) NOT NULL,
        district VARCHAR(100),
        area VARCHAR(100) NOT NULL,
        experience_years INTEGER NOT NULL CHECK (experience_years >= 0),
        status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
        rejection_reason TEXT,
        submitted_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        reviewed_by INTEGER REFERENCES admins(admin_id) ON DELETE SET NULL,
        reviewed_at TIMESTAMPTZ
    )`);
    await pool.query(`CREATE UNIQUE INDEX IF NOT EXISTS pending_doctor_application_contact_idx
        ON doctor_registration_applications (contact) WHERE status = 'pending'`);
    await pool.query(`CREATE UNIQUE INDEX IF NOT EXISTS pending_doctor_application_license_idx
        ON doctor_registration_applications (license_no) WHERE status = 'pending'`);
    await pool.query(`CREATE UNIQUE INDEX IF NOT EXISTS pending_doctor_application_email_idx
        ON doctor_registration_applications (email) WHERE status = 'pending' AND email IS NOT NULL`);
};

const initializeAppointments = async () => {
    await pool.query(`CREATE TABLE IF NOT EXISTS appointments (
        appointment_id SERIAL PRIMARY KEY,
        patient_id INTEGER NOT NULL REFERENCES patient(patient_id) ON DELETE CASCADE,
        doctor_id INTEGER NOT NULL REFERENCES doctors(doctor_id) ON DELETE CASCADE,
        hospital_id INTEGER REFERENCES hospitals(hospital_id) ON DELETE SET NULL,
        reason TEXT NOT NULL,
        requested_date DATE,
        appointment_date DATE,
        status VARCHAR(24) NOT NULL DEFAULT 'pending'
            CHECK (status IN ('pending', 'doctor_available', 'assigned', 'completed')),
        requested_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        marked_available_at TIMESTAMPTZ,
        assigned_by INTEGER REFERENCES admins(admin_id),
        assigned_at TIMESTAMPTZ
    )`);
    await pool.query(`ALTER TABLE appointments ADD COLUMN IF NOT EXISTS hospital_id INTEGER REFERENCES hospitals(hospital_id) ON DELETE SET NULL`);
    // Upgrade databases created before visit completion was added.
    await pool.query(`ALTER TABLE appointments DROP CONSTRAINT IF EXISTS appointments_status_check`);
    await pool.query(`ALTER TABLE appointments ADD CONSTRAINT appointments_status_check
        CHECK (status IN ('pending', 'doctor_available', 'assigned', 'completed'))`);
    await pool.query(`CREATE TABLE IF NOT EXISTS completed_appointment_history (
        appointment_id INTEGER PRIMARY KEY,
        patient_id INTEGER NOT NULL,
        doctor_id INTEGER NOT NULL,
        hospital_id INTEGER,
        reason TEXT NOT NULL,
        requested_date DATE,
        appointment_date DATE,
        requested_at TIMESTAMPTZ NOT NULL,
        marked_available_at TIMESTAMPTZ,
        assigned_by INTEGER,
        assigned_at TIMESTAMPTZ,
        completed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        archived_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
    )`);
    await pool.query(`ALTER TABLE completed_appointment_history ADD COLUMN IF NOT EXISTS hospital_id INTEGER`);
    await pool.query(`CREATE INDEX IF NOT EXISTS appointments_patient_status_idx
        ON appointments (patient_id, status)`);
    await pool.query(`CREATE INDEX IF NOT EXISTS appointments_doctor_status_idx
        ON appointments (doctor_id, status)`);
};

const initializeRatings = async () => {
    await pool.query(`ALTER TABLE doctors ADD COLUMN IF NOT EXISTS rating NUMERIC(3,2) NOT NULL DEFAULT 0`);
    await pool.query(`CREATE TABLE IF NOT EXISTS blogpost_doc (
        blogpost_doc_id SERIAL PRIMARY KEY,
        blog_id INTEGER NOT NULL REFERENCES blogposts(blog_id) ON DELETE CASCADE,
        patient_id INTEGER NOT NULL REFERENCES patient(patient_id) ON DELETE CASCADE,
        doctor_id INTEGER NOT NULL REFERENCES doctors(doctor_id) ON DELETE CASCADE,
        rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
        review TEXT,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (blog_id, patient_id, doctor_id)
    )`);
    await pool.query(`CREATE TABLE IF NOT EXISTS blogpost_hospital (
        blogpost_hospital_id SERIAL PRIMARY KEY,
        blog_id INTEGER NOT NULL REFERENCES blogposts(blog_id) ON DELETE CASCADE,
        patient_id INTEGER NOT NULL REFERENCES patient(patient_id) ON DELETE CASCADE,
        hospital_id INTEGER NOT NULL REFERENCES hospitals(hospital_id) ON DELETE CASCADE,
        rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
        review TEXT,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (blog_id, patient_id, hospital_id)
    )`);
    // Upgrade rating tables created before ratings were tied to a patient.
    await pool.query(`ALTER TABLE blogpost_hospital ADD COLUMN IF NOT EXISTS patient_id INTEGER REFERENCES patient(patient_id) ON DELETE CASCADE`);
    await pool.query(`ALTER TABLE blogpost_hospital ADD COLUMN IF NOT EXISTS review TEXT`);
    await pool.query(`ALTER TABLE blogpost_hospital ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP`);
    await pool.query(`UPDATE blogpost_hospital bh SET patient_id = pb.patient_id
        FROM patient_blogpost pb WHERE pb.blog_id = bh.blog_id AND bh.patient_id IS NULL`);
    await pool.query(`CREATE UNIQUE INDEX IF NOT EXISTS blogpost_hospital_blog_patient_hospital_idx
        ON blogpost_hospital (blog_id, patient_id, hospital_id)`);
    await pool.query(`CREATE TABLE IF NOT EXISTS doctor_ratings (
        rating_id SERIAL PRIMARY KEY,
        appointment_id INTEGER NOT NULL REFERENCES completed_appointment_history(appointment_id) ON DELETE CASCADE,
        patient_id INTEGER NOT NULL REFERENCES patient(patient_id) ON DELETE CASCADE,
        doctor_id INTEGER NOT NULL REFERENCES doctors(doctor_id) ON DELETE CASCADE,
        rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
        review TEXT,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (appointment_id, patient_id, doctor_id)
    )`);
    await pool.query(`CREATE TABLE IF NOT EXISTS hospital_ratings (
        rating_id SERIAL PRIMARY KEY,
        appointment_id INTEGER NOT NULL REFERENCES completed_appointment_history(appointment_id) ON DELETE CASCADE,
        patient_id INTEGER NOT NULL REFERENCES patient(patient_id) ON DELETE CASCADE,
        hospital_id INTEGER NOT NULL REFERENCES hospitals(hospital_id) ON DELETE CASCADE,
        rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
        review TEXT,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (appointment_id, patient_id, hospital_id)
    )`);
    await pool.query(`UPDATE doctors d SET rating = COALESCE((
        SELECT ROUND(AVG(all_ratings.rating)::numeric, 2) FROM (
            SELECT rating FROM doctor_ratings WHERE doctor_id = d.doctor_id
            UNION ALL
            SELECT rating FROM blogpost_doc WHERE doctor_id = d.doctor_id
        ) all_ratings
    ), 0)`);
};

const initializePrescriptionAppointments = async () => {
    // Keep prescription history compatible with the existing prescriptions and
    // prescription_medicine tables while tying new prescriptions to visits.
    await pool.query(`CREATE TABLE IF NOT EXISTS prescriptions (
        prescription_id SERIAL PRIMARY KEY,
        doctor_id INTEGER NOT NULL REFERENCES doctors(doctor_id) ON DELETE RESTRICT,
        patient_id INTEGER NOT NULL REFERENCES patient(patient_id) ON DELETE CASCADE,
        appointment_id INTEGER REFERENCES appointments(appointment_id) ON DELETE SET NULL,
        prescription_date DATE NOT NULL DEFAULT CURRENT_DATE,
        visit_date DATE,
        description TEXT
    )`);
    await pool.query(`ALTER TABLE prescriptions
        ADD COLUMN IF NOT EXISTS appointment_id INTEGER REFERENCES appointments(appointment_id) ON DELETE SET NULL`);
    await pool.query(`ALTER TABLE prescriptions ADD COLUMN IF NOT EXISTS visit_date DATE`);
    await pool.query(`CREATE UNIQUE INDEX IF NOT EXISTS prescriptions_appointment_unique_idx
        ON prescriptions (appointment_id)`);
};

const initializeDatabaseRoutines = async () => {
    const sql = await fs.readFile(path.join(__dirname, "submission_audit.sql"), "utf8");
    await pool.query(sql);
};

const initializeTreatmentInformation = async () => {
    const sql = await fs.readFile(path.join(__dirname, "treatment_information.sql"), "utf8");
    await pool.query(sql);
};

/* =========================
   HEALTH
   ========================= */

/**
 * @swagger
 * /api/health:
 *   get:
 *     summary: Check backend and database health
 *     responses:
 *       200:
 *         description: Database is available
 */
app.get("/api/health", asyncRoute(async (_req, res) => {
    await pool.query("SELECT 1");

    res.json({
        status: "connected",
        message: "CancerCare database is available."
    });
}));

/* =========================
   OVERVIEW
   ========================= */

/**
 * @swagger
 * /api/overview:
 *   get:
 *     summary: Get CancerCare database overview
 *     responses:
 *       200:
 *         description: Overview counts
 */
app.get("/api/overview", asyncRoute(async (_req, res) => {
    const result = await pool.query("SELECT * FROM get_cancercare_statistics()");

    res.json(result.rows[0]);
}));

/* =========================
   HOSPITALS
   ========================= */

/**
 * @swagger
 * /api/hospitals:
 *   get:
 *     summary: Get hospitals
 *     parameters:
 *       - in: query
 *         name: search
 *         schema:
 *           type: string
 *         description: Search by hospital name, area, or district
 *     responses:
 *       200:
 *         description: List of hospitals
 */
app.get("/api/hospitals", asyncRoute(async (req, res) => {
    const search = `%${(req.query.search || "").trim()}%`;

    const result = await pool.query(`SELECT hospital_id, hospital_name, district, area, hospital_type, bed_capacity, phone
        FROM hospitals
        WHERE hospital_name ILIKE $1
           OR area ILIKE $1
           OR district ILIKE $1
        ORDER BY CASE hospital_name
            WHEN 'National Institute of Cancer Research & Hospital (NICRH)' THEN 1
            WHEN 'Evercare Hospital Dhaka' THEN 2
            WHEN 'Square Hospital Ltd.' THEN 3
            WHEN 'United Hospital Limited' THEN 4
            WHEN 'Labaid Cancer Hospital & Super Speciality Centre' THEN 5
            WHEN 'Ahsania Mission Cancer & General Hospital' THEN 6
            ELSE 99
        END,
        hospital_name
        LIMIT 100`, [search]);

    res.json(result.rows);
}));

/**
 * @swagger
 * /api/hospitals/{id}:
 *   get:
 *     summary: Get a hospital by ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Hospital details
 *       404:
 *         description: Hospital not found
 */
app.get("/api/hospitals/:id", asyncRoute(async (req, res) => {
    const result = await pool.query(`SELECT hospital_id, hospital_name, registration_no, address, district, area, phone,
        email, established_year, website, bed_capacity, hospital_type
        FROM hospitals
        WHERE hospital_id = $1`, [req.params.id]);

    if (!result.rows.length) {
        return res.status(404).json({
            error: "Hospital not found"
        });
    }

    res.json(result.rows[0]);
}));

/* =========================
   DOCTORS
   ========================= */

/**
 * @swagger
 * /api/doctors:
 *   get:
 *     summary: Get doctors
 *     parameters:
 *       - in: query
 *         name: search
 *         schema:
 *           type: string
 *         description: Search by doctor name or area
 *     responses:
 *       200:
 *         description: List of doctors
 */
app.get("/api/doctors", asyncRoute(async (req, res) => {
    const search = `%${(req.query.search || "").trim()}%`;

    const result = await pool.query(`SELECT
        d.doctor_id,
        CONCAT(u.first_name, ' ', COALESCE(u.last_name, '')) AS doctor_name,
        d.gender,
        d.experience_years,
        d.fees,
        d.rating,
        d.qualification,
        d.area,
        COALESCE((
            SELECT string_agg(hospital.hospital_name, ', ' ORDER BY hospital.hospital_name)
            FROM doctor_hospital dh
            JOIN hospitals hospital ON hospital.hospital_id = dh.hospital_id
            WHERE dh.doctor_id = d.doctor_id
        ), '') AS hospitals,
        COALESCE((
            SELECT string_agg(
                concat(stage_cancer.cancer_name, ' (Stage ', ds.stage_no, ')'),
                ', ' ORDER BY stage_cancer.cancer_name, ds.stage_no
            )
            FROM doctor_stage ds
            JOIN cancers stage_cancer ON stage_cancer.cancer_id = ds.cancer_id
            WHERE ds.doctor_id = d.doctor_id
        ), '') AS stage_specialties,
        COALESCE(
            string_agg(DISTINCT c.cancer_name, ', '),
            'Cancer care'
        ) AS specialties
        FROM doctors d
        JOIN users u ON u.user_id = d.doctor_id
        LEFT JOIN doctor_cancer_specialization dcs
            ON dcs.doctor_id = d.doctor_id
        LEFT JOIN cancers c
            ON c.cancer_id = dcs.cancer_id
        WHERE (CONCAT(u.first_name, ' ', COALESCE(u.last_name, '')) ILIKE $1
           OR d.area ILIKE $1)
          AND EXISTS (SELECT 1 FROM doctor_hospital dh WHERE dh.doctor_id = d.doctor_id)
        GROUP BY d.doctor_id, u.first_name, u.last_name
        ORDER BY CASE d.doctor_id
            WHEN 1 THEN 1
            WHEN 2 THEN 2
            WHEN 5 THEN 3
            WHEN 6 THEN 4
            WHEN 7 THEN 5
            WHEN 9 THEN 6
            WHEN 10 THEN 7
            ELSE 99
        END,
        d.experience_years DESC NULLS LAST
        LIMIT 12`, [search]);

    res.json(result.rows);
}));

/* =========================
   APPOINTMENTS
   ========================= */

app.post("/api/appointments", requireRole("Patient"), asyncRoute(async (req, res) => {
    const doctorId = Number(req.body.doctor_id);
    const reason = typeof req.body.reason === "string" ? req.body.reason.trim() : "";
    const requestedDate = req.body.requested_date || null;
    if (!Number.isInteger(doctorId) || doctorId < 1 || !reason || reason.length > 2000) {
        return res.status(400).json({ error: "Choose a doctor and briefly describe the appointment request." });
    }
    if (requestedDate && !isIsoDate(requestedDate)) {
        return res.status(400).json({ error: "Choose a valid preferred date." });
    }
    const result = await transactionQuery(`INSERT INTO appointments (patient_id, doctor_id, reason, requested_date)
        SELECT $1, d.doctor_id, $3, $4 FROM doctors d
        WHERE d.doctor_id = $2 AND EXISTS (SELECT 1 FROM doctor_hospital dh WHERE dh.doctor_id = d.doctor_id)
        RETURNING appointment_id, status, requested_at`, [req.authUser.id, doctorId, reason, requestedDate]);
    if (!result.rowCount) return res.status(404).json({ error: "This doctor is not currently connected to a hospital." });
    res.status(201).json({ message: "Appointment request sent to the doctor.", appointment: result.rows[0] });
}));

app.get("/api/appointments/mine", requireRole("Patient"), asyncRoute(async (req, res) => {
    const result = await pool.query(`SELECT ap.appointment_id, ap.doctor_id, ap.hospital_id, ap.reason, ap.requested_date,
        ap.appointment_date, ap.status, ap.requested_at, ap.marked_available_at, ap.assigned_at,
        CONCAT(u.first_name, ' ', COALESCE(u.last_name, '')) AS doctor_name, d.area
        FROM appointments ap JOIN doctors d ON d.doctor_id = ap.doctor_id
        JOIN users u ON u.user_id = d.doctor_id
        WHERE ap.patient_id = $1 ORDER BY ap.requested_at DESC`, [req.authUser.id]);
    res.json(result.rows);
}));

app.get("/api/appointments/history", requireRole("Patient"), asyncRoute(async (req, res) => {
    const result = await pool.query(`SELECT ca.appointment_id, ca.doctor_id, ca.hospital_id, ca.reason,
        ca.appointment_date, ca.completed_at,
        CONCAT(u.first_name, ' ', COALESCE(u.last_name, '')) AS doctor_name,
        d.area,
        h.hospital_name
        FROM completed_appointment_history ca
        JOIN doctors d ON d.doctor_id = ca.doctor_id
        JOIN users u ON u.user_id = d.doctor_id
        LEFT JOIN hospitals h ON h.hospital_id = ca.hospital_id
        WHERE ca.patient_id = $1 ORDER BY ca.completed_at DESC`, [req.authUser.id]);
    res.json(result.rows);
}));

app.get("/api/patient/blog-rating-options", requireRole("Patient"), asyncRoute(async (req, res) => {
    const [doctors, hospitals] = await Promise.all([
        pool.query(`SELECT DISTINCT h.doctor_id, CONCAT(u.first_name, ' ', COALESCE(u.last_name, '')) AS doctor_name
            FROM completed_appointment_history h JOIN users u ON u.user_id = h.doctor_id
            WHERE h.patient_id = $1 ORDER BY doctor_name`, [req.authUser.id]),
        pool.query(`SELECT DISTINCT COALESCE(h.hospital_id, dh.hospital_id) AS hospital_id, hospital.hospital_name
            FROM completed_appointment_history h
            LEFT JOIN doctor_hospital dh ON dh.doctor_id = h.doctor_id AND h.hospital_id IS NULL
            JOIN hospitals hospital ON hospital.hospital_id = COALESCE(h.hospital_id, dh.hospital_id)
            WHERE h.patient_id = $1 ORDER BY hospital.hospital_name`, [req.authUser.id])
    ]);
    res.json({ doctors: doctors.rows, hospitals: hospitals.rows });
}));

app.get("/api/prescriptions/mine", requireRole("Patient"), asyncRoute(async (req, res) => {
    const result = await pool.query(`SELECT pr.prescription_id, pr.prescription_date, pr.description,
        COALESCE(a.appointment_date, pr.visit_date) AS appointment_date, CONCAT(du.first_name, ' ', COALESCE(du.last_name, '')) AS doctor_name,
        COALESCE(json_agg(json_build_object(
            'medicine_name', m.medicine_name,
            'dosage', pm.dosage,
            'instructions', pm.description
        ) ORDER BY m.medicine_name) FILTER (WHERE pm.medicine_id IS NOT NULL), '[]'::json) AS medicines
        FROM prescriptions pr
        JOIN users du ON du.user_id = pr.doctor_id
        LEFT JOIN appointments a ON a.appointment_id = pr.appointment_id
        LEFT JOIN prescription_medicine pm ON pm.prescription_id = pr.prescription_id
        LEFT JOIN medicines m ON m.medicine_id = pm.medicine_id
        WHERE pr.patient_id = $1
        GROUP BY pr.prescription_id, a.appointment_date, pr.visit_date, du.first_name, du.last_name
        ORDER BY pr.prescription_date DESC, pr.prescription_id DESC`, [req.authUser.id]);
    res.json(result.rows);
}));

app.get("/api/doctor/appointments", requireRole("Doctor"), asyncRoute(async (req, res) => {
    const result = await pool.query(`SELECT ap.appointment_id, ap.reason, ap.requested_date,
        ap.appointment_date, ap.status, ap.requested_at, ap.assigned_at,
        CONCAT(u.first_name, ' ', COALESCE(u.last_name, '')) AS patient_name,
        u.contact, pt.patient_id, rx.prescription_id
        FROM appointments ap JOIN patient pt ON pt.patient_id = ap.patient_id
        JOIN users u ON u.user_id = pt.patient_id
        LEFT JOIN prescriptions rx ON rx.appointment_id = ap.appointment_id
        WHERE ap.doctor_id = $1 ORDER BY CASE ap.status WHEN 'pending' THEN 0 WHEN 'doctor_available' THEN 1 ELSE 2 END,
        ap.requested_at DESC`, [req.authUser.id]);
    res.json(result.rows);
}));

app.get("/api/doctor/appointments/:id/prescription", requireRole("Doctor"), asyncRoute(async (req, res) => {
    if (!/^\d+$/.test(req.params.id)) return res.status(400).json({ error: "Choose a valid assigned appointment." });
    const appointment = await pool.query(`SELECT appointment_id FROM appointments
        WHERE appointment_id = $1 AND doctor_id = $2 AND status = 'assigned'`, [req.params.id, req.authUser.id]);
    if (!appointment.rowCount) return res.status(404).json({ error: "This assigned appointment was not found for your account." });

    const [prescriptionResult, medicinesResult] = await Promise.all([
        pool.query(`SELECT prescription_id, prescription_date, description FROM prescriptions WHERE appointment_id = $1`, [req.params.id]),
        pool.query(`SELECT medicine_id, medicine_name FROM medicines ORDER BY medicine_name`)
    ]);
    let prescription = prescriptionResult.rows[0] || null;
    if (prescription) {
        const items = await pool.query(`SELECT pm.medicine_id, m.medicine_name, pm.dosage, pm.description AS instructions
            FROM prescription_medicine pm JOIN medicines m ON m.medicine_id = pm.medicine_id
            WHERE pm.prescription_id = $1 ORDER BY m.medicine_name`, [prescription.prescription_id]);
        prescription = { ...prescription, medicines: items.rows };
    }
    res.json({ prescription, medicines: medicinesResult.rows });
}));

app.put("/api/doctor/appointments/:id/prescription", requireRole("Doctor"), asyncRoute(async (req, res) => {
    if (!/^\d+$/.test(req.params.id)) return res.status(400).json({ error: "Choose a valid assigned appointment." });
    const description = typeof req.body.description === "string" ? req.body.description.trim() : "";
    const submittedItems = Array.isArray(req.body.medicines) ? req.body.medicines : [];
    if (description.length > 10000 || submittedItems.length > 20) {
        return res.status(400).json({ error: "Keep notes under 10,000 characters and list no more than 20 medicines." });
    }
    const medicines = submittedItems.map((item) => ({
        medicineId: Number(item.medicine_id),
        dosage: typeof item.dosage === "string" ? item.dosage.trim() : "",
        instructions: typeof item.instructions === "string" ? item.instructions.trim() : ""
    }));
    if (medicines.some((item) => !Number.isInteger(item.medicineId) || item.medicineId < 1 ||
        !item.dosage || item.dosage.length > 100 || item.instructions.length > 1000) ||
        new Set(medicines.map((item) => item.medicineId)).size !== medicines.length) {
        return res.status(400).json({ error: "Choose a medicine, enter its dosage, and avoid duplicate medicines." });
    }
    if (!medicines.length && !description) {
        return res.status(400).json({ error: "Add at least one medicine or prescription note." });
    }

    const client = await pool.connect();
    try {
        await client.query("BEGIN");
        const appointment = await client.query(`SELECT appointment_id, patient_id FROM appointments
            WHERE appointment_id = $1 AND doctor_id = $2 AND status = 'assigned' FOR UPDATE`, [req.params.id, req.authUser.id]);
        if (!appointment.rowCount) {
            await client.query("ROLLBACK");
            return res.status(404).json({ error: "This assigned appointment was not found for your account." });
        }

        const medicineIds = medicines.map((item) => item.medicineId);
        if (medicineIds.length) {
            const available = await client.query("SELECT medicine_id FROM medicines WHERE medicine_id = ANY($1::int[])", [medicineIds]);
            if (available.rowCount !== medicineIds.length) {
                await client.query("ROLLBACK");
                return res.status(400).json({ error: "One or more selected medicines are no longer available." });
            }
        }

        const saved = await client.query(`INSERT INTO prescriptions (doctor_id, patient_id, appointment_id, prescription_date, description)
            VALUES ($1, $2, $3, CURRENT_DATE, $4)
            ON CONFLICT (appointment_id) DO UPDATE SET prescription_date = CURRENT_DATE, description = EXCLUDED.description
            RETURNING prescription_id`, [req.authUser.id, appointment.rows[0].patient_id, req.params.id, description || null]);
        const prescriptionId = saved.rows[0].prescription_id;
        await client.query("DELETE FROM prescription_medicine WHERE prescription_id = $1", [prescriptionId]);
        for (const item of medicines) {
            await client.query(`INSERT INTO prescription_medicine (prescription_id, medicine_id, dosage, description)
                VALUES ($1, $2, $3, $4)`, [prescriptionId, item.medicineId, item.dosage, item.instructions || null]);
        }
        await client.query("COMMIT");
        res.json({ message: "Prescription saved and shared with the patient." });
    } catch (error) {
        await client.query("ROLLBACK").catch(() => {});
        throw error;
    } finally {
        client.release();
    }
}));

app.post("/api/doctor/appointments/:id/available", requireRole("Doctor"), asyncRoute(async (req, res) => {
    const result = await transactionQuery(`UPDATE appointments SET status = 'doctor_available', marked_available_at = CURRENT_TIMESTAMP
        WHERE appointment_id = $1 AND doctor_id = $2 AND status = 'pending' RETURNING appointment_id`,
    [req.params.id, req.authUser.id]);
    if (!result.rowCount) return res.status(404).json({ error: "This pending request was not found for your account." });
    res.json({ message: "Marked available. An admin can now make the final appointment assignment." });
}));

app.post("/api/doctor/appointments/:id/complete", requireRole("Doctor"), asyncRoute(async (req, res) => {
    if (!/^\d+$/.test(req.params.id)) return res.status(400).json({ error: "Choose a valid assigned appointment." });
    const result = await transactionQuery(`UPDATE appointments SET status = 'completed'
        WHERE appointment_id = $1 AND doctor_id = $2 AND status = 'assigned'
        RETURNING appointment_id`, [req.params.id, req.authUser.id]);
    if (!result.rowCount) return res.status(404).json({ error: "This assigned appointment was not found for your account." });
    res.json({ message: "Visit marked complete. The appointment was archived and removed from active appointment lists." });
}));

app.get("/api/admin/doctor-applications", requireRole("Admin"), asyncRoute(async (req, res) => {
    const result = await pool.query(`SELECT application.application_id, application.first_name,
        application.last_name, application.contact, application.hospital_id, hospital.hospital_name,
        application.license_no, application.qualification, application.document_mime,
        encode(application.license_document, 'base64') AS document_base64, application.email,
        application.fees, application.gender, application.address, application.district,
        application.area, application.experience_years, application.submitted_at
        FROM doctor_registration_applications application
        JOIN hospitals hospital ON hospital.hospital_id = application.hospital_id
        WHERE application.status = 'pending' AND application.hospital_id = (
            SELECT hospital_id FROM admins WHERE admin_id = $1
        ) ORDER BY application.submitted_at ASC LIMIT 100`, [req.authUser.id]);
    res.json(result.rows);
}));

app.post("/api/admin/doctor-applications/:id/approve", requireRole("Admin"), asyncRoute(async (req, res) => {
    if (!/^\d+$/.test(req.params.id)) return res.status(400).json({ error: "Choose a valid doctor application." });
    try {
        await transactionQuery("CALL approve_doctor_registration($1, $2)", [req.params.id, req.authUser.id]);
        res.json({ message: "Doctor approved. Their account and hospital access are now active." });
    } catch (error) {
        if (error.code === "P0002") return res.status(404).json({ error: error.message });
        if (error.code === "42501") return res.status(403).json({ error: "This application belongs to another hospital." });
        if (error.code === "23505") return res.status(409).json({ error: "The phone, medical license, or email is already used by another account." });
        throw error;
    }
}));

app.post("/api/admin/doctor-applications/:id/reject", requireRole("Admin"), asyncRoute(async (req, res) => {
    if (!/^\d+$/.test(req.params.id)) return res.status(400).json({ error: "Choose a valid doctor application." });
    const reason = typeof req.body.reason === "string" ? req.body.reason.trim() : "";
    if (reason.length > 1000) return res.status(400).json({ error: "Keep the review note under 1,000 characters." });
    const result = await transactionQuery(`UPDATE doctor_registration_applications
        SET status = 'rejected', reviewed_by = $1, reviewed_at = CURRENT_TIMESTAMP,
            rejection_reason = $2, password_hash = NULL
        WHERE application_id = $3 AND status = 'pending' AND hospital_id = (
            SELECT hospital_id FROM admins WHERE admin_id = $1
        ) RETURNING application_id`, [req.authUser.id, reason || null, req.params.id]);
    if (!result.rowCount) return res.status(404).json({ error: "Pending doctor application not found for your hospital." });
    res.json({ message: "Doctor application disapproved." });
}));

app.get("/api/admin/appointments", requireRole("Admin"), asyncRoute(async (_req, res) => {
    const result = await pool.query(`SELECT ap.appointment_id, ap.reason, ap.requested_date,
        ap.appointment_date, ap.status, ap.requested_at, ap.marked_available_at,
        CONCAT(pu.first_name, ' ', COALESCE(pu.last_name, '')) AS patient_name,
        CONCAT(du.first_name, ' ', COALESCE(du.last_name, '')) AS doctor_name,
        d.area, d.fees
        FROM appointments ap JOIN patient p ON p.patient_id = ap.patient_id
        JOIN users pu ON pu.user_id = p.patient_id JOIN doctors d ON d.doctor_id = ap.doctor_id
        JOIN users du ON du.user_id = d.doctor_id
        JOIN admins current_admin ON current_admin.admin_id = $1
        JOIN doctor_hospital dh ON dh.doctor_id = d.doctor_id AND dh.hospital_id = current_admin.hospital_id
        ORDER BY CASE ap.status WHEN 'doctor_available' THEN 0 WHEN 'pending' THEN 1 ELSE 2 END,
        ap.requested_at DESC`, [_req.authUser.id]);
    res.json(result.rows);
}));

app.post("/api/admin/appointments/:id/assign", requireRole("Admin"), asyncRoute(async (req, res) => {
    const appointmentDate = req.body.appointment_date || null;
    if (appointmentDate && !isIsoDate(appointmentDate)) {
        return res.status(400).json({ error: "Choose a valid appointment date." });
    }
    const result = await transactionQuery(`UPDATE appointments SET status = 'assigned', appointment_date = $1,
        hospital_id = (SELECT current_admin.hospital_id FROM admins current_admin WHERE current_admin.admin_id = $2),
        assigned_by = $2, assigned_at = CURRENT_TIMESTAMP
        WHERE appointment_id = $3 AND status = 'doctor_available'
        AND EXISTS (SELECT 1 FROM admins current_admin
            JOIN doctor_hospital dh ON dh.hospital_id = current_admin.hospital_id
            WHERE current_admin.admin_id = $2 AND dh.doctor_id = appointments.doctor_id)
        RETURNING appointment_id`,
    [appointmentDate, req.authUser.id, req.params.id]);
    if (!result.rowCount) return res.status(409).json({ error: "Only requests marked available by the doctor can be assigned." });
    res.json({ message: "Appointment assigned to the doctor." });
}));

app.post("/api/appointments/:id/rate-doctor", requireRole("Patient"), asyncRoute(async (req, res) => {
    const appointmentId = Number(req.params.id);
    const doctorId = Number(req.body.doctor_id);
    const rating = Number(req.body.rating);
    const review = typeof req.body.review === "string" ? req.body.review.trim() : "";

    if (!Number.isInteger(appointmentId) || appointmentId < 1) {
        return res.status(400).json({ error: "Choose a valid completed appointment." });
    }
    if (!Number.isInteger(doctorId) || doctorId < 1) {
        return res.status(400).json({ error: "Pick the doctor you want to rate." });
    }
    if (!Number.isInteger(rating) || rating < 1 || rating > 5) {
        return res.status(400).json({ error: "Doctor rating must be between 1 and 5." });
    }
    if (review.length > 1000) {
        return res.status(400).json({ error: "Keep the doctor review under 1,000 characters." });
    }

    const visit = await pool.query(`SELECT appointment_id, patient_id, doctor_id, hospital_id
        FROM completed_appointment_history
        WHERE appointment_id = $1 AND patient_id = $2 AND doctor_id = $3`, [appointmentId, req.authUser.id, doctorId]);
    if (!visit.rowCount) {
        return res.status(403).json({ error: "You can only rate a doctor from a completed appointment that belongs to you." });
    }

    const result = await transactionQuery(`INSERT INTO doctor_ratings (appointment_id, patient_id, doctor_id, rating, review)
        VALUES ($1, $2, $3, $4, $5)
        ON CONFLICT (appointment_id, patient_id, doctor_id)
        DO UPDATE SET rating = EXCLUDED.rating, review = EXCLUDED.review, created_at = CURRENT_TIMESTAMP
        RETURNING rating_id`,
    [appointmentId, req.authUser.id, doctorId, rating, review || null]);
    res.status(201).json({ message: "Doctor rating saved for this completed visit.", rating: result.rows[0] });
}));

app.post("/api/appointments/:id/rate-hospital", requireRole("Patient"), asyncRoute(async (req, res) => {
    const appointmentId = Number(req.params.id);
    const hospitalId = Number(req.body.hospital_id);
    const rating = Number(req.body.rating);
    const review = typeof req.body.review === "string" ? req.body.review.trim() : "";

    if (!Number.isInteger(appointmentId) || appointmentId < 1) {
        return res.status(400).json({ error: "Choose a valid completed appointment." });
    }
    if (!Number.isInteger(hospitalId) || hospitalId < 1) {
        return res.status(400).json({ error: "Pick the hospital you want to rate." });
    }
    if (!Number.isInteger(rating) || rating < 1 || rating > 5) {
        return res.status(400).json({ error: "Hospital rating must be between 1 and 5." });
    }
    if (review.length > 1000) {
        return res.status(400).json({ error: "Keep the hospital review under 1,000 characters." });
    }

    const visit = await pool.query(`SELECT h.appointment_id, h.patient_id, h.doctor_id, COALESCE(h.hospital_id, dh.hospital_id) AS hospital_id
        FROM completed_appointment_history h
        LEFT JOIN doctor_hospital dh ON dh.doctor_id = h.doctor_id AND h.hospital_id IS NULL
        WHERE h.appointment_id = $1 AND h.patient_id = $2
          AND COALESCE(h.hospital_id, dh.hospital_id) = $3`, [appointmentId, req.authUser.id, hospitalId]);
    if (!visit.rowCount) {
        return res.status(403).json({ error: "You can only rate the hospital tied to your completed appointment." });
    }

    const result = await transactionQuery(`INSERT INTO hospital_ratings (appointment_id, patient_id, hospital_id, rating, review)
        VALUES ($1, $2, $3, $4, $5)
        ON CONFLICT (appointment_id, patient_id, hospital_id)
        DO UPDATE SET rating = EXCLUDED.rating, review = EXCLUDED.review, created_at = CURRENT_TIMESTAMP
        RETURNING rating_id`,
    [appointmentId, req.authUser.id, hospitalId, rating, review || null]);
    res.status(201).json({ message: "Hospital rating saved for this completed visit.", rating: result.rows[0] });
}));

/* =========================
   CANCERS
   ========================= */

/**
 * @swagger
 * /api/cancers:
 *   get:
 *     summary: Get cancer types
 *     responses:
 *       200:
 *         description: List of cancer types
 */
app.get("/api/cancers", asyncRoute(async (_req, res) => {
    const result = await pool.query(`SELECT
        c.cancer_id,
        c.cancer_name,
        c.causes,
        COUNT(DISTINCT hc.hospital_id)::int AS hospital_count
        FROM cancers c
        LEFT JOIN hospital_cancer hc
            ON hc.cancer_id = c.cancer_id
        GROUP BY c.cancer_id
        ORDER BY CASE c.cancer_name
            WHEN 'Female breast cancer' THEN 1
            WHEN 'Lung cancer' THEN 2
            WHEN 'Cervical cancer' THEN 3
            WHEN 'Oral cavity cancer' THEN 4
            WHEN 'Colorectal cancer' THEN 5
            WHEN 'Prostate cancer' THEN 6
            ELSE 99
        END,
        c.cancer_name
        LIMIT 12`);

    res.json(result.rows);
}));

app.get("/api/treatment-information", asyncRoute(async (req, res) => {
    const cancerId = Number(req.query.cancer_id);
    const stage = typeof req.query.stage === "string" ? req.query.stage.trim().toUpperCase() : "";
    const medicineSearch = typeof req.query.medicine === "string" ? req.query.medicine.trim() : "";

    if (!Number.isInteger(cancerId) || cancerId < 1) {
        return res.status(400).json({ error: "Choose a cancer type to search." });
    }
    if (stage && !["0", "I", "II", "III", "IV"].includes(stage)) {
        return res.status(400).json({ error: "Choose a valid cancer stage." });
    }
    if (medicineSearch.length > 100) {
        return res.status(400).json({ error: "Keep the medicine search under 100 characters." });
    }

    const result = await pool.query(`SELECT
        t.information_id, t.medicine_name, t.treatment_class, t.indication_summary,
        t.how_it_works, t.common_side_effects, t.serious_side_effects, t.stage_scope,
        t.outcome_summary, t.outcome_population,
        t.information_source_title, t.information_source_url,
        t.outcome_source_title, t.outcome_source_url, t.reviewed_at,
        c.cancer_name
        FROM cancer_treatment_information t
        JOIN cancers c ON c.cancer_id = t.cancer_id
        WHERE t.cancer_id = $1
          AND ($2::TEXT = '' OR t.stage_scope IS NULL OR UPPER(t.stage_scope) = $2)
          AND ($3::TEXT = '' OR t.medicine_name ILIKE '%' || $3 || '%')
        ORDER BY t.medicine_name`, [cancerId, stage, medicineSearch]);

    res.set("Cache-Control", "public, max-age=300").json(result.rows);
}));

/* =========================
   BLOGS
   ========================= */

/**
 * @swagger
 * /api/blogs:
 *   get:
 *     summary: Get latest blog posts
 *     responses:
 *       200:
 *         description: Latest blog posts
 */
app.get("/api/blogs", asyncRoute(async (_req, res) => {
    const result = await pool.query(
        "SELECT blog_id, title, feel, post_date FROM blogposts ORDER BY post_date DESC, blog_id DESC"
    );

    res.json(result.rows);
}));

app.get("/api/blogs/:id/ratings", asyncRoute(async (req, res) => {
    const blogId = Number(req.params.id);
    if (!Number.isInteger(blogId) || blogId < 1) {
        return res.status(400).json({ error: "Choose a valid blog post." });
    }

    const [doctorRatings, hospitalRatings] = await Promise.all([
        pool.query(`SELECT bd.blog_id, bd.doctor_id, CONCAT(u.first_name, ' ', COALESCE(u.last_name, '')) AS doctor_name,
            bd.rating, bd.review, bd.created_at
            FROM blogpost_doc bd JOIN users u ON u.user_id = bd.doctor_id
            WHERE bd.blog_id = $1 ORDER BY bd.created_at DESC`, [blogId]),
        pool.query(`SELECT bh.blog_id, bh.hospital_id, h.hospital_name, bh.rating, bh.review, bh.created_at
            FROM blogpost_hospital bh JOIN hospitals h ON h.hospital_id = bh.hospital_id
            WHERE bh.blog_id = $1 ORDER BY bh.created_at DESC`, [blogId])
    ]);

    res.json({
        doctors: doctorRatings.rows,
        hospitals: hospitalRatings.rows
    });
}));

app.get("/api/blogs/mine", requireRole("Patient"), asyncRoute(async (req, res) => {
    const result = await pool.query(`SELECT b.blog_id, b.title, b.feel, b.post_date,
        (SELECT u.status FROM content_update_submissions u
            WHERE u.content_type = 'patient_story' AND u.content_id = b.blog_id AND u.author_id = $1
            ORDER BY u.submitted_at DESC LIMIT 1) AS latest_update_status
        FROM blogposts b JOIN patient_blogpost pb ON pb.blog_id = b.blog_id
        WHERE pb.patient_id = $1 ORDER BY b.post_date DESC, b.blog_id DESC`, [req.authUser.id]);
    res.json(result.rows);
}));

app.post("/api/blogs/:id/update-requests", requireRole("Patient"), asyncRoute(async (req, res) => {
    const owned = await pool.query("SELECT 1 FROM patient_blogpost WHERE patient_id = $1 AND blog_id = $2",
        [req.authUser.id, req.params.id]);
    if (!owned.rows.length) return res.status(404).json({ error: "You can only request changes to your own stories." });

    const title = typeof req.body.title === "string" ? req.body.title.trim() : "";
    const body = typeof req.body.body === "string" ? req.body.body.trim() : "";
    if (!title || title.length > 200 || !body || body.length > 10000) {
        return res.status(400).json({ error: "Add a title and story text (up to 10,000 characters)." });
    }
    try {
        const result = await transactionQuery(`INSERT INTO content_update_submissions
            (content_type, content_id, author_id, title, body)
            VALUES ('patient_story', $1, $2, $3, $4) RETURNING update_id, status`,
        [req.params.id, req.authUser.id, title, body]);
        res.status(201).json({ message: "Your story update was sent to an admin for review.", update: result.rows[0] });
    } catch (error) {
        if (error.code === "23505") return res.status(409).json({ error: "An update for this story is already awaiting review." });
        throw error;
    }
}));

app.get("/api/blog-submissions/mine", requireRole("Patient"), asyncRoute(async (req, res) => {
    const result = await pool.query(`SELECT submission_id, title, body, status, submitted_at
        FROM blog_submissions WHERE patient_id = $1 ORDER BY submitted_at DESC`, [req.authUser.id]);
    res.json(result.rows);
}));

app.post("/api/blog-submissions", requireRole("Patient"), asyncRoute(async (req, res) => {
    const title = typeof req.body.title === "string" ? req.body.title.trim() : "";
    const body = typeof req.body.body === "string" ? req.body.body.trim() : "";
    const doctorId = req.body.doctor_id ? Number(req.body.doctor_id) : null;
    const doctorRating = req.body.doctor_rating ? Number(req.body.doctor_rating) : null;
    const doctorReview = typeof req.body.doctor_review === "string" ? req.body.doctor_review.trim() : "";
    const hospitalId = req.body.hospital_id ? Number(req.body.hospital_id) : null;
    const hospitalRating = req.body.hospital_rating ? Number(req.body.hospital_rating) : null;
    const hospitalReview = typeof req.body.hospital_review === "string" ? req.body.hospital_review.trim() : "";
    if (!title || !body || title.length > 200 || body.length > 10000) {
        return res.status(400).json({ error: "Add a title and a story (up to 10,000 characters)." });
    }
    if ((doctorId === null) !== (doctorRating === null) ||
        (doctorId !== null && (!Number.isInteger(doctorId) || doctorId < 1 || !Number.isInteger(doctorRating) || doctorRating < 1 || doctorRating > 5)) ||
        (hospitalId === null) !== (hospitalRating === null) ||
        (hospitalId !== null && (!Number.isInteger(hospitalId) || hospitalId < 1 || !Number.isInteger(hospitalRating) || hospitalRating < 1 || hospitalRating > 5)) ||
        doctorReview.length > 1000 || hospitalReview.length > 1000 ||
        (!doctorRating && doctorReview) || (!hospitalRating && hospitalReview)) {
        return res.status(400).json({ error: "For each optional rating, choose a provider and a score from 1 to 5. Reviews must be under 1,000 characters." });
    }

    if (doctorId !== null) {
        const visit = await pool.query(`SELECT 1 FROM completed_appointment_history WHERE patient_id = $1 AND doctor_id = $2`, [req.authUser.id, doctorId]);
        if (!visit.rowCount) return res.status(403).json({ error: "You can only rate a doctor you have seen at a completed visit." });
    }
    if (hospitalId !== null) {
        const visit = await pool.query(`SELECT 1 FROM completed_appointment_history h
            LEFT JOIN doctor_hospital dh ON dh.doctor_id = h.doctor_id AND h.hospital_id IS NULL
            WHERE h.patient_id = $1 AND COALESCE(h.hospital_id, dh.hospital_id) = $2`, [req.authUser.id, hospitalId]);
        if (!visit.rowCount) return res.status(403).json({ error: "You can only rate a hospital from a completed visit." });
    }

    const result = await transactionQuery(`INSERT INTO blog_submissions
        (patient_id, title, body, doctor_id, doctor_rating, doctor_review, hospital_id, hospital_rating, hospital_review)
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING submission_id, title, status, submitted_at`,
    [req.authUser.id, title, body, doctorId, doctorRating, doctorReview || null, hospitalId, hospitalRating, hospitalReview || null]);
    res.status(201).json({ message: "Your story was sent to an admin for review.", submission: result.rows[0] });
}));

app.post("/api/blogs/:id/rate-doctor", requireRole("Patient"), asyncRoute(async (req, res) => {
    const blogId = Number(req.params.id);
    const doctorId = Number(req.body.doctor_id);
    const rating = Number(req.body.rating);
    const review = typeof req.body.review === "string" ? req.body.review.trim() : "";

    if (!Number.isInteger(blogId) || blogId < 1) {
        return res.status(400).json({ error: "Choose a valid blog post." });
    }
    if (!Number.isInteger(doctorId) || doctorId < 1) {
        return res.status(400).json({ error: "Pick the doctor connected to this blog rating." });
    }
    if (!Number.isInteger(rating) || rating < 1 || rating > 5) {
        return res.status(400).json({ error: "Doctor rating must be between 1 and 5." });
    }
    if (review.length > 1000) {
        return res.status(400).json({ error: "Keep the doctor review under 1,000 characters." });
    }

    const ownership = await pool.query(`SELECT 1 FROM patient_blogpost WHERE patient_id = $1 AND blog_id = $2`, [req.authUser.id, blogId]);
    if (!ownership.rowCount) {
        return res.status(404).json({ error: "You can only rate doctors on your own blog post." });
    }

    const visit = await pool.query(`SELECT 1 FROM completed_appointment_history
        WHERE patient_id = $1 AND doctor_id = $2`, [req.authUser.id, doctorId]);
    if (!visit.rowCount) {
        return res.status(403).json({ error: "You can only rate the doctor you saw in a completed appointment." });
    }

    const result = await transactionQuery(`INSERT INTO blogpost_doc (blog_id, patient_id, doctor_id, rating, review)
        VALUES ($1, $2, $3, $4, $5)
        ON CONFLICT (blog_id, patient_id, doctor_id)
        DO UPDATE SET rating = EXCLUDED.rating, review = EXCLUDED.review, created_at = CURRENT_TIMESTAMP
        RETURNING blogpost_doc_id`,
    [blogId, req.authUser.id, doctorId, rating, review || null]);
    res.status(201).json({ message: "Doctor rating added to this blog post.", rating: result.rows[0] });
}));

app.post("/api/blogs/:id/rate-hospital", requireRole("Patient"), asyncRoute(async (req, res) => {
    const blogId = Number(req.params.id);
    const hospitalId = Number(req.body.hospital_id);
    const rating = Number(req.body.rating);
    const review = typeof req.body.review === "string" ? req.body.review.trim() : "";

    if (!Number.isInteger(blogId) || blogId < 1) {
        return res.status(400).json({ error: "Choose a valid blog post." });
    }
    if (!Number.isInteger(hospitalId) || hospitalId < 1) {
        return res.status(400).json({ error: "Pick the hospital connected to this blog rating." });
    }
    if (!Number.isInteger(rating) || rating < 1 || rating > 5) {
        return res.status(400).json({ error: "Hospital rating must be between 1 and 5." });
    }
    if (review.length > 1000) {
        return res.status(400).json({ error: "Keep the hospital review under 1,000 characters." });
    }

    const ownership = await pool.query(`SELECT 1 FROM patient_blogpost WHERE patient_id = $1 AND blog_id = $2`, [req.authUser.id, blogId]);
    if (!ownership.rowCount) {
        return res.status(404).json({ error: "You can only rate hospitals on your own blog post." });
    }

    const visit = await pool.query(`SELECT 1 FROM completed_appointment_history h
        LEFT JOIN doctor_hospital dh ON dh.doctor_id = h.doctor_id AND h.hospital_id IS NULL
        WHERE h.patient_id = $1 AND COALESCE(h.hospital_id, dh.hospital_id) = $2`, [req.authUser.id, hospitalId]);
    if (!visit.rowCount) {
        return res.status(403).json({ error: "You can only rate the hospital that provided your completed appointment service." });
    }

    const result = await transactionQuery(`INSERT INTO blogpost_hospital (blog_id, patient_id, hospital_id, rating, review)
        VALUES ($1, $2, $3, $4, $5)
        ON CONFLICT (blog_id, patient_id, hospital_id)
        DO UPDATE SET rating = EXCLUDED.rating, review = EXCLUDED.review, created_at = CURRENT_TIMESTAMP
        RETURNING blog_id`,
    [blogId, req.authUser.id, hospitalId, rating, review || null]);
    res.status(201).json({ message: "Hospital rating added to this blog post.", rating: result.rows[0] });
}));

app.get("/api/admin/blog-submissions", requireRole("Admin"), asyncRoute(async (_req, res) => {
    const result = await pool.query(`SELECT s.submission_id, s.title, s.body, s.submitted_at,
        CONCAT(u.first_name, ' ', COALESCE(u.last_name, '')) AS patient_name
        FROM blog_submissions s JOIN users u ON u.user_id = s.patient_id
        WHERE s.status = 'pending' ORDER BY s.submitted_at ASC`);
    res.json(result.rows);
}));

app.post("/api/admin/blog-submissions/:id/approve", requireRole("Admin"), asyncRoute(async (req, res) => {
    try {
        await transactionQuery("CALL approve_blog_submission($1, $2)", [req.params.id, req.authUser.id]);
        res.json({ message: "Story approved and published." });
    } catch (error) {
        if (error.code === "P0002") return res.status(404).json({ error: error.message });
        throw error;
    }
}));

app.post("/api/admin/blog-submissions/:id/reject", requireRole("Admin"), asyncRoute(async (req, res) => {
    const result = await transactionQuery(`UPDATE blog_submissions
        SET status = 'rejected', reviewed_by = $1, reviewed_at = CURRENT_TIMESTAMP
        WHERE submission_id = $2 AND status = 'pending' RETURNING submission_id`,
    [req.authUser.id, req.params.id]);
    if (!result.rows.length) return res.status(404).json({ error: "Pending story not found." });
    res.json({ message: "Story rejected." });
}));

/* =========================
   DOCTOR LEARN ARTICLES
   ========================= */

app.get("/api/learn-articles", asyncRoute(async (_req, res) => {
    const result = await pool.query(`SELECT a.article_id, a.title, a.category, a.body, a.sources,
        a.photo_mime, (a.photo_bytes IS NOT NULL) AS has_photo, a.published_at,
        CONCAT(u.first_name, ' ', COALESCE(u.last_name, '')) AS doctor_name
        FROM learn_articles a JOIN users u ON u.user_id = a.doctor_id
        ORDER BY a.published_at DESC, a.article_id DESC`);
    res.json(result.rows);
}));

app.get("/api/learn-articles/mine", requireRole("Doctor"), asyncRoute(async (req, res) => {
    const result = await pool.query(`SELECT a.article_id, a.title, a.category, a.body, a.sources,
        a.photo_mime, (a.photo_bytes IS NOT NULL) AS has_photo, a.published_at,
        (SELECT u.status FROM content_update_submissions u
            WHERE u.content_type = 'learn_article' AND u.content_id = a.article_id AND u.author_id = $1
            ORDER BY u.submitted_at DESC LIMIT 1) AS latest_update_status
        FROM learn_articles a WHERE a.doctor_id = $1
        ORDER BY a.published_at DESC, a.article_id DESC`, [req.authUser.id]);
    res.json(result.rows);
}));

app.post("/api/learn-articles/:id/update-requests", requireRole("Doctor"), asyncRoute(async (req, res) => {
    const owned = await pool.query(`SELECT 1 FROM learn_articles a
        WHERE a.doctor_id = $1 AND a.article_id = $2
        AND EXISTS (SELECT 1 FROM doctor_hospital dh WHERE dh.doctor_id = a.doctor_id)`,
        [req.authUser.id, req.params.id]);
    if (!owned.rows.length) return res.status(404).json({ error: "You can only request changes to your own Learn articles." });

    const title = typeof req.body.title === "string" ? req.body.title.trim() : "";
    const category = typeof req.body.category === "string" ? req.body.category.trim() : "";
    const body = typeof req.body.body === "string" ? req.body.body.trim() : "";
    const sources = typeof req.body.sources === "string" ? req.body.sources.trim() : "";
    if (!title || title.length > 200 || !category || category.length > 80 || !body || body.length > 50000 || sources.length > 5000) {
        return res.status(400).json({ error: "Check the title, category, article, and source lengths and try again." });
    }

    let photoBytes = null;
    let photoMime = null;
    if (req.body.imageData) {
        const match = typeof req.body.imageData === "string" && req.body.imageData.match(/^data:(image\/(?:jpeg|png|webp));base64,([A-Za-z0-9+/]+={0,2})$/i);
        if (!match) return res.status(400).json({ error: "Upload a JPG, PNG, or WebP image." });
        photoMime = match[1].toLowerCase();
        photoBytes = Buffer.from(match[2], "base64");
        if (!photoBytes.length || photoBytes.length > 2 * 1024 * 1024) {
            return res.status(400).json({ error: "Images must be smaller than 2 MB." });
        }
    }

    try {
        const result = await transactionQuery(`INSERT INTO content_update_submissions
            (content_type, content_id, author_id, title, category, body, sources, photo_bytes, photo_mime)
            VALUES ('learn_article', $1, $2, $3, $4, $5, $6, $7, $8)
            RETURNING update_id, status`,
        [req.params.id, req.authUser.id, title, category, body, sources || null, photoBytes, photoMime]);
        res.status(201).json({ message: "Your Learn article update was sent to an admin for review.", update: result.rows[0] });
    } catch (error) {
        if (error.code === "23505") return res.status(409).json({ error: "An update for this article is already awaiting review." });
        throw error;
    }
}));

app.get("/api/learn-submissions/mine", requireRole("Doctor"), asyncRoute(async (req, res) => {
    const result = await pool.query(`SELECT submission_id, title, category, status, submitted_at
        FROM learn_submissions WHERE doctor_id = $1 ORDER BY submitted_at DESC`, [req.authUser.id]);
    res.json(result.rows);
}));

app.post("/api/learn-submissions", requireRole("Doctor"), asyncRoute(async (req, res) => {
    const { title, category, body, sources, imageData } = req.body;
    const cleanTitle = typeof title === "string" ? title.trim() : "";
    const cleanCategory = typeof category === "string" ? category.trim() : "General education";
    const cleanBody = typeof body === "string" ? body.trim() : "";
    const cleanSources = typeof sources === "string" ? sources.trim() : "";

    if (!cleanTitle || cleanTitle.length > 200 || !cleanBody || cleanBody.length > 50000 ||
        cleanCategory.length > 80 || cleanSources.length > 5000) {
        return res.status(400).json({ error: "Check the title, category, article, and source lengths and try again." });
    }

    let photoBytes = null;
    let photoMime = null;
    if (imageData) {
        const match = typeof imageData === "string" && imageData.match(/^data:(image\/(?:jpeg|png|webp));base64,([A-Za-z0-9+/]+={0,2})$/i);
        if (!match) return res.status(400).json({ error: "Upload a JPG, PNG, or WebP image." });
        photoMime = match[1].toLowerCase();
        photoBytes = Buffer.from(match[2], "base64");
        if (!photoBytes.length || photoBytes.length > 2 * 1024 * 1024) {
            return res.status(400).json({ error: "Images must be smaller than 2 MB." });
        }
    }

    const result = await transactionQuery(`INSERT INTO learn_submissions
        (doctor_id, title, category, body, sources, photo_bytes, photo_mime)
        SELECT $1, $2, $3, $4, $5, $6, $7
        WHERE EXISTS (SELECT 1 FROM doctor_hospital WHERE doctor_id = $1)
        RETURNING submission_id, title, category, status, submitted_at`,
    [req.authUser.id, cleanTitle, cleanCategory || "General education", cleanBody, cleanSources || null, photoBytes, photoMime]);
    if (!result.rowCount) return res.status(409).json({ error: "Your doctor account is not linked to a hospital yet, so no hospital admin can review this article." });
    res.status(201).json({ message: "Your Learn article was sent to an admin for review.", submission: result.rows[0] });
}));

app.get("/api/admin/learn-submissions", requireRole("Admin"), asyncRoute(async (req, res) => {
    const result = await pool.query(`SELECT s.submission_id, s.title, s.category, s.body, s.sources,
        s.photo_mime, encode(s.photo_bytes, 'base64') AS photo_base64, s.submitted_at,
        CONCAT(u.first_name, ' ', COALESCE(u.last_name, '')) AS doctor_name
        FROM learn_submissions s JOIN users u ON u.user_id = s.doctor_id
        WHERE s.status = 'pending' AND EXISTS (
            SELECT 1 FROM admins current_admin JOIN doctor_hospital dh ON dh.hospital_id = current_admin.hospital_id
            WHERE current_admin.admin_id = $1 AND dh.doctor_id = s.doctor_id
        ) ORDER BY s.submitted_at ASC`, [req.authUser.id]);
    res.json(result.rows);
}));

app.get("/api/admin/learn-articles", requireRole("Admin"), asyncRoute(async (req, res) => {
    const result = await pool.query(`SELECT a.article_id, a.title, a.category, a.published_at
        FROM learn_articles a
        WHERE EXISTS (SELECT 1 FROM admins current_admin
            JOIN doctor_hospital dh ON dh.hospital_id = current_admin.hospital_id
            WHERE current_admin.admin_id = $1 AND dh.doctor_id = a.doctor_id)
        ORDER BY a.published_at DESC, a.article_id DESC`, [req.authUser.id]);
    res.json(result.rows);
}));

app.post("/api/admin/learn-submissions/:id/approve", requireRole("Admin"), asyncRoute(async (req, res) => {
    try {
        await transactionQuery("CALL approve_learn_submission($1, $2)", [req.params.id, req.authUser.id]);
        res.json({ message: "Learn article approved and published." });
    } catch (error) {
        if (error.code === "P0002") return res.status(404).json({ error: error.message });
        throw error;
    }
}));

app.post("/api/admin/learn-submissions/:id/reject", requireRole("Admin"), asyncRoute(async (req, res) => {
    const result = await transactionQuery(`UPDATE learn_submissions s
        SET status = 'rejected', reviewed_by = $1, reviewed_at = CURRENT_TIMESTAMP
        WHERE s.submission_id = $2 AND s.status = 'pending' AND EXISTS (
            SELECT 1 FROM admins current_admin JOIN doctor_hospital dh ON dh.hospital_id = current_admin.hospital_id
            WHERE current_admin.admin_id = $1 AND dh.doctor_id = s.doctor_id
        ) RETURNING s.submission_id`,
    [req.authUser.id, req.params.id]);
    if (!result.rows.length) return res.status(404).json({ error: "Pending Learn article not found." });
    res.json({ message: "Learn article rejected." });
}));

app.get("/api/learn-articles/:id/photo", asyncRoute(async (req, res) => {
    const result = await pool.query("SELECT photo_bytes, photo_mime FROM learn_articles WHERE article_id = $1", [req.params.id]);
    const article = result.rows[0];
    if (!article?.photo_bytes) return res.status(404).end();
    res.type(article.photo_mime).set("Cache-Control", "public, max-age=3600").send(article.photo_bytes);
}));

app.get("/api/admin/content-updates", requireRole("Admin"), asyncRoute(async (req, res) => {
    const result = await pool.query(`SELECT u.update_id, u.content_type, u.content_id, u.title, u.category,
        u.body, u.sources, u.photo_mime, encode(u.photo_bytes, 'base64') AS photo_base64, u.submitted_at,
        CONCAT(a.first_name, ' ', COALESCE(a.last_name, '')) AS author_name
        FROM content_update_submissions u JOIN users a ON a.user_id = u.author_id
        WHERE u.status = 'pending' AND (u.content_type = 'patient_story' OR EXISTS (
            SELECT 1 FROM learn_articles la JOIN doctor_hospital dh ON dh.doctor_id = la.doctor_id
            JOIN admins current_admin ON current_admin.hospital_id = dh.hospital_id
            WHERE current_admin.admin_id = $1 AND la.article_id = u.content_id
        )) ORDER BY u.submitted_at ASC`, [req.authUser.id]);
    res.json(result.rows);
}));

app.post("/api/admin/content-updates/:id/approve", requireRole("Admin"), asyncRoute(async (req, res) => {
    const client = await pool.connect();
    try {
        await client.query("BEGIN");
        const pending = await client.query(`SELECT u.update_id, u.content_type, u.content_id, u.title, u.category, u.body, u.sources, u.photo_bytes, u.photo_mime
            FROM content_update_submissions u
            WHERE u.update_id = $1 AND u.status = 'pending' AND (u.content_type = 'patient_story' OR EXISTS (
                SELECT 1 FROM learn_articles la JOIN doctor_hospital dh ON dh.doctor_id = la.doctor_id
                JOIN admins current_admin ON current_admin.hospital_id = dh.hospital_id
                WHERE current_admin.admin_id = $2 AND la.article_id = u.content_id
            )) FOR UPDATE`, [req.params.id, req.authUser.id]);
        if (!pending.rows.length) {
            await client.query("ROLLBACK");
            return res.status(404).json({ error: "Pending content update not found." });
        }

        const update = pending.rows[0];
        let saved;
        if (update.content_type === "patient_story") {
            saved = await client.query("UPDATE blogposts SET title = $1, feel = $2 WHERE blog_id = $3 RETURNING blog_id",
                [update.title, update.body, update.content_id]);
        } else {
            saved = await client.query(`UPDATE learn_articles
                SET title = $1, category = $2, body = $3, sources = $4,
                    photo_bytes = COALESCE($5, photo_bytes), photo_mime = COALESCE($6, photo_mime)
                WHERE article_id = $7 RETURNING article_id`,
            [update.title, update.category, update.body, update.sources, update.photo_bytes, update.photo_mime, update.content_id]);
        }
        if (!saved.rows.length) {
            await client.query("ROLLBACK");
            return res.status(404).json({ error: "The published content has been deleted." });
        }
        await client.query(`UPDATE content_update_submissions
            SET status = 'approved', reviewed_by = $1, reviewed_at = CURRENT_TIMESTAMP WHERE update_id = $2`,
        [req.authUser.id, update.update_id]);
        await client.query("COMMIT");
        res.json({ message: "Content update approved and published." });
    } catch (error) {
        await client.query("ROLLBACK");
        throw error;
    } finally {
        client.release();
    }
}));

app.post("/api/admin/content-updates/:id/reject", requireRole("Admin"), asyncRoute(async (req, res) => {
    const result = await transactionQuery(`UPDATE content_update_submissions u
        SET status = 'rejected', reviewed_by = $1, reviewed_at = CURRENT_TIMESTAMP
        WHERE u.update_id = $2 AND u.status = 'pending' AND (u.content_type = 'patient_story' OR EXISTS (
            SELECT 1 FROM learn_articles la JOIN doctor_hospital dh ON dh.doctor_id = la.doctor_id
            JOIN admins current_admin ON current_admin.hospital_id = dh.hospital_id
            WHERE current_admin.admin_id = $1 AND la.article_id = u.content_id
        )) RETURNING u.update_id`, [req.authUser.id, req.params.id]);
    if (!result.rows.length) return res.status(404).json({ error: "Pending content update not found." });
    res.json({ message: "Content update rejected." });
}));

app.delete("/api/admin/blogs/:id", requireRole("Admin"), asyncRoute(async (req, res) => {
    const client = await pool.connect();
    try {
        await client.query("BEGIN");
        const removed = await client.query("DELETE FROM blogposts WHERE blog_id = $1 RETURNING blog_id", [req.params.id]);
        if (!removed.rows.length) {
            await client.query("ROLLBACK");
            return res.status(404).json({ error: "Patient story not found." });
        }
        await client.query(`UPDATE content_update_submissions
            SET status = 'rejected', reviewed_by = $1, reviewed_at = CURRENT_TIMESTAMP
            WHERE content_type = 'patient_story' AND content_id = $2 AND status = 'pending'`,
        [req.authUser.id, req.params.id]);
        await client.query("COMMIT");
        res.json({ message: `Patient story #${req.params.id} deleted.` });
    } catch (error) {
        await client.query("ROLLBACK");
        throw error;
    } finally {
        client.release();
    }
}));

app.delete("/api/admin/learn-articles/:id", requireRole("Admin"), asyncRoute(async (req, res) => {
    const client = await pool.connect();
    try {
        await client.query("BEGIN");
        const removed = await client.query(`DELETE FROM learn_articles la WHERE la.article_id = $1 AND EXISTS (
            SELECT 1 FROM admins current_admin JOIN doctor_hospital dh ON dh.hospital_id = current_admin.hospital_id
            WHERE current_admin.admin_id = $2 AND dh.doctor_id = la.doctor_id
        ) RETURNING la.article_id`, [req.params.id, req.authUser.id]);
        if (!removed.rows.length) {
            await client.query("ROLLBACK");
            return res.status(404).json({ error: "Learn article not found." });
        }
        await client.query(`UPDATE content_update_submissions
            SET status = 'rejected', reviewed_by = $1, reviewed_at = CURRENT_TIMESTAMP
            WHERE content_type = 'learn_article' AND content_id = $2 AND status = 'pending'`,
        [req.authUser.id, req.params.id]);
        await client.query("COMMIT");
        res.json({ message: `Learn article #${req.params.id} deleted.` });
    } catch (error) {
        await client.query("ROLLBACK");
        throw error;
    } finally {
        client.release();
    }
}));

/* =========================
   LOGIN
   ========================= */

app.get("/api/auth/me", authenticate, (req, res) => {
    res.json({ user: { id: req.authUser.id, name: req.authUser.name, role: req.authUser.role } });
});

/**
 * @swagger
 * /api/auth/login:
 *   post:
 *     summary: Authenticate a user
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - contact
 *               - password
 *               - role
 *             properties:
 *               contact:
 *                 type: string
 *                 example: "01700000000"
 *               password:
 *                 type: string
 *                 example: "CancerCare2026"
 *               role:
 *                 type: string
 *                 example: "Patient"
 *     responses:
 *       200:
 *         description: Successful login
 *       400:
 *         description: Missing login information
 *       401:
 *         description: Invalid login information
 */
app.post("/api/auth/login", loginRateLimit, asyncRoute(async (req, res) => {
    const { contact, password, role } = req.body;

    if (typeof contact !== "string" || !/^\+?[0-9]{7,15}$/.test(contact.trim()) || typeof password !== "string" ||
        !password || password.length > 128 || !["Patient", "Doctor", "Admin"].includes(role)) {
        return res.status(400).json({
            error: "Enter your role, mobile number and password."
        });
    }

    const result = await pool.query(`SELECT
        u.user_id,
        u.first_name,
        u.last_name,
        u.contact,
        u.password_hash,
        CASE
            WHEN p.patient_id IS NOT NULL THEN 'Patient'
            WHEN d.doctor_id IS NOT NULL THEN 'Doctor'
            WHEN a.admin_id IS NOT NULL THEN 'Admin'
        END AS account_role
        FROM users u
        LEFT JOIN patient p ON p.patient_id = u.user_id
        LEFT JOIN doctors d ON d.doctor_id = u.user_id
        LEFT JOIN admins a ON a.admin_id = u.user_id
        WHERE u.contact = $1`, [contact.trim()]);

    const user = result.rows[0];

    if (!user || user.account_role !== role) {
        recordLoginFailure(req);
        return res.status(401).json({
            error: "Incorrect role, mobile number, or password."
        });
    }

    const isSeedAccount =
        user.password_hash === "DEMO_HASH_REPLACE_WITH_BCRYPT";

    const valid = isSeedAccount
        ? password === "CancerCare2026"
        : passwordMatches(password, user.password_hash);

    if (!valid) {
        recordLoginFailure(req);
        return res.status(401).json({
            error: "Incorrect role, mobile number, or password."
        });
    }

    if (isSeedAccount) {
        await transactionQuery(
            "UPDATE users SET password_hash = $1 WHERE user_id = $2",
            [hashPassword(password), user.user_id]
        );
    }

    clearLoginFailures(req);

    res.json({
        message: "Signed in successfully.",
        token: createAuthToken(user.user_id, user.account_role),
        user: {
            id: user.user_id,
            name: `${user.first_name} ${user.last_name || ""}`.trim(),
            role: user.account_role
        }
    });
}));

/* =========================
   REGISTER
   ========================= */

/**
 * @swagger
 * /api/auth/register:
 *   post:
 *     summary: Register a new patient
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - firstName
 *               - contact
 *               - password
 *               - address
 *               - district
 *               - area
 *             properties:
 *               firstName:
 *                 type: string
 *                 example: "John"
 *               lastName:
 *                 type: string
 *                 example: "Doe"
 *               contact:
 *                 type: string
 *                 example: "01700000000"
 *               password:
 *                 type: string
 *                 example: "Password123"
 *               address:
 *                 type: string
 *                 example: "Dhaka"
 *               district:
 *                 type: string
 *                 example: "Dhaka"
 *               area:
 *                 type: string
 *                 example: "Mirpur"
 *               gender:
 *                 type: string
 *                 example: "Male"
 *     responses:
 *       201:
 *         description: Patient account created
 *       400:
 *         description: Invalid registration information
 *       409:
 *         description: Mobile number already registered
 */
app.post("/api/auth/register", asyncRoute(async (req, res) => {
    const {
        firstName,
        lastName,
        contact,
        password,
        address,
        district,
        area,
        gender
    } = req.body;

    if (![firstName, contact, password, address, district, area].every(value => typeof value === "string" && value.trim()) ||
        (lastName !== undefined && typeof lastName !== "string") || (gender !== undefined && typeof gender !== "string")) {
        return res.status(400).json({
            error: "Complete all required registration fields."
        });
    }

    if (firstName.trim().length > 30 || (lastName || "").trim().length > 30 ||
        !/^\+?[0-9]{7,15}$/.test(contact.trim()) || address.trim().length > 255 ||
        district.trim().length > 100 || area.trim().length > 100 || (gender && gender.length > 10)) {
        return res.status(400).json({ error: "Check the name, mobile number, and address field lengths." });
    }

    if (password.length < 8 || password.length > 128) {
        return res.status(400).json({
            error: "Use a password between 8 and 128 characters."
        });
    }

    const client = await pool.connect();

    try {
        await client.query("BEGIN");

        const user = await client.query(
            `INSERT INTO users
                (first_name, last_name, contact, password_hash)
             VALUES ($1, $2, $3, $4)
             RETURNING user_id, first_name, last_name`,
            [
                firstName.trim(),
                (lastName || "").trim() || null,
                contact.trim(),
                hashPassword(password)
            ]
        );

        await client.query(
            `INSERT INTO patient
                (patient_id, gender, address, district, area)
             VALUES ($1, $2, $3, $4, $5)`,
            [
                user.rows[0].user_id,
                gender || null,
                address.trim(),
                district.trim(),
                area.trim()
            ]
        );

        await client.query("COMMIT");

        const created = user.rows[0];

        res.status(201).json({
            message: "Your patient account is ready.",
            token: createAuthToken(created.user_id, "Patient"),
            user: {
                id: created.user_id,
                name: `${created.first_name} ${created.last_name || ""}`.trim(),
                role: "Patient"
            }
        });
    } catch (error) {
        await client.query("ROLLBACK");

        if (error.code === "23505") {
            return res.status(409).json({
                error: "That mobile number is already registered."
            });
        }

        throw error;
    } finally {
        client.release();
    }
}));

app.post("/api/doctor-applications", asyncRoute(async (req, res) => {
    const firstName = typeof req.body.firstName === "string" ? req.body.firstName.trim() : "";
    const lastName = typeof req.body.lastName === "string" ? req.body.lastName.trim() : "";
    const contact = typeof req.body.contact === "string" ? req.body.contact.trim() : "";
    const email = typeof req.body.email === "string" ? req.body.email.trim().toLowerCase() : "";
    const password = req.body.password;
    const licenseNo = typeof req.body.licenseNo === "string" ? req.body.licenseNo.trim() : "";
    const qualification = typeof req.body.qualification === "string" ? req.body.qualification.trim() : "";
    const address = typeof req.body.address === "string" ? req.body.address.trim() : "";
    const district = typeof req.body.district === "string" ? req.body.district.trim() : "";
    const area = typeof req.body.area === "string" ? req.body.area.trim() : "";
    const gender = typeof req.body.gender === "string" ? req.body.gender.trim() : "";
    const hospitalId = Number(req.body.hospitalId);
    const fees = Number(req.body.fees);
    const experienceYears = Number(req.body.experienceYears);

    if (!firstName || firstName.length > 30 || lastName.length > 30 ||
        !/^\+?[0-9]{7,15}$/.test(contact) || typeof password !== "string" || password.length < 8 || password.length > 128 ||
        !Number.isInteger(hospitalId) || hospitalId < 1 || !licenseNo || licenseNo.length > 50 ||
        !qualification || qualification.length > 250 || !address || address.length > 255 ||
        district.length > 100 || !area || area.length > 100 || gender.length > 10 ||
        !Number.isFinite(fees) || fees <= 0 || fees > 1000000 ||
        !Number.isInteger(experienceYears) || experienceYears < 0 || experienceYears > 80 ||
        (email && (email.length > 100 || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)))) {
        return res.status(400).json({ error: "Check the required fields, license, contact, qualification, and field lengths." });
    }

    const documentMatch = typeof req.body.licenseDocument === "string" &&
        req.body.licenseDocument.match(/^data:(application\/pdf|image\/(?:jpeg|png|webp));base64,([A-Za-z0-9+/]+={0,2})$/i);
    if (!documentMatch) return res.status(400).json({ error: "Attach license proof as a PDF, JPG, PNG, or WebP file." });
    const documentMime = documentMatch[1].toLowerCase();
    const licenseDocument = Buffer.from(documentMatch[2], "base64");
    if (!licenseDocument.length || licenseDocument.length > 2 * 1024 * 1024) {
        return res.status(400).json({ error: "License proof must be smaller than 2 MB." });
    }

    const hospital = await pool.query("SELECT hospital_id FROM hospitals WHERE hospital_id = $1", [hospitalId]);
    if (!hospital.rowCount) return res.status(400).json({ error: "Choose a hospital from the list." });
    const existing = await pool.query(`SELECT 1 FROM users WHERE contact = $1
        UNION ALL SELECT 1 FROM doctors WHERE license_no = $2
        UNION ALL SELECT 1 FROM doctors WHERE $3::text IS NOT NULL AND lower(email) = $3 LIMIT 1`,
    [contact, licenseNo, email || null]);
    if (existing.rowCount) return res.status(409).json({ error: "That mobile number, license, or email is already registered." });

    try {
        const result = await transactionQuery(`INSERT INTO doctor_registration_applications (
            first_name, last_name, contact, password_hash, hospital_id, license_no, qualification,
            license_document, document_mime, email, fees, gender, address, district, area, experience_years
        ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)
        RETURNING application_id, status, submitted_at`,
        [firstName, lastName || null, contact, hashPassword(password), hospitalId, licenseNo, qualification,
            licenseDocument, documentMime, email || null, fees, gender || null, address, district || null, area, experienceYears]);
        res.status(201).json({
            message: "Doctor application submitted. An administrator at your selected hospital must review your credentials before you can sign in.",
            application: result.rows[0]
        });
    } catch (error) {
        if (error.code === "23505") return res.status(409).json({ error: "A pending application already uses that mobile number, license, or email." });
        throw error;
    }
}));

/* =========================
   FRONTEND
   ========================= */

// Keep unknown API requests from falling through to the single-page app. A
// stale backend otherwise returns index.html with HTTP 404, which hides the
// fact that the running server does not have the requested route yet.
app.use("/api", (_req, res) => {
    res.status(404).json({
        error: "This API route is not available in the running backend. Stop the old server and run `npm start` from the project root."
    });
});

app.use(express.static(path.join(__dirname, "../frontend")));

app.get("*splat", (_req, res) =>
    res.sendFile(path.join(__dirname, "../frontend/index.html"))
);

/* =========================
   START SERVER
   ========================= */

initializeAuthSecret().then(initializeBlogSubmissions).then(initializeLearnArticles).then(initializeContentUpdates).then(initializeDoctorApplications).then(initializeAppointments).then(initializeRatings).then(initializePrescriptionAppointments).then(initializeDatabaseRoutines).then(() => {
    app.listen(PORT, () => {
        console.log(`CancerCare is running at http://localhost:${PORT}`);
        console.log(`Swagger API docs: http://localhost:${PORT}/api-docs`);
    });
}).catch((error) => {
    console.error("Could not initialize CancerCare backend:", error);
    process.exit(1);
});
