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
           IF NEW.email != OLD.email and OLD.valid_email = 1 THEN
                SET NEW.valid_email=0; 
            END IF;

END$$
DELIMITER ;
-- Create Trigger `holberton`.`orders_AINS` AFTER INSERT ON `holberton`.`orders` FOR EACH ROW UPDATE items SET quantity=quantity - NEW.number where name=New.item_name;