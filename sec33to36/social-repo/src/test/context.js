const { randomBytes } = require('crypto');
const { default: migrate } = require('node-pg-migrate');
const format = require('pg-format');
const pool = require('../pool');
const dotenv = require('dotenv');

dotenv.config();

const DEFAULT_OPTS = {
	host: 'localhost',
	port: 5432,
	database: 'socialnetwork-test',
	user: process.env.USERNAME,
	password: process.env.PASSWORD,
};

class Context {
	static async build() {
		// Randomly generate role name
		const roleName = 'a' + randomBytes(4).toString('hex');

		// connect to pg as usual
		await pool.connect(DEFAULT_OPTS);

		// create new role
		await pool.query(
			format('CREATE ROLE %I WITH LOGIN PASSWORD %L;', roleName, roleName)
		);

		// create schema w same name
		await pool.query(
			format('CREATE SCHEMA %I AUTHORIZATION %I;', roleName, roleName)
		);

		// disconnect entirely from PG
		await pool.close();

		// run migration in new schema
		await migrate({
			schema: roleName,
			direction: 'up',
			log: () => {},
			noLock: true,
			dir: 'migrations',
			databaseUrl: {
				host: 'localhost',
				port: 5432,
				database: 'socialnetwork-test',
				user: roleName,
				password: roleName,
			},
		});

		// connect to pg as new role
		await pool.connect({
			host: 'localhost',
			port: 5432,
			database: 'socialnetwork-test',
			user: roleName,
			password: roleName,
		});

		return new Context(roleName);
	}

	constructor(roleName) {
		this.roleName = roleName;
	}

	async close() {
		// discontect from pg
		await pool.close();

		// reconnect as root
		await pool.connect(DEFAULT_OPTS);

		// delete the role and scema we created
		await pool.query(format('DROP SCHEMA %I CASCADE;', this.roleName));
		await pool.query(format('DROP ROLE %I;', this.roleName));

		// disconnect
		await pool.close();
	}

	async reset() {
		pool.query('DELETE FROM users;');
	}
}

module.exports = Context;
