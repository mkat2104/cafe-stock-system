-- Return the menu items
CREATE OR REPLACE FUNCTION get_menu_items()
RETURNS TABLE(id INT, name TEXT, category TEXT, price DECIMAL)
AS $$
BEGIN
  RETURN QUERY
  SELECT id, name, category, price
  FROM menu_items
  WHERE is_available = TRUE;
END;
$$ LANGUAGE plpgsql;



-- Return low stock items
CREATE OR REPLACE FUNCTION get_low_stock(threshold DECIMAL)
RETURNS TABLE(id INT, name TEXT, current_stock DECIMAL, unit TEXT)
AS $$
BEGIN
  RETURN QUERY
  SELECT id, name, current_stock, unit
  FROM ingredients
  WHERE current_stock < threshold;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION update_stock(
    p_ing_id INT,
    diff DECIMAL
)
RETURNS VOID AS $$
BEGIN
    UPDATE ingredients
    SET current_stock = current_stock + diff
    WHERE id = p_ing_id;

    INSERT INTO stock_movements (ingredient_id, change_amount, movement_type)
    VALUES (p_ing_id, diff, 'restock');
END;
$$ LANGUAGE plpgsql;

