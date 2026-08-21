const express = require("express");
const cors = require("cors");
const pool = require("./db");

const app = express();

app.use(cors());
app.use(express.json());


// Test route
app.get("/", (req, res) => {
    res.json({
        message: "Cancer Care API is running"
    });
});


// Get all hospitals
app.get("/api/hospitals", async (req, res) => {
    try {
        const result = await pool.query(`
            SELECT
                hospital_id,
                hospital_name
            FROM hospitals
            ORDER BY hospital_name;
        `);

        res.json(result.rows);

    } catch (error) {
        console.error(error);

        res.status(500).json({
            error: "Failed to fetch hospitals"
        });
    }
});


// Get one hospital by ID
app.get("/api/hospitals/:id", async (req, res) => {
    try {
        const hospitalId = req.params.id;

        const result = await pool.query(`
            SELECT
                hospital_id,
                hospital_name,
                registration_no,
                address,
                district,
                area,
                phone,
                email,
                established_year,
                website,
                bed_capacity,
                hospital_type
            FROM hospitals
            WHERE hospital_id = $1;
        `, [hospitalId]);

        if (result.rows.length === 0) {
            return res.status(404).json({
                error: "Hospital not found"
            });
        }

        res.json(result.rows[0]);

    } catch (error) {
        console.error(error);

        res.status(500).json({
            error: "Failed to fetch hospital"
        });
    }
});


// Start server
const PORT = 5000;

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});