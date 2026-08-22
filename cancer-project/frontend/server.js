import express from 'express';
import pg from 'pg';

const { Pool } = pg;
const app = express();
const port = Number(process.env.API_PORT || 4000);
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  host: process.env.PGHOST || 'localhost',
  port: Number(process.env.PGPORT || 5432),
  database: process.env.PGDATABASE || 'cancercare',
  user: process.env.PGUSER || 'postgres',
  password: process.env.PGPASSWORD
});

app.use(express.json());
app.use((request, response, next) => {
  response.header('Access-Control-Allow-Origin', 'http://localhost:5173');
  response.header('Access-Control-Allow-Headers', 'Content-Type');
  next();
});

app.get('/api/blogposts', async (request, response) => {
  try {
    const result = await pool.query(`
      SELECT
        b.blog_id AS id,
        b.title,
        b.feel,
        b.post_date AS date,
        COUNT(pb.patient_id)::int AS patient_count
      FROM blogposts b
      LEFT JOIN patient_blogpost pb ON pb.blog_id = b.blog_id
      GROUP BY b.blog_id
      ORDER BY b.post_date DESC, b.blog_id DESC
    `);
    response.json(result.rows);
  } catch (error) {
    console.error('Blogpost query failed:', error.message);
    response.status(503).json({ error: 'Database is unavailable.' });
  }
});

app.listen(port, () => {
  console.log(`CancerCare blog API running at http://localhost:${port}`);
});
