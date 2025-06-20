-- Step 1: Create Database
CREATE DATABASE IF NOT EXISTS onlineshoppingstore;
USE onlineshoppingstore;

-- Step 2: Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Step 3: Admin Table
CREATE TABLE admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100)
);

-- Step 4: Sellers Table
CREATE TABLE sellers (
    seller_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    store_name VARCHAR(100),
    approved BOOLEAN DEFAULT FALSE
);

-- Step 5: Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    seller_id INT,
    product_name VARCHAR(255),
    description TEXT,
    price DECIMAL(10,2),
    quantity INT,
    image_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

-- Step 6: Product Photos Table
CREATE TABLE product_photos (
    photo_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    photo_url VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Step 7: Cart Table
CREATE TABLE cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Step 8: Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Step 9: Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Step 10: Reviews Table
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Step 11: Wishlist Table
CREATE TABLE wishlist (
    wishlist_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Step 12: PaymentCard Table
-- PaymentCard Table
CREATE TABLE IF NOT EXISTS PaymentCard (
    card_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    cardholder_name VARCHAR(100) NOT NULL,
    card_number_last4 CHAR(4) NOT NULL,
    card_type ENUM('Visa', 'MasterCard', 'Amex', 'Discover') NOT NULL,
    expiry_month TINYINT NOT NULL,
    expiry_year SMALLINT NOT NULL,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_default BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
