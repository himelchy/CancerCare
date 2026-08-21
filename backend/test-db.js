const pool = require("./db");

async function testConnection() {
    try {
        const result = await pool.query(
            "SELECT current_database(), current_user"
        );

        console.log("Database connected successfully!");
        console.log("Database:", result.rows[0].current_database);
        console.log("User:", result.rows[0].current_user);

        await pool.end();
    } catch (error) {
        console.error("Database connection failed!");
        console.error(error.message);
    }
}

testConnection();