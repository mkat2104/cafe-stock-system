CREATE TABLE IF NOT EXISTS ingredients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(80) NOT NULL,
    unit VARCHAR(20) NOT NULL,  -- grams, ml, pcs
    current_stock DECIMAL(10,2) DEFAULT 0
);


CREATE TABLE IF NOT EXISTS suppliers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(30),
    email VARCHAR(100),
    address TEXT
);


CREATE TABLE IF NOT EXISTS ingredient_supplier (
    ingredient_id INT REFERENCES ingredients(id) ON DELETE CASCADE,
    supplier_id INT REFERENCES suppliers(id) ON DELETE CASCADE,
    cost_per_unit DECIMAL(10,2),
    PRIMARY KEY (ingredient_id, supplier_id)
);


CREATE TABLE IF NOT EXISTS menu_items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),            -- Drinks, Mains, Dessert...
    price DECIMAL(10,2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE
);


--RECIPES
CREATE TABLE IF NOT EXISTS menu_ingredients (
    menu_id INT REFERENCES menu_items(id) ON DELETE CASCADE,
    ingredient_id INT REFERENCES ingredients(id) ON DELETE CASCADE,
    quantity_needed DECIMAL(10,2) NOT NULL,     -- per 1 serving
    PRIMARY KEY (menu_id, ingredient_id)
);


-- STOCK MOVEMENTS (Restock, sales usage, waste)
-- ========================
CREATE TABLE IF NOT EXISTS stock_movements (
    movement_id SERIAL PRIMARY KEY,
    ingredient_id INT REFERENCES ingredients(id) ON DELETE CASCADE,
    change_amount DECIMAL(10,2) NOT NULL,
    movement_type VARCHAR(20) NOT NULL,     -- restock / sale_usage / waste
    created_at TIMESTAMP DEFAULT NOW()
);