INSERT INTO ingredients (name, unit, current_stock) VALUES
('Coffee Beans', 'grams', 5000),
('Milk', 'ml', 8000),
('Sugar Syrup', 'ml', 3000),
('Chocolate Powder', 'grams', 1500),
('Tea Leaves', 'grams', 1200),
('Bread', 'pcs', 40),
('Ham', 'grams', 2000),
('Cheese Slice', 'pcs', 60),
('Tuna Spread', 'grams', 1500),
('Cream Cheese', 'grams', 1000),
('Butter', 'grams', 2000);


INSERT INTO suppliers (name, phone, email, address) VALUES
('Thai Coffee Roasters Co.', '081-123-4567', 'sales@thaicoffee.co.th', 'Bangkok'),
('FreshDairy Supply', '089-888-2222', 'contact@freshdairy.com', 'Nonthaburi'),
('SweetMix Ltd.', '082-442-9911', 'info@sweetmix.com', 'Bangkok'),
('BakerPro Foods', '080-777-3399', 'support@bakerpro.com', 'Pathum Thani'),
('TeaMasters Import', '086-551-0001', 'hello@teamasters.com', 'Chiang Mai');


INSERT INTO ingredient_supplier (ingredient_id, supplier_id, cost_per_unit) VALUES
-- Coffee Beans
(1, 1, 0.80),

-- Milk
(2, 2, 0.05),

-- Sugar Syrup
(3, 3, 0.03),

-- Chocolate Powder
(4, 3, 0.10),

-- Tea Leaves
(5, 5, 0.15),

-- Bread
(6, 4, 8.00),

-- Ham
(7, 4, 0.25),

-- Cheese Slice
(8, 4, 2.50),

-- Tuna Spread
(9, 4, 0.20),

-- Cream Cheese
(10, 4, 0.30),

-- Butter
(11, 4, 0.12);


INSERT INTO menu_items (name, price) VALUES
('Americano', 60.00),
('Latte', 75.00),
('Cappuccino', 70.00),
('Mocha', 85.00),
('Espresso', 55.00),
('Iced Thai Milk Tea', 50.00),
('Iced Lemon Tea', 45.00),
('Chocolate Frappe', 90.00),
('Ham & Cheese Sandwich', 95.00),
('Tuna Sandwich', 85.00),
('Blueberry Cheesecake', 110.00),
('Croissant', 45.00);


-- Americano (menu_id = 1)
INSERT INTO menu_ingredients VALUES
(1, 1, 18);  -- 18g coffee

-- Latte (menu_id = 2)
INSERT INTO menu_ingredients VALUES
(2, 1, 18),
(2, 2, 180);

-- Cappuccino (menu_id = 3)
INSERT INTO menu_ingredients VALUES
(3, 1, 18),
(3, 2, 150);

-- Mocha (menu_id = 4)
INSERT INTO menu_ingredients VALUES
(4, 1, 18),
(4, 2, 150),
(4, 4, 15); -- chocolate powder

-- Espresso (menu_id = 5)
INSERT INTO menu_ingredients VALUES
(5, 1, 18);

-- Thai Milk Tea (menu_id = 6)
INSERT INTO menu_ingredients VALUES
(6, 5, 12),
(6, 2, 150),
(6, 3, 20);

-- Iced Lemon Tea (menu_id = 7)
INSERT INTO menu_ingredients VALUES
(7, 5, 10),
(7, 3, 15);

-- Chocolate Frappe (menu_id = 8)
INSERT INTO menu_ingredients VALUES
(8, 4, 20),
(8, 2, 200),
(8, 3, 25);


-- Ham & Cheese Sandwich (menu_id = 9)
INSERT INTO menu_ingredients VALUES
(9, 6, 2),    -- 2 bread
(9, 7, 50),   -- 50g ham
(9, 8, 2),    -- 2 cheese slices
(9, 11, 10);  -- butter

-- Tuna Sandwich (menu_id = 10)
INSERT INTO menu_ingredients VALUES
(10, 6, 2),
(10, 9, 70),  -- 70g tuna
(10, 11, 10);

-- Blueberry Cheesecake (menu_id = 11)
INSERT INTO menu_ingredients VALUES
(11, 10, 80);  -- cream cheese 80g

-- Croissant (menu_id = 12)
INSERT INTO menu_ingredients VALUES
(12, 11, 15);  -- butter 15g



-- Restock movements
INSERT INTO stock_movements (ingredient_id, change_amount, movement_type) VALUES
(1, 2000, 'restock'),   -- Coffee beans +2kg
(2, 5000, 'restock'),   -- Milk +5L
(6, 20, 'restock'),     -- Bread +20 pcs
(11, 1000, 'restock');  -- Butter +1kg

-- Waste / spoilage
INSERT INTO stock_movements (ingredient_id, change_amount, movement_type) VALUES
(2, -300, 'waste'),     -- 300ml spoiled milk
(6, -3, 'waste');       -- 3 bread spoiled

-- Example sales usage (optional)
INSERT INTO stock_movements (ingredient_id, change_amount, movement_type) VALUES
(1, -90, 'sale_usage'),   -- coffee used
(2, -450, 'sale_usage'),  -- milk used
(6, -4, 'sale_usage');    -- bread used


INSERT INTO sales (sales_time, total_amount) VALUES
('2025-11-20 09:12:00', 2),
('2025-11-20 09:45:00', 2),
('2025-11-20 10:33:00', 2),
('2025-11-20 11:02:00', 2),
('2025-11-20 11:45:00', 2),
('2025-11-20 12:15:00', 3),
('2025-11-20 13:10:00', 3),
('2025-11-20 14:50:00', 2),
('2025-11-20 15:30:00', 3),
('2025-11-20 16:05:00', 2);


-- Sale 1
INSERT INTO sales_items (sale_id, menu_id, quantity, price_each) VALUES
(1, 1, 1, 60.00),      -- Americano
(1, 12, 1, 45.00);     -- Croissant

-- Sale 2
INSERT INTO sales_items (sale_id, menu_id, quantity, price_each) VALUES
(2, 2, 1, 75.00),      -- Latte
(2, 11, 1, 110.00);    -- Blueberry Cheesecake

-- Sale 3
INSERT INTO sales_items (sale_id, menu_id, quantity, price_each) VALUES
(3, 4, 1, 85.00),      -- Mocha
(3, 7, 1, 45.00);      -- Iced Lemon Tea

-- Sale 4
INSERT INTO sales_items (sale_id, menu_id, quantity, price_each) VALUES
(4, 3, 2, 70.00),      -- 2 Cappuccinos
(4, 12, 1, 45.00);     -- Croissant

-- Sale 5
INSERT INTO sales_items (sale_id, menu_id, quantity, price_each) VALUES
(5, 6, 1, 50.00),      -- Thai Milk Tea
(5, 9, 1, 95.00);      -- Ham & Cheese Sandwich

-- Sale 6
INSERT INTO sales_items (sale_id, menu_id, quantity, price_each) VALUES
(6, 1, 1, 60.00),      -- Americano
(6, 5, 1, 55.00),      -- Espresso
(6, 12, 2, 45.00);     -- 2 Croissants

-- Sale 7
INSERT INTO sales_items (sale_id, menu_id, quantity, price_each) VALUES
(7, 2, 1, 75.00),      -- Latte
(7, 8, 1, 90.00),      -- Chocolate Frappe
(7, 10, 1, 85.00);     -- Tuna Sandwich

-- Sale 8
INSERT INTO sales_items (sale_id, menu_id, quantity, price_each) VALUES
(8, 3, 1, 70.00),      -- Cappuccino
(8, 7, 1, 45.00);      -- Iced Lemon Tea

-- Sale 9
INSERT INTO sales_items (sale_id, menu_id, quantity, price_each) VALUES
(9, 4, 1, 85.00),      -- Mocha
(9, 11, 1, 110.00),    -- Cheesecake
(9, 6, 1, 50.00);      -- Thai Milk Tea

-- Sale 10
INSERT INTO sales_items (sale_id, menu_id, quantity, price_each) VALUES
(10, 1, 1, 60.00),
(10, 9, 1, 95.00);
