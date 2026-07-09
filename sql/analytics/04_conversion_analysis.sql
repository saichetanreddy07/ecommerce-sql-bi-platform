-- 1. How many view, cart, and purchase events occurred?
SELECT
    COUNT(*) FILTER (WHERE e.event_type = 'view') AS view_count,
    COUNT(*) FILTER (WHERE e.event_type = 'cart') AS cart_count,
    COUNT(*) FILTER (WHERE e.event_type = 'purchase') AS purchase_count
FROM events AS e
WHERE e.event_type IN ('view', 'cart', 'purchase');

-- 2. What is the overall view-to-purchase conversion rate?
SELECT
    COUNT(*) FILTER (WHERE e.event_type = 'view') AS view_count,
    COUNT(*) FILTER (WHERE e.event_type = 'purchase') AS purchase_count,
    ROUND(
        COUNT(*) FILTER (WHERE e.event_type = 'purchase') * 100.0
            / NULLIF(COUNT(*) FILTER (WHERE e.event_type = 'view'), 0),
        2
    ) AS view_to_purchase_conversion_rate
FROM events AS e
WHERE e.event_type IN ('view', 'purchase');

-- 3. What is the overall cart abandonment rate?
SELECT
    COUNT(*) FILTER (WHERE e.event_type = 'cart') AS cart_count,
    COUNT(*) FILTER (WHERE e.event_type = 'purchase') AS purchase_count,
    ROUND(
        (
            COUNT(*) FILTER (WHERE e.event_type = 'cart')
            - COUNT(*) FILTER (WHERE e.event_type = 'purchase')
        ) * 100.0
            / NULLIF(COUNT(*) FILTER (WHERE e.event_type = 'cart'), 0),
        2
    ) AS cart_abandonment_rate
FROM events AS e
WHERE e.event_type IN ('cart', 'purchase');

-- 4. Which categories have the highest view-to-purchase conversion rate?
SELECT
    c.category_code,
    COUNT(*) FILTER (WHERE e.event_type = 'view') AS view_count,
    COUNT(*) FILTER (WHERE e.event_type = 'purchase') AS purchase_count,
    ROUND(
        COUNT(*) FILTER (WHERE e.event_type = 'purchase') * 100.0
            / NULLIF(COUNT(*) FILTER (WHERE e.event_type = 'view'), 0),
        2
    ) AS view_to_purchase_conversion_rate
FROM events AS e
INNER JOIN products AS p
    ON e.product_id = p.product_id
INNER JOIN categories AS c
    ON p.category_id = c.category_id
WHERE e.event_type IN ('view', 'purchase')
GROUP BY c.category_code
HAVING COUNT(*) FILTER (WHERE e.event_type = 'view') > 0
ORDER BY view_to_purchase_conversion_rate DESC;

-- 5. Which brands have the highest view-to-purchase conversion rate?
SELECT
    p.brand,
    COUNT(*) FILTER (WHERE e.event_type = 'view') AS view_count,
    COUNT(*) FILTER (WHERE e.event_type = 'purchase') AS purchase_count,
    ROUND(
        COUNT(*) FILTER (WHERE e.event_type = 'purchase') * 100.0
            / NULLIF(COUNT(*) FILTER (WHERE e.event_type = 'view'), 0),
        2
    ) AS view_to_purchase_conversion_rate
FROM events AS e
INNER JOIN products AS p
    ON e.product_id = p.product_id
WHERE e.event_type IN ('view', 'purchase')
GROUP BY p.brand
HAVING COUNT(*) FILTER (WHERE e.event_type = 'view') > 0
ORDER BY view_to_purchase_conversion_rate DESC
LIMIT 10;
