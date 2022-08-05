USE ig_clone;

DELIMITER $$
-- No Self follows allowed trigger
CREATE TRIGGER prevent_self_follows
	BEFORE INSERT ON `ig_clone`.follows FOR EACH ROW
    BEGIN
		IF NEW.follower_id = NEW.followee_id
        THEN
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "You can't follow yourself!";
        END IF;
	END;

$$
-- Log un-follow events
CREATE TRIGGER log_unfollow
	AFTER DELETE ON `ig_clone`.follows FOR EACH ROW
    BEGIN
		INSERT INTO `ig_clone`.unfollows
        SET 
        follower_id = OLD.follower_id,
		followee_id = OLD.followee_id;
	END;

DELIMITER ;
