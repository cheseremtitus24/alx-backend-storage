-- creates a trigger that update the quantity of items left
-- in store after a successful order placement.
-- it allows the items quantity in stock to go below 0.

DELIMITER $$
USE `holberton` $$
CREATE 
    DEFINER=CURRENT_USER 
    TRIGGER `holberton`.`orders_AINS` 
        AFTER INSERT ON `holberton`.`orders`
            FOR EACH ROW
-- Edit trigger body code below this line. Do not edit lines above this one BEGIN 
BEGIN
                UPDATE items set quantity=quantity - NEW.number WHERE name=New.item_name;
END$$
DELIMITER ;
-- Create Trigger `holberton`.`orders_AINS` AFTER INSERT ON `holberton`.`orders` FOR EACH ROW UPDATE items SET quantity=quantity - NEW.number where name=New.item_name;