# Mysql Triggers

Basic Syntax
CREATE     
[DEFINER = { user | CURRENT_USER }]     
TRIGGER trigger_name     
trigger_time trigger_event     
ON tbl_name FOR EACH ROW     
trigger_body

> For multiline trigger body use Begin ... End Block

DELIMITER $$
USE `hr` $$
CREATE 
    DEFINER=`root`@`127.0.0.1` 
    TRIGGER `hr`.`emp_details_AINS` 
        AFTER INSERT ON `hr`.`emp_details`
            FOR EACH ROW
-- Edit trigger body code below this line. Do not edit lines above this one BEGIN 
                INSERT INTO log_emp_details VALUES(NEW.employee_id, NEW.salary, NOW());
END$$
