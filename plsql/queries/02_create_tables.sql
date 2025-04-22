-- Create a Products table to store inventory
CREATE TABLE products (
  product_id INT PRIMARY KEY, -- Unique product ID
  name VARCHAR(100), -- Product name
  price DECIMAL(10,2), -- Product price
  stock_quantity INT -- Available quantity
);

-- Create a Sales table to track purchases
CREATE TABLE sales (
  sale_id INT PRIMARY KEY AUTO_INCREMENT, -- Unique sale ID
  product_id INT, -- Associated product ID
  quantity_sold INT, -- Quantity sold
  total_amount DECIMAL(10,2), -- Sale amount
  sale_date DATE, -- Date of sale
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);