CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY, -- Unique customer ID with auto-increment
    first_name VARCHAR(50) NOT NULL, -- Customer's first name
    last_name VARCHAR(50) NOT NULL, -- Customer's last name
    email VARCHAR(100) UNIQUE NOT NULL, -- Customer email (unique)
    phone VARCHAR(15), -- Optional customer phone number
    address VARCHAR(255), -- Customer address
    city VARCHAR(100), -- City
    country VARCHAR(100), -- Country
    created_at DATETIME DEFAULT GETDATE() -- Date of account creation
);

CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY, -- Unique order ID
    customer_id INT, -- Foreign key referencing customers
    order_date DATE NOT NULL, -- Date when the order was placed
    total_amount DECIMAL(10, 2) NOT NULL, -- Total order amount
    status VARCHAR(50) DEFAULT 'Pending', -- Order status (Pending, Shipped, Delivered, etc.)
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) -- Foreign key relationship
);



CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY, -- Unique product ID
    product_name VARCHAR(100) NOT NULL, -- Name of the product
    description TEXT, -- Detailed description of the product
    price DECIMAL(10, 2) NOT NULL, -- Product price
    stock INT NOT NULL, -- Available stock for the product
    category VARCHAR(50), -- Category of the product
    created_at DATETIME DEFAULT GETDATE() -- Date when the product was added
);


CREATE TABLE employees (
    employee_id INT IDENTITY(1,1) PRIMARY KEY, -- Unique employee ID
    first_name VARCHAR(50) NOT NULL, -- Employee's first name
    last_name VARCHAR(50) NOT NULL, -- Employee's last name
    position VARCHAR(50), -- Job title
    salary DECIMAL(10, 2), -- Employee salary
    hire_date DATE, -- Date of hire
    department VARCHAR(50), -- Department the employee works in
    email VARCHAR(100) UNIQUE -- Employee email (unique)
);


