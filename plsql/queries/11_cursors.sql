DELIMITER $$

-- Create a stored procedure to loop through product inventory using a cursor
CREATE PROCEDURE process_products_cursor()
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE v_product_id INT;
  DECLARE v_name VARCHAR(100);
  DECLARE v_stock INT;

  -- Declare a cursor for selecting products
  DECLARE product_cursor CURSOR FOR 
    SELECT product_id, name, stock_quantity FROM products;

  -- Declare a handler for handling the end of records
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  -- Open the cursor
  OPEN product_cursor;

  -- Loop through the cursor rows
  read_loop: LOOP
    FETCH product_cursor INTO v_product_id, v_name, v_stock;
    
    IF done = 1 THEN
      LEAVE read_loop; -- Exit loop when no more records
    END IF;

    -- Print product details
    SELECT CONCAT('Product ID: ', v_product_id, ', Name: ', v_name, ', Stock: ', v_stock) AS product_info;
  END LOOP;

  -- Close the cursor
  CLOSE product_cursor;
END$$

DELIMITER ;

CALL process_products_cursor();