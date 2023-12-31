-- Procedure to Update bonus projects of a student
-- Adds a project if not exist b4
-- Adds a New Entry to Corrections Table with 
-- user_id , project Id + correction score

DELIMITER $$
CREATE PROCEDURE AddBonus (IN user_id INT, IN project_name VARCHAR(255), IN score INT)
       BEGIN
            DECLARE proj_id INT DEFAULT 0;
            DECLARE users_id INT DEFAULT 0;
            SET users_id = (SELECT id FROM projects WHERE id=user_id);
            IF users_id > 0 THEN
                -- USER EXISTS:- capture their project_id next
                SET proj_id = (SELECT id FROM projects WHERE name=project_name);
                IF proj_id > 1 THEN
                    -- PROJECT NAME EXISTS
                    INSERT INTO corrections(user_id,project_id,score) VALUES(user_id,proj_id,score);
                ELSE
                    -- PROJECT NAME DOES NOT EXIST THEREFORE CREATE IT
                    INSERT INTO projects(name) VALUES (project_name);
                    -- RETURN LAST INSERT ROW ID AUTO_INCREMENT HAS BEEN SET HERE
                    SET proj_id = (SELECT LAST_INSERT_ID());
                    INSERT INTO corrections(user_id,project_id,score) VALUES(user_id,proj_id,score);

                END IF;

            END IF;

        END$$
DELIMITER ;