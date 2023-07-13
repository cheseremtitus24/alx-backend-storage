-- creates a table users and prior to creating
-- it checks whether the table exists so as to handle
-- errors that the DB might throw when the given table
-- name already exists.
-- Moreover, it implements Usage of enum and sets a default
CREATE TABLE IF NOT EXISTS users (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, email VARCHAR(255) NOT NULL UNIQUE, name VARCHAR(255), country ENUM('US','CO','TN') NOT NULL DEFAULT 'US' )