-- -----------------------------------------------------
-- Makes the database if it's not already created
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS ig_clone;
USE ig_clone;


-- -----------------------------------------------------
-- Create user table if needed
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ig_clone`.users(
	id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(200) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ------------------------------------------------------
-- Create Photo table
-- ------------------------------------------------------
CREATE TABLE IF NOT EXISTS `ig_clone`.photos(
	id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(200) NOT NULL,
    caption VARCHAR(200),
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

-- -------------------------------------------------------
-- Create Comments Table
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS `ig_clone`.comments(
	id INT AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(200) NOT NULL,
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id)
);

-- ------------------------------------------------------
-- Create Likes table
-- ------------------------------------------------------
CREATE TABLE IF NOT EXISTS `ig_clone`.likes(
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photo(id),
    -- Stops duplicate likes from same user on same photo.
    PRIMARY KEY(user_id, photo_id)
);

-- ------------------------------------------------------
-- Creates Hashtags tables
-- ------------------------------------------------------
CREATE TABLE IF NOT EXISTS `ig_clone`.tags(
	id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(200) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS `ig_clone`.photo_tags(
	photo_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);

-- -------------------------------------------------------
-- Create Follow table
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS `ig_clone`.follows(
	follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    -- Stops multiple follow relationships of the same combo.
    PRIMARY KEY(follower_id, followee_id)
);

-- -------------------------------------------------------
-- Create UnFollow table
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS `ig_clone`.unfollows(
	follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    -- Stops multiple follow relationships of the same combo.
    PRIMARY KEY(follower_id, followee_id)
);
