-- find most popular users by tags
-- SELECT username, COUNT(*)
-- FROM users
-- JOIN (
-- 	SELECT user_id FROM photo_tags
-- 	UNION ALL
-- 	SELECT user_id FROM caption_tags
-- ) AS tags ON tags.user_id = users.id
-- GROUP BY username
-- ORDER BY COUNT(*) DESC;

-- create a view
-- CREATE VIEW tags AS (
-- 	SELECT id, created_at, user_id, post_id, 'photo_tag' AS type FROM photo_tags
-- 	UNION ALL
-- 	SELECT id, created_at, user_id, post_id, 'caption_tag' AS type FROM caption_tags
-- );

-- SELECT * FROM tags;

-- delete view
-- DROP VIEW tags;

-- find most popular users by tags using view
-- SELECT username, COUNT(*)
-- FROM users
-- JOIN tags ON tags.user_id = users.id
-- GROUP BY username
-- ORDER BY COUNT(*) DESC;

-- view for 10 most recent post
-- CREATE VIEW recent_posts AS (
-- 	SELECT * 
-- 	FROM posts
-- 	ORDER BY created_at DESC
-- 	LIMIT 10
-- );

-- SELECT * FROM recent_posts;

-- Show users who created the 10 most recent posts
-- SELECT username FROM recent_posts JOIN users ON users.id = recent_posts.user_id;

-- update view to show 15 most recent posts
-- CREATE OR REPLACE VIEW recent_posts AS (
-- 	SELECT * 
-- 	FROM posts
-- 	ORDER BY created_at DESC
-- 	LIMIT 15
-- );

-- materialized views

-- for each week show the number of likes that posts and comments recieved.
-- Use the post and comment created_at date not when the like was recieved.
-- simple query
-- SELECT 
-- 	date_trunc('week', COALESCE(posts.created_at, comments.created_at)) AS week,
-- 	COUNT(posts.id) AS num_likes_for_posts,
-- 	COUNT(comments.id) AS num_likes_for_comments
-- FROM likes
-- LEFT JOIN posts ON posts.id = likes.post_id
-- LEFT JOIN comments ON comments.id = likes.comment_id
-- GROUP BY week
-- ORDER BY week;
-- with materialized view
-- CREATE MATERIALIZED VIEW weekly_likes AS(
-- SELECT 
-- 	date_trunc('week', COALESCE(posts.created_at, comments.created_at)) AS week,
-- 	COUNT(posts.id) AS num_likes_for_posts,
-- 	COUNT(comments.id) AS num_likes_for_comments
-- FROM likes
-- LEFT JOIN posts ON posts.id = likes.post_id
-- LEFT JOIN comments ON comments.id = likes.comment_id
-- GROUP BY week
-- ORDER BY week
-- ) WITH DATA; -- with data means auto run on create and hold onto results

-- SELECT * FROM weekly_likes;

-- REFRESH MATERIALIZED VIEW weekly_likes;