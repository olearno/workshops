DELIMITER $$

CREATE PROCEDURE update_stock(IN p_id INT, IN qty_sold INT)
BEGIN
  -- Deduct sold quantity from stock
  UPDATE products SET stock_quantity = stock_quantity - qty_sold WHERE product_id = p_id;
  
  SELECT CONCAT('Stock updated for Product ID: ', p_id) AS confirmation;
END$$

DELIMITER ;