const app = require('./src/app');
const pool = require('./src/pool');
const dotenv = require('dotenv');

dotenv.config();

pool
	.connect({
		host: 'localhost',
		port: 5432,
		database: 'socialnetwork',
		user: process.env.USERNAME,
		password: process.env.PASSWORD,
	})
	.then(() => {
		app().listen(3005, () => {
			console.log('Listening on port 3005');
		});
	})
	.catch((err) => console.error(err));
