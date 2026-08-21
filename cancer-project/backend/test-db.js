const pool = require("./db");

async function testHospitals() {
    try {
        const result = await pool.query(`
            SELECT *
            FROM hospitals
            LIMIT 5;
        `);

        console.log("Hospitals found:", result.rows.length);
        console.table(result.rows);
    } catch (error) {
        console.error("Failed to read hospitals table:");
        console.error(error.message);
    } finally {
        await pool.end();
    }
}

testHospitals();