-- Get all products from the inventory
SELECT * FROM products;

-- Get sales transactions for the last 7 days
SELECT * FROM sales WHERE sale_date >= CURDATE() - INTERVAL 7 DAY;