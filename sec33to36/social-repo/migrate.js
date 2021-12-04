const migrate = require('node-pg-migrate');
const dotenv = require('dotenv');

dotenv.config();
const url = `postgres://${process.env.USERNAME}:${process.env.PASSWORD}@localhost:5432/socialnetwork`;
const options = {
	databaseUrl: url,
	dir: 'migrations',
	migrationsTable: 'pgmigrations',
};

if (
	process.argv[2] == '-u' ||
	process.argv[2] == 'u' ||
	process.argv[2] == 'up' ||
	process.argv[2] == undefined
) {
	options.direction = 'up';
	migrate.default(options);
} else if (
	process.argv[2] == '-d' ||
	process.argv[2] == 'd' ||
	process.argv[2] == 'down'
) {
	options.direction = 'down';
	migrate.default(options);
}
