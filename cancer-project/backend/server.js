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
const AUTH_SECRET = process.env.AUTH_SECRET || crypto.randomBytes(32);

app.use(cors());
app.use(express.json({ limit: "4mb" }));

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

const createAuthToken = (userId) => {
    const expiresAt = Date.now() + 12 * 60 * 60 * 1000;
    const value = `${userId}.${expiresAt}`;
    const signature = crypto.createHmac("sha256", AUTH_SECRET).update(value).digest("hex");
    return `${value}.${signature}`;
};

const requireRole = (role) => async (req, res, next) => {
    try {
        const [userId, expiresAt, signature] = (req.headers.authorization || "")
            .replace(/^Bearer\s+/i, "")
            .split(".");
        const value = `${userId}.${expiresAt}`;
        const expected = crypto.createHmac("sha256", AUTH_SECRET).update(value).digest("hex");
        const validSignature = signature && signature.length === expected.length &&
            crypto.timingSafeEqual(Buffer.from(signature), Buffer.from(expected));

        if (!/^\d+$/.test(userId || "") || Number(expiresAt) <= Date.now() || !validSignature) {
            return res.status(401).json({ error: "Please sign in again to continue." });
        }

        const result = await pool.query(`SELECT u.user_id, p.patient_id, d.doctor_id, a.admin_id
            FROM users u
            LEFT JOIN patient p ON p.patient_id = u.user_id
            LEFT JOIN doctors d ON d.doctor_id = u.user_id
            LEFT JOIN admins a ON a.admin_id = u.user_id
            WHERE u.user_id = $1`, [userId]);
        const account = result.rows[0];
        if (!account || (role === "Patient" && !account.patient_id) ||
            (role === "Doctor" && !account.doctor_id) || (role === "Admin" && !account.admin_id)) {
            return res.status(403).json({ error: "You do not have permission to do that." });
        }

        req.authUser = { id: Number(userId), role };
        next();
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "We could not verify your account right now." });
    }
};

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

const initializeDatabaseRoutines = async () => {
    const sql = await fs.readFile(path.join(__dirname, "submission_audit.sql"), "utf8");
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
        d.area,
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
        WHERE CONCAT(u.first_name, ' ', COALESCE(u.last_name, '')) ILIKE $1
           OR d.area ILIKE $1
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
        const result = await pool.query(`INSERT INTO content_update_submissions
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
    if (!title || !body || title.length > 200 || body.length > 10000) {
        return res.status(400).json({ error: "Add a title and a story (up to 10,000 characters)." });
    }

    const result = await pool.query(`INSERT INTO blog_submissions (patient_id, title, body)
        VALUES ($1, $2, $3) RETURNING submission_id, title, status, submitted_at`,
    [req.authUser.id, title, body]);
    res.status(201).json({ message: "Your story was sent to an admin for review.", submission: result.rows[0] });
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
        await pool.query("CALL approve_blog_submission($1, $2)", [req.params.id, req.authUser.id]);
        res.json({ message: "Story approved and published." });
    } catch (error) {
        if (error.code === "P0002") return res.status(404).json({ error: error.message });
        throw error;
    }
}));

app.post("/api/admin/blog-submissions/:id/reject", requireRole("Admin"), asyncRoute(async (req, res) => {
    const result = await pool.query(`UPDATE blog_submissions
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
    const owned = await pool.query("SELECT 1 FROM learn_articles WHERE doctor_id = $1 AND article_id = $2",
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
        const result = await pool.query(`INSERT INTO content_update_submissions
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

    const result = await pool.query(`INSERT INTO learn_submissions
        (doctor_id, title, category, body, sources, photo_bytes, photo_mime)
        VALUES ($1, $2, $3, $4, $5, $6, $7)
        RETURNING submission_id, title, category, status, submitted_at`,
    [req.authUser.id, cleanTitle, cleanCategory || "General education", cleanBody, cleanSources || null, photoBytes, photoMime]);
    res.status(201).json({ message: "Your Learn article was sent to an admin for review.", submission: result.rows[0] });
}));

app.get("/api/admin/learn-submissions", requireRole("Admin"), asyncRoute(async (_req, res) => {
    const result = await pool.query(`SELECT s.submission_id, s.title, s.category, s.body, s.sources,
        s.photo_mime, encode(s.photo_bytes, 'base64') AS photo_base64, s.submitted_at,
        CONCAT(u.first_name, ' ', COALESCE(u.last_name, '')) AS doctor_name
        FROM learn_submissions s JOIN users u ON u.user_id = s.doctor_id
        WHERE s.status = 'pending' ORDER BY s.submitted_at ASC`);
    res.json(result.rows);
}));

app.post("/api/admin/learn-submissions/:id/approve", requireRole("Admin"), asyncRoute(async (req, res) => {
    try {
        await pool.query("CALL approve_learn_submission($1, $2)", [req.params.id, req.authUser.id]);
        res.json({ message: "Learn article approved and published." });
    } catch (error) {
        if (error.code === "P0002") return res.status(404).json({ error: error.message });
        throw error;
    }
}));

app.post("/api/admin/learn-submissions/:id/reject", requireRole("Admin"), asyncRoute(async (req, res) => {
    const result = await pool.query(`UPDATE learn_submissions
        SET status = 'rejected', reviewed_by = $1, reviewed_at = CURRENT_TIMESTAMP
        WHERE submission_id = $2 AND status = 'pending' RETURNING submission_id`,
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

app.get("/api/admin/content-updates", requireRole("Admin"), asyncRoute(async (_req, res) => {
    const result = await pool.query(`SELECT u.update_id, u.content_type, u.content_id, u.title, u.category,
        u.body, u.sources, u.photo_mime, encode(u.photo_bytes, 'base64') AS photo_base64, u.submitted_at,
        CONCAT(a.first_name, ' ', COALESCE(a.last_name, '')) AS author_name
        FROM content_update_submissions u JOIN users a ON a.user_id = u.author_id
        WHERE u.status = 'pending' ORDER BY u.submitted_at ASC`);
    res.json(result.rows);
}));

app.post("/api/admin/content-updates/:id/approve", requireRole("Admin"), asyncRoute(async (req, res) => {
    const client = await pool.connect();
    try {
        await client.query("BEGIN");
        const pending = await client.query(`SELECT update_id, content_type, content_id, title, category, body, sources, photo_bytes, photo_mime
            FROM content_update_submissions WHERE update_id = $1 AND status = 'pending' FOR UPDATE`, [req.params.id]);
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
    const result = await pool.query(`UPDATE content_update_submissions
        SET status = 'rejected', reviewed_by = $1, reviewed_at = CURRENT_TIMESTAMP
        WHERE update_id = $2 AND status = 'pending' RETURNING update_id`, [req.authUser.id, req.params.id]);
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
        const removed = await client.query("DELETE FROM learn_articles WHERE article_id = $1 RETURNING article_id", [req.params.id]);
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
app.post("/api/auth/login", asyncRoute(async (req, res) => {
    const { contact, password, role } = req.body;

    if (!contact || !password || !role) {
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
        return res.status(401).json({
            error: "Those sign-in details do not match an account of this type."
        });
    }

    const isSeedAccount =
        user.password_hash === "DEMO_HASH_REPLACE_WITH_BCRYPT";

    const valid = isSeedAccount
        ? password === "CancerCare2026"
        : passwordMatches(password, user.password_hash);

    if (!valid) {
        return res.status(401).json({
            error: "Incorrect mobile number or password."
        });
    }

    if (isSeedAccount) {
        await pool.query(
            "UPDATE users SET password_hash = $1 WHERE user_id = $2",
            [hashPassword(password), user.user_id]
        );
    }

    res.json({
        message: "Signed in successfully.",
        token: createAuthToken(user.user_id),
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

    if (
        ![firstName, contact, password, address, district, area]
            .every(value => typeof value === "string" && value.trim())
    ) {
        return res.status(400).json({
            error: "Complete all required registration fields."
        });
    }

    if (password.length < 8) {
        return res.status(400).json({
            error: "Use a password with at least 8 characters."
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
            token: createAuthToken(created.user_id),
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

/* =========================
   FRONTEND
   ========================= */

app.use(express.static(path.join(__dirname, "../frontend")));

app.get("*splat", (_req, res) =>
    res.sendFile(path.join(__dirname, "../frontend/index.html"))
);

/* =========================
   START SERVER
   ========================= */

initializeBlogSubmissions().then(initializeLearnArticles).then(initializeContentUpdates).then(initializeDatabaseRoutines).then(() => {
    app.listen(PORT, () => {
        console.log(`CancerCare is running at http://localhost:${PORT}`);
        console.log(`Swagger API docs: http://localhost:${PORT}/api-docs`);
    });
}).catch((error) => {
    console.error("Could not initialize blog submissions:", error);
    process.exit(1);
});
