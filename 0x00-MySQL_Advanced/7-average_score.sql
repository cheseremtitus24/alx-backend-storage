-- Updates the users table by computing the average from corrections

DELIMITER $$
CREATE PROCEDURE ComputeAverageScoreForUser  (IN user_id INT)
       BEGIN
            DECLARE users_id INT DEFAULT 0;
            DECLARE avg FLOAT DEFAULT 0;
            SELECT id INTO users_id FROM projects WHERE id=user_id;
            IF users_id > 0 THEN
                -- USER EXISTS:- capture their project_id next
                select sum(score)/count(*) INTO avg from corrections where user_id=users_id group by user_id;
                UPDATE users set average_score=avg where user_id=users_id;
            END IF;

        END$$
DELIMITER ;