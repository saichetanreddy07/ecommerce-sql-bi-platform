-- Stores product records and links each product to its category for analysis.
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    category_id BIGINT NOT NULL,
    brand TEXT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);