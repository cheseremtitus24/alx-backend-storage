-- creates a trigger that updates email Validation
-- before an update on the email column completes

DELIMITER $$
CREATE 
    DEFINER=CURRENT_USER 
    TRIGGER `users_BUPD` 
        BEFORE UPDATE ON `users`
            FOR EACH ROW
-- Edit trigger body code below this line. Do not edit lines above this one BEGIN 
BEGIN
           IF NEW.email != OLD.email THEN
                SET NEW.valid_email=0; 
            ENDIF;

END$$
DELIMITER ;