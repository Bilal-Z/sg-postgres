const pg = require('pg');
const dotenv = require('dotenv');

dotenv.config();

const pool = new pg.Pool({
	host: 'localhost',
	port: 5432,
	database: 'socialnetwork',
	user: process.env.USERNAME,
	password: process.env.PASSWORD,
});

pool
	.query(
		`
	UPDATE posts
	SET loc = POINT(lng, lat)
	WHERE loc IS NULL;
`
	)
	.then(() => {
		console.log('update complete');
		pool.end();
	})
	.catch((err) => console.error(err.message));
