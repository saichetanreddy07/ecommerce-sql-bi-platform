-- 1. Which products received the highest number of views?
SELECT
    e.product_id,
    COUNT(*) AS view_count
FROM events AS e
WHERE e.event_type = 'view'
GROUP BY e.product_id
ORDER BY view_count DESC
LIMIT 10;


-- 2. Which products were purchased the most?
SELECT
    e.product_id,
    COUNT(*) AS purchase_count
FROM events AS e
WHERE e.event_type = 'purchase'
GROUP BY e.product_id
ORDER BY purchase_count DESC
LIMIT 10;


-- 3. Which products generated the highest revenue?
SELECT
    e.product_id,
    SUM(e.price) AS total_revenue
FROM events AS e
WHERE e.event_type = 'purchase'
GROUP BY e.product_id
ORDER BY total_revenue DESC
LIMIT 10;


-- 4. Which brands have the highest number of unique products?
SELECT
    p.brand,
    COUNT(DISTINCT p.product_id) AS unique_product_count
FROM products AS p
GROUP BY p.brand
ORDER BY unique_product_count DESC
LIMIT 10;


-- 5. Which categories have the highest number of unique products?
SELECT
    c.category_code,
    COUNT(DISTINCT p.product_id) AS unique_product_count
FROM products AS p
INNER JOIN categories AS c
    ON p.category_id = c.category_id
GROUP BY c.category_code
ORDER BY unique_product_count DESC
LIMIT 10;


-- 6. What is the average purchase price for each category?
SELECT
    c.category_code,
    AVG(e.price) AS average_purchase_price
FROM events AS e
INNER JOIN products AS p
    ON e.product_id = p.product_id
INNER JOIN categories AS c
    ON p.category_id = c.category_id
WHERE e.event_type = 'purchase'
GROUP BY c.category_code
ORDER BY average_purchase_price DESC;


-- 7. Which products were viewed but never purchased? (MySQL)
SELECT
    e.product_id,
    SUM(CASE WHEN e.event_type = 'view' THEN 1 ELSE 0 END) AS view_count,
    SUM(CASE WHEN e.event_type = 'purchase' THEN 1 ELSE 0 END) AS purchase_count
FROM events AS e
WHERE e.event_type IN ('view', 'purchase')
GROUP BY e.product_id
HAVING
    view_count > 0
    AND purchase_count = 0
ORDER BY view_count DESC;
