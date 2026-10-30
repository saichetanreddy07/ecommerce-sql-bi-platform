-- 1. How many view, cart, and purchase events occurred?
SELECT
    COUNT(CASE WHEN event_type = 'view' THEN 1 END) AS view_count,
    COUNT(CASE WHEN event_type = 'cart' THEN 1 END) AS cart_count,
    COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS purchase_count
FROM events;


-- 2. What is the overall view-to-purchase conversion rate?
SELECT
    COUNT(CASE WHEN event_type = 'view' THEN 1 END) AS view_count,
    COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS purchase_count,
    ROUND(
        COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) * 100.0 /
        COUNT(CASE WHEN event_type = 'view' THEN 1 END),
        2
    ) AS view_to_purchase_conversion_rate
FROM events
WHERE event_type IN ('view', 'purchase');


-- 3. What is the overall cart abandonment rate?
SELECT
    COUNT(CASE WHEN event_type = 'cart' THEN 1 END) AS cart_count,
    COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS purchase_count,
    ROUND(
        (COUNT(CASE WHEN event_type = 'cart' THEN 1 END) -
         COUNT(CASE WHEN event_type = 'purchase' THEN 1 END))
        * 100.0 /
        COUNT(CASE WHEN event_type = 'cart' THEN 1 END),
        2
    ) AS cart_abandonment_rate
FROM events
WHERE event_type IN ('cart', 'purchase');


-- 4. Which categories have the highest view-to-purchase conversion rate?
SELECT
    c.category_code,
    COUNT(CASE WHEN e.event_type = 'view' THEN 1 END) AS view_count,
    COUNT(CASE WHEN e.event_type = 'purchase' THEN 1 END) AS purchase_count,
    ROUND(
        COUNT(CASE WHEN e.event_type = 'purchase' THEN 1 END) * 100.0 /
        COUNT(CASE WHEN e.event_type = 'view' THEN 1 END),
        2
    ) AS view_to_purchase_conversion_rate
FROM events e
JOIN products p ON e.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
WHERE e.event_type IN ('view', 'purchase')
GROUP BY c.category_code
HAVING view_count > 0
ORDER BY view_to_purchase_conversion_rate DESC;


-- 5. Which brands have the highest view-to-purchase conversion rate?
SELECT
    p.brand,
    COUNT(CASE WHEN e.event_type = 'view' THEN 1 END) AS view_count,
    COUNT(CASE WHEN e.event_type = 'purchase' THEN 1 END) AS purchase_count,
    ROUND(
        COUNT(CASE WHEN e.event_type = 'purchase' THEN 1 END) * 100.0 /
        COUNT(CASE WHEN e.event_type = 'view' THEN 1 END),
        2
    ) AS view_to_purchase_conversion_rate
FROM events e
JOIN products p ON e.product_id = p.product_id
WHERE e.event_type IN ('view', 'purchase')
GROUP BY p.brand
HAVING view_count > 0
ORDER BY view_to_purchase_conversion_rate DESC
LIMIT 10;
