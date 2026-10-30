-- 1. How many unique customers are in the dataset?
SELECT
    COUNT(DISTINCT u.user_id) AS unique_customer_count
FROM users AS u;


-- 2. How many customers made at least one purchase?
SELECT
    COUNT(DISTINCT e.user_id) AS purchasing_customer_count
FROM events AS e
WHERE e.event_type = 'purchase';


-- 3. Which 10 customers spent the most?
SELECT
    e.user_id,
    SUM(e.price) AS total_spending
FROM events AS e
WHERE e.event_type = 'purchase'
GROUP BY e.user_id
ORDER BY total_spending DESC
LIMIT 10;


-- 4. Which 10 users are most active based on total events?
SELECT
    e.user_id,
    COUNT(*) AS total_events
FROM events AS e
GROUP BY e.user_id
ORDER BY total_events DESC
LIMIT 10;


-- 5. What is the average revenue generated per customer?
SELECT
    AVG(customer_revenue) AS average_revenue_per_customer
FROM (
    SELECT
        u.user_id,
        COALESCE(SUM(e.price), 0) AS customer_revenue
    FROM users AS u
    LEFT JOIN events AS e
        ON u.user_id = e.user_id
        AND e.event_type = 'purchase'
    GROUP BY u.user_id
) AS customer_revenue_totals;


-- 6. Which customers added products to their cart but never purchased? (MySQL)
SELECT
    e.user_id,
    SUM(CASE WHEN e.event_type = 'cart' THEN 1 ELSE 0 END) AS cart_count,
    SUM(CASE WHEN e.event_type = 'purchase' THEN 1 ELSE 0 END) AS purchase_count
FROM events AS e
WHERE e.event_type IN ('cart', 'purchase')
GROUP BY e.user_id
HAVING
    cart_count > 0
    AND purchase_count = 0
ORDER BY cart_count DESC;
