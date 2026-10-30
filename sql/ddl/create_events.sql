-- Stores user activity events for sales and behavior analysis.
CREATE TABLE events (
    event_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    event_time DATETIME NOT NULL,
    event_date DATE NOT NULL,
    event_type VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    user_session CHAR(36) NOT NULL,
    product_id INT NOT NULL,
    user_id BIGINT NOT NULL,
    INDEX idx_events_event_time (event_time),
    INDEX idx_events_event_type (event_type),
    INDEX idx_events_product_id (product_id),
    INDEX idx_events_user_id (user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
