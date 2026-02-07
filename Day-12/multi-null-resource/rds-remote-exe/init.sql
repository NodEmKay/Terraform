CREATE DATABASE IF NOT EXISTS `remoteexe`;
USE `remoteexe`;
CREATE TABLE IF NOT EXISTS test_table (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);
INSERT INTO test_table (name) VALUES ('example row');
