-- Insert additional product records for better examples
INSERT INTO products VALUES
(1, 'Laptop', 75000, 10),
(2, 'Smartphone', 30000, 20),
(3, 'Headphones', 2000, 50),
(4, 'Wireless Mouse', 1500, 35),
(5, 'Mechanical Keyboard', 5000, 15),
(6, 'Smartwatch', 12000, 25),
(7, 'Tablet', 25000, 18);

-- Insert more sales records for realistic transactions
INSERT INTO sales (product_id, quantity_sold, total_amount, sale_date) VALUES
(1, 2, 150000, '2025-04-22'),
(2, 5, 150000, '2025-04-21'),
(3, 3, 6000, '2025-04-20'),
(4, 4, 6000, '2025-04-19'),
(5, 2, 10000, '2025-04-18'),
(6, 1, 12000, '2025-04-17'),
(7, 3, 75000, '2025-04-16');