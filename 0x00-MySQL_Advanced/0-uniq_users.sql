-- The script creates a table users with, id, email and name.
-- id is integer(never null), email string(never null and unique), name string(255 characters). 

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255)
);
