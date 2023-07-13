-- Updates the users table by computing the average from corrections

DROP PROCEDURE IF EXISTS ComputeAverageScoreForUser;
DELIMITER $$
CREATE PROCEDURE ComputeAverageScoreForUser  (IN user_id INT)
       BEGIN
            DECLARE avg FLOAT DEFAULT 0;

            -- USER EXISTS:- capture their project_id next
            SET avg = (select sum(score)/count(*) from corrections AS c where c.user_id=user_id group by c.user_id);
            UPDATE users set average_score=avg where id=user_id;

        END$$
DELIMITER ;