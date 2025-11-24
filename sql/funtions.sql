CREATE TABLE cafes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(80),
    address TEXT
);

CREATE TABLE ingredients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(80),
    stock INT,
    unit VARCHAR(20)
);

CREATE TABLE menu_items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(80),
    price DECIMAL(8,2)
);
