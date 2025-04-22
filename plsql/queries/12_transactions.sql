DELIMITER $$

-- Stored Procedure to Handle a Sale Transaction
CREATE PROCEDURE process_sale(IN p_id INT, IN qty INT)
BEGIN
  DECLARE v_price DECIMAL(10,2);
  DECLARE v_total DECIMAL(10,2);
  DECLARE v_stock INT;

  -- Start the transaction
  START TRANSACTION;

  -- Fetch product price and stock availability
  SELECT price, stock_quantity INTO v_price, v_stock FROM products WHERE product_id = p_id;

  -- Check if enough stock is available
  IF v_stock >= qty THEN
    -- Calculate total amount
    SET v_total = v_price * qty;

    -- Insert sale record
    INSERT INTO sales (product_id, quantity_sold, total_amount, sale_date)
    VALUES (p_id, qty, v_total, CURDATE());

    -- Update stock quantity
    UPDATE products SET stock_quantity = stock_quantity - qty WHERE product_id = p_id;

    -- Commit the transaction (confirm changes)
    COMMIT;
    SELECT 'Transaction Successful!' AS status;
  ELSE
    -- Rollback transaction if stock is insufficient
    ROLLBACK;
    SELECT 'Transaction Failed: Insufficient stock!' AS status;
  END IF;
END$$

DELIMITER ;

-- Attempt to sell 3 units of product ID 1
--CALL process_sale(1, 3); 