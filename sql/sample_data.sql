INSERT INTO suppliers (name, phone, email, address) VALUES
('Bean Roasters Co.', '0811111111', 'beans@roasters.com', 'Bangkok'),
('Milk & More', '0822222222', 'milk@more.com', 'Chiang Mai'),
('Pastry Pro', '0833333333', 'pastry@pro.com', 'Phuket'),
('SweetLife Sugar', '0844444444', 'sugar@sweetlife.com', 'Pattaya'),
('Cocoa World', '0855555555', 'cocoa@world.com', 'Nonthaburi'),
('Dairy Fresh', '0866666666', 'fresh@dairy.com', 'Khon Kaen'),
('Tea Time Co.', '0877777777', 'tea@time.com', 'Bangkok'),
('Fruit Hub', '0888888888', 'fruit@hub.com', 'Samut Prakan'),
('Tropical Syrups', '0899999999', 'syrups@trop.com', 'Chiang Rai'),
('Coffee Kingdom', '0800000000', 'kingdom@coffee.com', 'Bangkok');


INSERT INTO ingredients (name, unit, current_stock) VALUES
('Coffee Beans', 'grams', 2500),
('Milk', 'ml', 6000),
('Sugar', 'grams', 4000),
('Butter', 'grams', 1500),
('Flour', 'grams', 5000),
('Chocolate', 'grams', 2000),
('Tea Leaves', 'grams', 1800),
('Strawberry Syrup', 'ml', 2500),
('Ice Cubes', 'pcs', 1000),
('Whipped Cream', 'ml', 1500);


INSERT INTO ingredient_supplier (ingredient_id, supplier_id, cost_per_unit) VALUES
(1, 1, 0.5), (2, 2, 0.3), (3, 4, 0.2), (4, 3, 0.4),
(5, 3, 0.3), (6, 5, 0.6), (7, 7, 0.4), (8, 9, 0.5),
(9, 8, 0.1), (10, 6, 0.5);


INSERT INTO menu_items (name, category, price, is_available) VALUES
('Café Latte', 'Beverage', 75.00, TRUE),
('Americano', 'Beverage', 65.00, TRUE),
('Mocha', 'Beverage', 85.00, TRUE),
('Iced Tea', 'Beverage', 60.00, TRUE),
('Croissant', 'Bakery', 55.00, TRUE),
('Chocolate Cake', 'Dessert', 95.00, TRUE),
('Strawberry Smoothie', 'Beverage', 90.00, TRUE),
('Cappuccino', 'Beverage', 70.00, TRUE),
('Butter Roll', 'Bakery', 50.00, TRUE),
('Espresso', 'Beverage', 55.00, TRUE);


INSERT INTO menu_ingredients (menu_id, ingredient_id, quantity_needed) VALUES
(1, 1, 18), (1, 2, 200),
(2, 1, 15), (2, 9, 3),
(3, 1, 15), (3, 6, 30), (3, 2, 100),
(4, 7, 10), (4, 9, 5),
(5, 5, 80), (5, 4, 10),
(6, 5, 100), (6, 6, 50),
(7, 8, 100), (7, 2, 200),
(8, 1, 15), (8, 2, 150),
(9, 4, 5), (9, 5, 60),
(10, 1, 10);
