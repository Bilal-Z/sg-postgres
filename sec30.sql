-- CREATE TABLE accounts (
-- 	id SERIAL PRIMARY KEY,
-- 	name VARCHAR(20) NOT NULL,
-- 	balance INTEGER NOT NULL
-- );

-- INSERT INTO accounts (name, balance)
-- VALUES ('Gia', 100), ('Alyson', 100);

-- SELECT * FROM accounts;

-- BEGIN; -- start transaction

-- UPDATE accounts
-- SET balance = balance - 50
-- WHERE name = 'Alyson';

-- SELECT * FROM accounts;

-- UPDATE accounts
-- SET balance = balance + 50
-- WHERE name = 'Gia';

-- SELECT * FROM accounts;

-- COMMIT;

-- SELECT * FROM accounts;

-- UPDATE accounts SET balance = 100;

-- SELECT * FROM accounts;

-- simulate crash
-- BEGIN;

-- UPDATE accounts
-- SET balance = balance - 50
-- WHERE name = 'Alyson';

-- SELECT * FROM accounts;

-- kill connection

-- SELECT * FROM accounts;

-- ROLLBACK;