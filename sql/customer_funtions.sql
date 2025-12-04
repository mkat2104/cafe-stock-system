CREATE OR REPLACE FUNCTION customer_signup(
    p_name TEXT,
    p_phone TEXT,
    p_email TEXT,
    p_password TEXT
)
RETURNS INT AS $$
DECLARE
    new_id INT;
BEGIN
    INSERT INTO customers (name, phone, email, password_hash)
    VALUES (
        p_name,
        p_phone,
        p_email,
        crypt(p_password, gen_salt('bf'))
    )
    RETURNING id INTO new_id;

    RETURN new_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION customer_login(
    p_login TEXT,        -- phone or email
    p_password TEXT      -- raw password input
)
RETURNS TEXT AS $$
DECLARE
    c_id INT;
    stored_hash TEXT;
    c_name TEXT;
BEGIN
    -- 1. Look up customer by phone or email
    SELECT id, password_hash, name
    INTO c_id, stored_hash, c_name
    FROM customers
    WHERE phone = p_login OR email = p_login;

    -- 2. No customer found
    IF NOT FOUND THEN
        RETURN 'Error: No account found with that phone or email.';
    END IF;

    -- 3. Check password validity
    IF stored_hash = crypt(p_password, stored_hash) THEN
        RETURN format('Welcome back, %s!', c_name);
    ELSE
        RETURN 'Error: Incorrect password.';
    END IF;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION update_customer_profile(
    p_customer_id INT,
    p_name TEXT,
    p_phone TEXT,
    p_email TEXT
)
RETURNS VOID AS $$
BEGIN
    UPDATE customers
    SET name  = p_name,
        phone = p_phone,
        email = p_email
    WHERE id = p_customer_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION customer_change_password(
    p_customer_id INT,
    p_old_password TEXT,
    p_new_password TEXT
)
RETURNS BOOLEAN AS $$
DECLARE
    stored_hash TEXT;
BEGIN
    SELECT password_hash INTO stored_hash
    FROM customers
    WHERE id = p_customer_id;

    IF stored_hash = crypt(p_old_password, stored_hash) THEN
        UPDATE customers
        SET password_hash = crypt(p_new_password, gen_salt('bf'))
        WHERE id = p_customer_id;
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION create_customer_order(
    _customer_id INT
)
RETURNS INT AS $$
DECLARE
    new_order_id INT;
BEGIN
    INSERT INTO customer_orders (customer_id, order_time, total_amount)
    VALUES (_customer_id, NOW(), 0)
    RETURNING id INTO new_order_id;

    RETURN new_order_id;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION add_item_to_order(
    _order_id INT,
    _menu_name TEXT,
    _quantity INT
)
RETURNS TEXT AS $$
DECLARE
    _menu_id INT;
    _price DECIMAL(10,2);
    _ingredient RECORD;
    _new_total DECIMAL(10,2);
BEGIN
    -- 1. Find menu item by name (case-insensitive)
    SELECT id, price INTO _menu_id, _price
    FROM menu_items
    WHERE LOWER(name) = LOWER(_menu_name)
      AND is_available = TRUE;

    IF NOT FOUND THEN
        RETURN format('Error: Menu item "%s" not found or unavailable.', _menu_name);
    END IF;

    -- 2. Insert order item
    INSERT INTO customer_order_items (order_id, menu_id, quantity, price_each)
    VALUES (_order_id, _menu_id, _quantity, _price);

    -- 3. Reduce ingredient stock based on recipe
    FOR _ingredient IN
        SELECT ingredient_id, quantity_needed
        FROM menu_ingredients
        WHERE menu_id = _menu_id
    LOOP
        UPDATE ingredients
        SET current_stock = current_stock - (_ingredient.quantity_needed * _quantity)
        WHERE id = _ingredient.ingredient_id;

        INSERT INTO stock_movements (ingredient_id, change_amount, movement_type)
        VALUES (_ingredient.ingredient_id, -(_ingredient.quantity_needed * _quantity), 'sale_usage');
    END LOOP;

    -- 4. Update order total automatically
    SELECT SUM(quantity * price_each)
    INTO _new_total
    FROM customer_order_items
    WHERE order_id = _order_id;

    UPDATE customer_orders
    SET total_amount = _new_total
    WHERE id = _order_id;

    -- 5. Return confirmation message
    RETURN format(
        'Added %s x%s to order #%s. Total updated to %s ฿.',
        _menu_name, _quantity, _order_id, to_char(_new_total, 'FM999999.00')
    );
END;
$$ LANGUAGE plpgsql;