DELIMITER $$

CREATE FUNCTION get_discounted_price(p_id INT, discount DECIMAL(5,2)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE v_price DECIMAL(10,2);

  -- Fetch the product price
  SELECT price INTO v_price FROM products WHERE product_id = p_id;
  
  -- Calculate discounted price
  RETURN v_price - (v_price * discount / 100);
END$$

DELIMITER ;