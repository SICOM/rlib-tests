DROP DATABASE IF EXISTS rlib;
CREATE DATABASE rlib;

--DROP USER 'rlib'@'localhost';
CREATE USER 'rlib'@'localhost' IDENTIFIED BY 'rlib';
GRANT ALL PRIVILEGES ON rlib.* TO 'rlib'@'localhost' IDENTIFIED BY 'rlib' WITH GRANT OPTION;

--DROP USER 'rlib'@'127.0.0.1';
CREATE USER 'rlib'@'127.0.0.1' IDENTIFIED BY 'rlib';
GRANT ALL PRIVILEGES ON rlib.* TO 'rlib'@'127.0.0.1' IDENTIFIED BY 'rlib' WITH GRANT OPTION;

--DROP USER 'rlib'@'::1';
CREATE USER 'rlib'@'::1' IDENTIFIED BY 'rlib';
GRANT ALL PRIVILEGES ON rlib.* TO 'rlib'@'::1' IDENTIFIED BY 'rlib' WITH GRANT OPTION;

USE rlib;

DROP TABLE IF EXISTS products;

CREATE TABLE products (
	rn INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	plunum BIGINT NOT NULL,
	name VARCHAR(20) DEFAULT "",
	type INT DEFAULT 0,
	category INT DEFAULT 0,
	UNIQUE KEY (plunum)
);

INSERT INTO products (plunum, name, type) 
	VALUES 
  (10000000006,  "NRS", 9999),
  (10000000008,  "food sales", 9999),
  (10000000005,  "overring", 9999),
  (10000000007,  "refund", 9999),
  (10000000010,  "gift cert sales", 9999),
  (10000000011,  "other sales", 9999),
  (10000000001,  "EI Sales", 9999),
  (10000000002,  "TO Sales", 9999),
  (10000000003,  "DT Sales", 9999),
  (10000000009,  "nonfood sales", 9999),
  (10000000013,  "credits issued", 9999),
  (10000000014,  "promo sales", 9999),
  (10000000015,  "gift cert redeemed", 9999),
  (10000000060,  "reserved", 9999)
  ;
