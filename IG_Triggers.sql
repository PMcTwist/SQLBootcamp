USE ig_clone;

DELIMITER $$

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

DELIMITER ;
