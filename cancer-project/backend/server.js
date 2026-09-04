const path = require("path");
const express = require("express");
const cors = require("cors");
const pool = require("./db");

const app = express();
const PORT = process.env.PORT || 5000;
app.use(cors());
app.use(express.json());

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
        ORDER BY hospital_name LIMIT 100`, [search]);
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
        ORDER BY d.experience_years DESC NULLS LAST, doctor_name LIMIT 12`, [search]);
    res.json(result.rows);
}));

app.get("/api/cancers", asyncRoute(async (_req, res) => {
    const result = await pool.query(`SELECT c.cancer_id, c.cancer_name, c.causes,
        COUNT(DISTINCT hc.hospital_id)::int AS hospital_count FROM cancers c
        LEFT JOIN hospital_cancer hc ON hc.cancer_id = c.cancer_id
        GROUP BY c.cancer_id ORDER BY c.cancer_name LIMIT 12`);
    res.json(result.rows);
}));

app.get("/api/blogs", asyncRoute(async (_req, res) => {
    const result = await pool.query("SELECT blog_id, title, feel, post_date FROM blogposts ORDER BY post_date DESC, blog_id DESC LIMIT 3");
    res.json(result.rows);
}));

app.use(express.static(path.join(__dirname, "../frontend")));
app.get("*splat", (_req, res) => res.sendFile(path.join(__dirname, "../frontend/index.html")));
app.listen(PORT, () => console.log(`CancerCare is running at http://localhost:${PORT}`));
