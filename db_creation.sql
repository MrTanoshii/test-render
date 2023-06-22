-- See https://www.postgresql.org/docs/current/datatype.html for more info on data types

DROP TABLE IF EXISTS customer_beverage;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS barcode;
DROP TABLE IF EXISTS beverage;
DROP TABLE IF EXISTS manufacturer;

CREATE TABLE manufacturer (
    id SERIAL PRIMARY KEY,
    label VARCHAR(100) NOT NULL UNIQUE
);

-- One to Many relationship
CREATE TABLE beverage (
    id SERIAL PRIMARY KEY,
    label VARCHAR(50) NOT NULL,
    price REAL,
    manufacturer_id INT,
    CONSTRAINT fk_manufacturer_id FOREIGN KEY (manufacturer_id) REFERENCES manufacturer(id)
);

-- One to One relationship
CREATE TABLE barcode (
    id SERIAL PRIMARY KEY,
    barcode CHAR(12) UNIQUE,
    beverage_id INT REFERENCES beverage(id) ON DELETE CASCADE
);

CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(250) NOT NULL
);

-- Many to Many relationship
CREATE TABLE customer_beverage (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(id) ON DELETE SET NULL,
    beverage_id INT REFERENCES beverage(id) ON DELETE SET NULL,
    is_favorite BOOLEAN NOT NULL DEFAULT FALSE
);