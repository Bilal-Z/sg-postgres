-- three users with highest ids
-- SELECT * FROM users ORDER BY id DESC LIMIT 3;

-- post with a particular user
-- SELECT username, caption from users JOIN posts ON posts.user_id = users.id WHERE users.id = 200;

-- likes per user
SELECT username, COUNT(*) FROM users JOIN likes ON likes.user_id = users.id GROUP BY username;