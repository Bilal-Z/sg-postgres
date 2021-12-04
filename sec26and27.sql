-- show the username of users who were tagged in a caption or photo before jan 7th 2010
-- SELECT username, tags.created_at
-- FROM users JOIN (
-- 	SELECT user_id, created_at FROM caption_tags 
-- 	UNION ALL 
-- 	SELECT user_id, created_at FROM photo_tags
-- ) AS tags ON tags.user_id = users.id
-- WHERE tags.created_at < '2010-01-07';

-- using simple common table expressions
-- WITH tags AS(
-- 	SELECT user_id, created_at FROM caption_tags 
-- 	UNION ALL 
-- 	SELECT user_id, created_at FROM photo_tags
-- )
-- SELECT username, tags.created_at
-- FROM users 
-- JOIN tags ON tags.user_id = users.id
-- WHERE tags.created_at < '2010-01-07';

-- recuresive CTE
-- WITH RECURSIVE countdown(val) AS (
-- 	SELECT 3 AS val -- Initial/Non-recursive query
-- 	UNION
-- 	SELECT val - 1 FROM countdown WHERE val > 1 -- Recursive query
-- )
-- SELECT * FROM countdown;

-- follow suggestions for user with id 1000 using recursive CTE
-- tree structure suggest following of people already followed (may not be a tree)
WITH RECURSIVE suggestions(leader_id, follower_id, depth) AS (
		SELECT leader_id, follower_id, 1 AS depth 
		FROM followers 
		WHERE follower_id = 1000
	UNION
		SELECT followers.leader_id, followers.follower_id, depth + 1 
		FROM followers
		JOIN suggestions ON suggestions.leader_id = followers.follower_id
		WHERE depth < 3
)
SELECT DISTINCT users.id, users.username
FROM suggestions
JOIN users ON users.id = suggestions.leader_id
WHERE depth > 1
LIMIT 30;