-- Return the menu items
CREATE OR REPLACE FUNCTION get_menu_items()
RETURNS TABLE (
    id INT,
    name TEXT,
    price DECIMAL
)
AS $$
BEGIN
    RETUN QUERY
    SELECT id, name, price
    FROM menu_items;
END;
$$ LANGUAGE plpgsql;


-- Return the ingredients with low stock
CREATE OR REPLACE FUNCTION get_low_stock()
RETURNS TABLE (
    id INT,
    name TEXT,
    stock INT,
    unit TEXT
)
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, stock, unit
    FROM ingredients
    WHERE stock < 10;
END;
$$ LANGUAGE plpgsql;



-- Update ingredient stock
CREATE OR REPLACE FUNCTION update_stock(p_ing_id INT, dff INT)
RETURNS VOID
AS $$
BEGIN
    UPDATE ingredients
    SET stock = stock + pg_wal_lsn_diff
    WHERE id = p_ing_id;
END;
$$ LANGUAGE plpgsql;