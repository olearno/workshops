DELIMITER $$

CREATE TRIGGER low_stock_trigger
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
  -- Print warning if stock is low
  IF NEW.stock_quantity < 5 THEN
    INSERT INTO logs (message) VALUES (CONCAT('Low stock alert for Product ID: ', NEW.product_id));
  END IF;
END$$

DELIMITER ;