-- CREATE INDEX ON users (username);
-- DROP INDEX users_username_idx;
-- BENCHMARKING QUERY
-- EXPLAIN ANALYZE SELECT * FROM users WHERE username = 'Emil30';

-- See size of table
-- SELECT pg_size_pretty(pg_relation_size('users'));
-- See size of index
-- SELECT pg_size_pretty(pg_relation_size('users_username_idx'));

-- SELECT all indexes in DB
-- SELECT relname, relkind FROM pg_class WHERE relkind = 'i';

-- functions to inspect data of each page of index
-- CREATE EXTENSION pageinspect;

-- see which page has root
-- SELECT * FROM bt_metap('users_username_idx');

-- get 3rd page (root node)
-- compare data column with where clause the go to ctid (means index in root node)
-- SELECT * from bt_page_items('users_username_idx', 3);

-- ctid(page, index)
-- first row pointer to next leaf node's first record
-- SELECT ctid, * FROM users WHERE username = 'Aaliyah.Hintz';
