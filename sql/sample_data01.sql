-- Creating sample customers through the signup function

SELECT customer_signup('Alice Wong', '0812345678', 'alice@example.com', 'pass123');
SELECT customer_signup('Mark Tan', '0899988776', 'mark@example.com', 'pass123');
SELECT customer_signup('Sara Kim', '0823344556', 'sara@example.com', 'pass123');
SELECT customer_signup('John Lee', '0861112233', 'john@example.com', 'pass123');
SELECT customer_signup('Linda Chan', '0819988776', 'linda@example.com', 'pass123');
SELECT customer_signup('Tom Noh', '0812233445', 'tom@example.com', 'pass123');
SELECT customer_signup('Mina Soo', '0891212121', 'mina@example.com', 'pass123');
SELECT customer_signup('David Park', '0825555555', 'david@example.com', 'pass123');
SELECT customer_signup('Olivia Lim', '0816666666', 'olivia@example.com', 'pass123');
SELECT customer_signup('Jason Chen', '0837777777', 'jason@example.com', 'pass123');


SELECT create_customer_order(1);
SELECT create_customer_order(2);
SELECT create_customer_order(3);
SELECT create_customer_order(4);
SELECT create_customer_order(5);
SELECT create_customer_order(6);
SELECT create_customer_order(7);
SELECT create_customer_order(8);
SELECT create_customer_order(9);
SELECT create_customer_order(10);


SELECT add_item_to_order_by_name(1, 'Café Latte', 2);
SELECT add_item_to_order_by_name(1, 'Croissant', 1);
SELECT add_item_to_order_by_name(2, 'Americano', 1);
SELECT add_item_to_order_by_name(2, 'Chocolate Cake', 1);
SELECT add_item_to_order_by_name(3, 'Cappuccino', 2);
SELECT add_item_to_order_by_name(4, 'Strawberry Smoothie', 1);
SELECT add_item_to_order_by_name(5, 'Iced Tea', 2);
SELECT add_item_to_order_by_name(6, 'Butter Roll', 2);
SELECT add_item_to_order_by_name(7, 'Mocha', 1);
SELECT add_item_to_order_by_name(8, 'Espresso', 2);
SELECT add_item_to_order_by_name(9, 'Croissant', 1);
SELECT add_item_to_order_by_name(10, 'Café Latte', 1);
