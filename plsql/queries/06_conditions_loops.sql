DELIMITER $$

CREATE PROCEDURE calculate_total_sales()
BEGIN
  DECLARE v_total DECIMAL(10,2);
  
  -- Calculate total revenue from sales
  SELECT SUM(total_amount) INTO v_total FROM sales;
  
  SELECT CONCAT('Total Sales Revenue: ', v_total) AS sales_summary;
END$$

DELIMITER ;