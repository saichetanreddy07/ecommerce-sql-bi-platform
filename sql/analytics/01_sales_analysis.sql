-- 1. What is the total revenue generated from purchases?
SELECT
    SUM(e.price) AS total_revenue
FROM events AS e
WHERE e.event_type = 'purchase';

-- 2. Which 10 brands generated the most revenue?
SELECT
    p.brand,
    SUM(e.price) AS total_revenue
FROM events AS e
INNER JOIN products AS p
    ON e.product_id = p.product_id
WHERE e.event_type = 'purchase'
GROUP BY p.brand
ORDER BY total_revenue DESC
LIMIT 10;

-- 3. Which 10 products generated the most revenue?
SELECT
    e.product_id,
    SUM(e.price) AS total_revenue
FROM events AS e
WHERE e.event_type = 'purchase'
GROUP BY e.product_id
ORDER BY total_revenue DESC
LIMIT 10;

-- 4. How much revenue did each category generate?
SELECT
    c.category_code,
    SUM(e.price) AS total_revenue
FROM events AS e
INNER JOIN products AS p
    ON e.product_id = p.product_id
INNER JOIN categories AS c
    ON p.category_id = c.category_id
WHERE e.event_type = 'purchase'
GROUP BY c.category_code
ORDER BY total_revenue DESC;

-- 5. What is the daily revenue trend?
SELECT
    e.event_date,
    SUM(e.price) AS total_revenue
FROM events AS e
WHERE e.event_type = 'purchase'
GROUP BY e.event_date
ORDER BY e.event_date;

-- 6. What is the weekly revenue trend?
SELECT
    DATE_TRUNC('week', e.event_time)::date AS week_start_date,
    SUM(e.price) AS total_revenue
FROM events AS e
WHERE e.event_type = 'purchase'
GROUP BY week_start_date
ORDER BY week_start_date;

-- 7. What is the average purchase value?
SELECT
    AVG(e.price) AS average_purchase_value
FROM events AS e
WHERE e.event_type = 'purchase';

-- 8. What percentage of total revenue does each category contribute?
SELECT
    c.category_code,
    SUM(e.price) AS total_revenue,
    ROUND(
        SUM(e.price) * 100.0 / SUM(SUM(e.price)) OVER (),
        2
    ) AS revenue_contribution_percentage
FROM events AS e
INNER JOIN products AS p
    ON e.product_id = p.product_id
INNER JOIN categories AS c
    ON p.category_id = c.category_id
WHERE e.event_type = 'purchase'
GROUP BY c.category_code
ORDER BY revenue_contribution_percentage DESC;
