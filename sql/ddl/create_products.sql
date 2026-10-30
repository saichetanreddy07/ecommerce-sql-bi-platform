-- Stores product records and links each product to its category for analysis.
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    category_id BIGINT NOT NULL,
    brand VARCHAR(255),
    INDEX idx_products_category_id (category_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
