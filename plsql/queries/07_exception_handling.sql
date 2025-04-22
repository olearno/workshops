DELIMITER $$

CREATE PROCEDURE find_product_price(IN p_id INT)
BEGIN
  DECLARE v_price DECIMAL(10,2);
  
  -- Try fetching product price
  BEGIN
    SELECT price INTO v_price FROM products WHERE product_id = p_id;
    SELECT CONCAT('Product Price: ', v_price) AS result;
  END;

EXCEPTION
  WHEN SQLSTATE '02000' THEN -- MySQL's equivalent of NO_DATA_FOUND
    SELECT 'Error: Product not found!' AS result;
END$$

DELIMITER ;