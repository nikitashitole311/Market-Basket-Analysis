#drop database ecom_db;
CREATE DATABASE IF NOT EXISTS ecom_db;
USE ecom_db;

CREATE TABLE IF NOT EXISTS customers(
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    gender ENUM('Male','Female','Other'),
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    created_at DATETIME
);

CREATE TABLE IF NOT EXISTS categories(
    category_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    is_active ENUM('Yes','No') DEFAULT 'Yes'
);

CREATE TABLE IF NOT EXISTS products(
    product_id INT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    brand VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    size ENUM('S','M','L','XL','XXL') NULL,
    color VARCHAR(30),
    is_available ENUM('Yes','No') DEFAULT 'Yes',
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS orders(
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME,
    status ENUM('Pending','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
    payment_mode ENUM('UPI','Credit Card','Debit Card','Net Banking','Cash on Delivery'),
    shipping_address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS order_items(
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS reviews(
    review_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    rating INT NOT NULL,
    comment VARCHAR(500),
    review_date DATETIME,
    sentiment ENUM('Positive','Neutral','Negative'),
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);
