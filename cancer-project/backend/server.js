const path = require("path");
const crypto = require("crypto");
const express = require("express");
const cors = require("cors");
const pool = require("./db");

const app = express();
const PORT = process.env.PORT || 5000;
app.use(cors());
app.use(express.json());

const hashPassword = (password, salt = crypto.randomBytes(16).toString("hex")) => {
    // 24 bytes keeps the encoded hash within the schema's VARCHAR(100) limit.
    const hash = crypto.scryptSync(password, salt, 24).toString("hex");
    return `scrypt$${salt}$${hash}`;
};

const passwordMatches = (password, storedHash) => {
    if (!storedHash || !storedHash.startsWith("scrypt$")) return false;
    const [, salt, expected] = storedHash.split("$");
    const actual = hashPassword(password, salt).split("$")[2];
    return crypto.timingSafeEqual(Buffer.from(actual, "hex"), Buffer.from(expected, "hex"));
};

const asyncRoute = (handler) => async (req, res) => {
    try { await handler(req, res); }
    catch (error) {
        console.error(error);
        res.status(500).json({ error: "We could not load that information right now." });
    }
};

app.get("/api/health", asyncRoute(async (_req, res) => {
    await pool.query("SELECT 1");
    res.json({ status: "connected", message: "CancerCare database is available." });
}));

app.get("/api/overview", asyncRoute(async (_req, res) => {
    const result = await pool.query(`SELECT
        (SELECT COUNT(*) FROM hospitals)::int AS hospitals,
        (SELECT COUNT(*) FROM doctors)::int AS doctors,
        (SELECT COUNT(*) FROM cancers)::int AS cancer_types,
        (SELECT COUNT(*) FROM blogposts)::int AS stories`);
    res.json(result.rows[0]);
}));

app.get("/api/hospitals", asyncRoute(async (req, res) => {
    const search = `%${(req.query.search || "").trim()}%`;
    const result = await pool.query(`SELECT hospital_id, hospital_name, district, area, hospital_type, bed_capacity, phone
        FROM hospitals WHERE hospital_name ILIKE $1 OR area ILIKE $1 OR district ILIKE $1
        ORDER BY CASE hospital_name
            WHEN 'National Institute of Cancer Research & Hospital (NICRH)' THEN 1
            WHEN 'Evercare Hospital Dhaka' THEN 2
            WHEN 'Square Hospital Ltd.' THEN 3
            WHEN 'United Hospital Limited' THEN 4
            WHEN 'Labaid Cancer Hospital & Super Speciality Centre' THEN 5
            WHEN 'Ahsania Mission Cancer & General Hospital' THEN 6
            ELSE 99 END, hospital_name LIMIT 100`, [search]);
    res.json(result.rows);
}));

app.get("/api/hospitals/:id", asyncRoute(async (req, res) => {
    const result = await pool.query(`SELECT hospital_id, hospital_name, registration_no, address, district, area, phone,
        email, established_year, website, bed_capacity, hospital_type FROM hospitals WHERE hospital_id = $1`, [req.params.id]);
    if (!result.rows.length) return res.status(404).json({ error: "Hospital not found" });
    res.json(result.rows[0]);
}));

app.get("/api/doctors", asyncRoute(async (req, res) => {
    const search = `%${(req.query.search || "").trim()}%`;
    const result = await pool.query(`SELECT d.doctor_id, CONCAT(u.first_name, ' ', COALESCE(u.last_name, '')) AS doctor_name,
        d.gender, d.experience_years, d.fees, d.area,
        COALESCE(string_agg(DISTINCT c.cancer_name, ', '), 'Cancer care') AS specialties
        FROM doctors d JOIN users u ON u.user_id = d.doctor_id
        LEFT JOIN doctor_cancer_specialization dcs ON dcs.doctor_id = d.doctor_id
        LEFT JOIN cancers c ON c.cancer_id = dcs.cancer_id
        WHERE CONCAT(u.first_name, ' ', COALESCE(u.last_name, '')) ILIKE $1 OR d.area ILIKE $1
        GROUP BY d.doctor_id, u.first_name, u.last_name
        ORDER BY CASE d.doctor_id
            WHEN 1 THEN 1 WHEN 2 THEN 2 WHEN 5 THEN 3 WHEN 6 THEN 4
            WHEN 7 THEN 5 WHEN 9 THEN 6 WHEN 10 THEN 7 ELSE 99 END,
            d.experience_years DESC NULLS LAST LIMIT 12`, [search]);
    res.json(result.rows);
}));

app.get("/api/cancers", asyncRoute(async (_req, res) => {
    const result = await pool.query(`SELECT c.cancer_id, c.cancer_name, c.causes,
        COUNT(DISTINCT hc.hospital_id)::int AS hospital_count FROM cancers c
        LEFT JOIN hospital_cancer hc ON hc.cancer_id = c.cancer_id
        GROUP BY c.cancer_id ORDER BY CASE c.cancer_name
            WHEN 'Female breast cancer' THEN 1 WHEN 'Lung cancer' THEN 2
            WHEN 'Cervical cancer' THEN 3 WHEN 'Oral cavity cancer' THEN 4
            WHEN 'Colorectal cancer' THEN 5 WHEN 'Prostate cancer' THEN 6
            ELSE 99 END, c.cancer_name LIMIT 12`);
    res.json(result.rows);
}));

app.get("/api/blogs", asyncRoute(async (_req, res) => {
    const result = await pool.query("SELECT blog_id, title, feel, post_date FROM blogposts ORDER BY post_date DESC, blog_id DESC LIMIT 3");
    res.json(result.rows);
}));

app.post("/api/auth/login", asyncRoute(async (req, res) => {
    const { contact, password, role } = req.body;
    if (!contact || !password || !role) return res.status(400).json({ error: "Enter your role, mobile number and password." });
    const result = await pool.query(`SELECT u.user_id, u.first_name, u.last_name, u.contact, u.password_hash,
        CASE WHEN p.patient_id IS NOT NULL THEN 'Patient'
             WHEN d.doctor_id IS NOT NULL THEN 'Doctor'
             WHEN a.admin_id IS NOT NULL THEN 'Admin' END AS account_role
        FROM users u LEFT JOIN patient p ON p.patient_id = u.user_id
        LEFT JOIN doctors d ON d.doctor_id = u.user_id
        LEFT JOIN admins a ON a.admin_id = u.user_id WHERE u.contact = $1`, [contact.trim()]);
    const user = result.rows[0];
    if (!user || user.account_role !== role) return res.status(401).json({ error: "Those sign-in details do not match an account of this type." });
    const isSeedAccount = user.password_hash === "DEMO_HASH_REPLACE_WITH_BCRYPT";
    const valid = isSeedAccount ? password === "CancerCare2026" : passwordMatches(password, user.password_hash);
    if (!valid) return res.status(401).json({ error: "Incorrect mobile number or password." });
    if (isSeedAccount) await pool.query("UPDATE users SET password_hash = $1 WHERE user_id = $2", [hashPassword(password), user.user_id]);
    res.json({ message: "Signed in successfully.", user: { id: user.user_id, name: `${user.first_name} ${user.last_name || ""}`.trim(), role: user.account_role } });
}));

app.post("/api/auth/register", asyncRoute(async (req, res) => {
    const { firstName, lastName, contact, password, address, district, area, gender } = req.body;
    if (![firstName, contact, password, address, district, area].every(value => typeof value === "string" && value.trim())) {
        return res.status(400).json({ error: "Complete all required registration fields." });
    }
    if (password.length < 8) return res.status(400).json({ error: "Use a password with at least 8 characters." });
    const client = await pool.connect();
    try {
        await client.query("BEGIN");
        const user = await client.query(`INSERT INTO users (first_name, last_name, contact, password_hash)
            VALUES ($1, $2, $3, $4) RETURNING user_id, first_name, last_name`,
            [firstName.trim(), (lastName || "").trim() || null, contact.trim(), hashPassword(password)]);
        await client.query(`INSERT INTO patient (patient_id, gender, address, district, area)
            VALUES ($1, $2, $3, $4, $5)`, [user.rows[0].user_id, gender || null, address.trim(), district.trim(), area.trim()]);
        await client.query("COMMIT");
        const created = user.rows[0];
        res.status(201).json({ message: "Your patient account is ready.", user: { id: created.user_id, name: `${created.first_name} ${created.last_name || ""}`.trim(), role: "Patient" } });
    } catch (error) {
        await client.query("ROLLBACK");
        if (error.code === "23505") return res.status(409).json({ error: "That mobile number is already registered." });
        throw error;
    } finally { client.release(); }
}));

app.use(express.static(path.join(__dirname, "../frontend")));
app.get("*splat", (_req, res) => res.sendFile(path.join(__dirname, "../frontend/index.html")));
app.listen(PORT, () => console.log(`CancerCare is running at http://localhost:${PORT}`));
