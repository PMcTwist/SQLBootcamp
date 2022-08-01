-- Select 5 oldest users
SELECT *
FROM `ig_clone`.users
ORDER BY created_at
LIMIT 5;

-- What day of the week is most used to register
SELECT 
    DAYNAME(created_at) AS Day,
    COUNT(*) AS Total
FROM `ig_clone`.users
GROUP BY Day
ORDER BY Total DESC;

-- Find inactive Users
SELECT 
	username
FROM `ig_clone`.users
LEFT JOIN `ig_clone`.photos
	ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- Find most popular post
SELECT 
	username,
	photos.id, 
    photos.image_url, 
    COUNT(*) AS Total
FROM photos
INNER JOIN likes
	ON `ig_clone`.likes.photo_id = `ig_clone`.photos.id
INNER JOIN users
	ON photos.user_id = users.id
GROUP BY `ig_clone`.photos.id
ORDER BY Total DESC
LIMIT 1;

-- Calculate ave posts per user
SELECT 
	ROUND((SELECT COUNT(*) FROM `ig_clone`.photos) 
    / 
    (SELECT COUNT(*) FROM `ig_clone`.users), 2) AS "Avg Post Per User";
    
-- 5 most common hashtags
SELECT 
	tags.tag_name,
    COUNT(*) AS Total
FROM `ig_clone`.tags
JOIN `ig_clone`.photo_tags
	ON `ig_clone`.tags.id = `ig_clone`.photo_tags.tag_id
GROUP BY `ig_clone`.tags.id
ORDER BY Total DESC
LIMIT 5;

-- Find bots that like stuff
SELECT
	username,
    COUNT(*) AS 'Total Likes'
FROM `ig_clone`.users
INNER JOIN `ig_clone`.likes
	ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING COUNT(*) = (SELECT COUNT(*) FROM `ig_clone`.photos);

