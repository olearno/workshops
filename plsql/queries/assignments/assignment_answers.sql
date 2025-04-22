DELIMITER $$

-- 1. Automatically reorder stock if below 5 units
CREATE PROCEDURE check_and_reorder_stock()
BEGIN
  DECLARE v_stock INT;
  SELECT stock_quantity INTO v_stock FROM products WHERE product_id = 4;
  IF v_stock < 5 THEN
    UPDATE products SET stock_quantity = stock_quantity + 20 WHERE product_id = 4;
    SELECT 'Stock reordered successfully!' AS status;
  END IF;
END$$

-- 2. Find total revenue per product for a given month
CREATE PROCEDURE calculate_monthly_sales(IN month INT, IN year INT)
BEGIN
  SELECT product_id, SUM(total_amount) AS revenue
  FROM sales
  WHERE MONTH(sale_date) = month AND YEAR(sale_date) = year
  GROUP BY product_id;
END$$

-- 3. Fraud detection trigger (multiple transactions within seconds)
CREATE TRIGGER fraud_detection_trigger
BEFORE INSERT ON transactions
FOR EACH ROW
BEGIN
  DECLARE v_count INT;
  SELECT COUNT(*) INTO v_count FROM transactions 
  WHERE account_id = NEW.account_id AND timestamp > NOW() - INTERVAL 10 SECOND;
  IF v_count > 2 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Suspicious transaction detected!';
  END IF;
END$$

-- 4. Function to apply discount based on item quantity
CREATE FUNCTION apply_discount(p_id INT, qty INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE v_price DECIMAL(10,2);
  DECLARE v_discount DECIMAL(5,2);
  DECLARE v_final_price DECIMAL(10,2);
  SELECT price INTO v_price FROM products WHERE product_id = p_id;
  SET v_discount = IF(qty >= 5, 10, 0); 
  SET v_final_price = v_price * qty - (v_price * qty * v_discount / 100);
  RETURN v_final_price;
END$$

-- 5. Categorizing complaints automatically
CREATE PROCEDURE categorize_complaint(IN complaint_text VARCHAR(255))
BEGIN
  DECLARE v_priority VARCHAR(20);
  SET v_priority = CASE 
    WHEN complaint_text LIKE '%billing issue%' OR complaint_text LIKE '%payment%' THEN 'High'
    WHEN complaint_text LIKE '%service delay%' OR complaint_text LIKE '%slow%' THEN 'Medium'
    ELSE 'Low'
  END;
  SELECT v_priority AS assigned_priority;
END$$

-- 6. Function to calculate employee salary after tax deductions
CREATE FUNCTION calculate_salary(emp_id INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE v_salary DECIMAL(10,2);
  DECLARE v_tax DECIMAL(5,2);
  DECLARE v_net_salary DECIMAL(10,2);
  SELECT salary INTO v_salary FROM employees WHERE id = emp_id;
  SET v_tax = v_salary * 0.15;
  SET v_net_salary = v_salary - v_tax;
  RETURN v_net_salary;
END$$

-- 7. Prevent flight overbooking
CREATE TRIGGER prevent_overbooking
BEFORE INSERT ON bookings
FOR EACH ROW
BEGIN
  DECLARE v_seats_available INT;
  SELECT available_seats INTO v_seats_available FROM flights WHERE flight_id = NEW.flight_id;
  IF v_seats_available < 1 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Booking failed: No available seats!';
  END IF;
END$$

-- 8. Function to check available hospital beds
CREATE FUNCTION available_beds(department_id INT) RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE v_free_beds INT;
  SELECT total_beds - occupied_beds INTO v_free_beds FROM hospital_departments WHERE department_id = department_id;
  RETURN v_free_beds;
END$$

-- 9. Procedure to generate monthly utility bills
CREATE PROCEDURE generate_bill(IN customer_id INT)
BEGIN
  DECLARE v_electricity_cost DECIMAL(10,2);
  DECLARE v_water_cost DECIMAL(10,2);
  DECLARE v_total DECIMAL(10,2);
  SELECT electricity_usage * 5 INTO v_electricity_cost FROM utility_bills WHERE customer_id = customer_id;
  SELECT water_usage * 2 INTO v_water_cost FROM utility_bills WHERE customer_id = customer_id;
  SET v_total = v_electricity_cost + v_water_cost;
  SELECT CONCAT('Total Utility Bill: ', v_total) AS bill_summary;
END$$

-- 10. Generate daily revenue reports
CREATE PROCEDURE daily_sales_report()
BEGIN
  SELECT product_id, SUM(total_amount) AS revenue, COUNT(sale_id) AS transactions
  FROM sales
  WHERE sale_date = CURDATE()
  GROUP BY product_id;
END$$

DELIMITER ;