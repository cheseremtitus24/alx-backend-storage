-- creates a table users and prior to creating
-- it checks whether the table exists so as to handle
-- errors that the DB might throw when the given table
-- name already exists.
CREATE TABLE IF NOT EXISTS users (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, email VARCHAR(255) NOT NULL UNIQUE, name VARCHAR(255))