CREATE EXTENSION IF NOT EXISTS pgcrypto;


CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(30) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);


CREATE TABLE IF NOT EXISTS customer_orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE SET NULL,
    order_time TIMESTAMP DEFAULT NOW(),
    total_amount DECIMAL(10,2)
);


CREATE TABLE IF NOT EXISTS customer_order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES customer_orders(id) ON DELETE CASCADE,
    menu_id INT REFERENCES menu_items(id),
    quantity INT NOT NULL,
    price_each DECIMAL(10,2) NOT NULL
);
