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
    INSERT INTO customers(name, phone, email, password_hash)
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
    p_login TEXT,         -- phone or email
    p_password TEXT
)
RETURNS INT AS $$
DECLARE
    c_id INT;
    stored_hash TEXT;
BEGIN
    SELECT id, password_hash
    INTO c_id, stored_hash
    FROM customers
    WHERE phone = p_login OR email = p_login;

    IF NOT FOUND THEN
        RETURN -1;  -- user not found
    END IF;

    IF stored_hash = crypt(p_password, stored_hash) THEN
        RETURN c_id;  -- success
    ELSE
        RETURN -2;  -- wrong password
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
) RETURNS INT AS $$
DECLARE
    new_sale_id INT;
BEGIN
    INSERT INTO sales (sale_time, total_amount, customer_id)
    VALUES (NOW(), NULL, _customer_id)
    RETURNING id INTO new_sale_id;

    RETURN new_sale_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION add_item_to_order(
    _sale_id INT,
    _menu_id INT,
    _quantity INT
) RETURNS TEXT AS $$
DECLARE
    _price DECIMAL(10,2);
    _current_stock INT;
BEGIN
    -- 1. Check current stock
    SELECT stock INTO _current_stock
    FROM menu_items
    WHERE id = _menu_id;

    IF _current_stock IS NULL THEN
        RETURN 'Error: Menu item does not exist.';
    END IF;

    IF _current_stock < _quantity THEN
        RETURN 'Error: Not enough stock available.';
    END IF;

    -- 2. Get the price of the item
    SELECT price INTO _price
    FROM menu_items
    WHERE id = _menu_id;

    -- 3. Insert into sales_items
    INSERT INTO sales_items (sale_id, menu_id, quantity, price_each)
    VALUES (_sale_id, _menu_id, _quantity, _price);

    -- 4. Reduce the stock
    UPDATE menu_items
    SET stock = stock - _quantity
    WHERE id = _menu_id;

    RETURN 'Item added to order and stock updated.';
END;
$$ LANGUAGE plpgsql;

