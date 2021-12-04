-- statistics for tables
-- SELECT * FROM pg_stats WHERE tablename = 'users';

-- EXPLAIN SELECT * FROM likes WHERE created_at < '2013-01-01';

-- CREATE INDEX ON likes (created_at);

-- uses index
-- EXPLAIN SELECT * FROM likes WHERE created_at < '2013-01-01';

-- uses sequential scan to avoid random lookup penalties
EXPLAIN SELECT * FROM likes WHERE created_at > '2013-01-01';