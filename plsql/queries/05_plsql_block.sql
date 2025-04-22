DELIMITER $$

CREATE PROCEDURE check_low_stock()
BEGIN
  DECLARE v_stock INT;

  -- Fetch stock quantity of a product
  SELECT stock_quantity INTO v_stock FROM products WHERE product_id = 1;

  -- Alert if stock is low
  IF v_stock < 5 THEN
    SELECT 'Warning: Low stock for product!';
  END IF;
END$$

DELIMITER ;