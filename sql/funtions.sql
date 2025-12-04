-- Return the menu items
CREATE OR REPLACE FUNCTION get_menu_items()
RETURNS TABLE(menu_id INT, menu_name TEXT, category TEXT, price DECIMAL)
AS $$
BEGIN
  RETURN QUERY
  SELECT 
      menu_items.id AS menu_id,
      menu_items.name::TEXT AS menu_name,
      menu_items.category::TEXT,
      menu_items.price
  FROM menu_items
  WHERE menu_items.is_available = TRUE;
END;
$$ LANGUAGE plpgsql;




-- Return low stock items
CREATE OR REPLACE FUNCTION get_low_stock(threshold DECIMAL)
RETURNS TABLE (
    id INT,
    name VARCHAR(80),
    current_stock DECIMAL(10,2),
    unit VARCHAR(20)
)
AS $$
BEGIN
  RETURN QUERY
  SELECT i.id, i.name, i.current_stock, i.unit
  FROM ingredients AS i
  WHERE i.current_stock < threshold;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION update_stock(
    p_ing_name TEXT,
    diff DECIMAL
)
RETURNS TEXT AS $$
DECLARE
    _ing_id INT;
BEGIN
    -- Find ingredient by name (case-insensitive)
    SELECT id INTO _ing_id
    FROM ingredients
    WHERE LOWER(name) = LOWER(p_ing_name);

    IF NOT FOUND THEN
        RETURN format('Error: Ingredient "%s" not found.', p_ing_name);
    END IF;

    -- Update stock
    UPDATE ingredients
    SET current_stock = current_stock + diff
    WHERE id = _ing_id;

    -- Log restock in stock_movements
    INSERT INTO stock_movements (ingredient_id, change_amount, movement_type)
    VALUES (_ing_id, diff, 'restock');

    RETURN format('Updated stock for "%s" by %s units.', p_ing_name, diff);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_customer_orders_summary()
    RETURNS TABLE(
                     order_id INT,
                     customer_name TEXT,
                     order_time TIMESTAMP,
                     items_summary TEXT,
                     order_total DECIMAL(10,2)
                 )
AS $$
BEGIN
    RETURN QUERY
        SELECT
            co.id AS order_id,
            c.name::TEXT AS customer_name,
            co.order_time,
            STRING_AGG(
                    format('%s x%s', mi.name, coi.quantity),  -- use %s instead of %d
                    ', '
                    ORDER BY mi.name
            ) AS items_summary,
            co.total_amount AS order_total
        FROM customer_orders co
                 JOIN customers c ON co.customer_id = c.id
                 JOIN customer_order_items coi ON co.id = coi.order_id
                 JOIN menu_items mi ON coi.menu_id = mi.id
        GROUP BY co.id, c.name, co.order_time, co.total_amount
        ORDER BY co.order_time DESC;
END;
$$ LANGUAGE plpgsql;