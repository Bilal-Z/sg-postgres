const request = require('supertest');
const buildApp = require('../../app');
const UserRepo = require('../../repos/user-repo');
const Context = require('../context');

let context;

beforeAll(async () => {
	context = await Context.build();
});

afterAll(() => {
	return context.close();
});

beforeEach(async () => {
	await context.reset();
});

it('create a user', async () => {
	const startingCount = await UserRepo.count();

	await request(buildApp())
		.post('/users')
		.send({ username: 'testuser', bio: 'test bio' })
		.expect(200);

	const finishedCount = await UserRepo.count();
	expect(finishedCount - startingCount).toEqual(1);
});
