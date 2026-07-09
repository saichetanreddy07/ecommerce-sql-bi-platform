SELECT e.event_time,
    e.event_type,
    p.brand,
    c.category_code,
    e.price
FROM events e
    JOIN products p ON e.product_id = p.product_id
    JOIN categories c ON p.category_id = c.category_id
LIMIT 10;