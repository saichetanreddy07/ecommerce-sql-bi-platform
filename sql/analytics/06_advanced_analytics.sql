-- 1. How do brands rank by total revenue?
SELECT
    p.brand,
    SUM(e.price) AS total_revenue,
    RANK() OVER (ORDER BY SUM(e.price) DESC) AS revenue_rank
FROM events e
JOIN products p
    ON e.product_id = p.product_id
WHERE e.event_type = 'purchase'
GROUP BY p.brand
ORDER BY revenue_rank;

-- 2. What are the top 3 products in every category?
WITH product_category_revenue AS (
    SELECT
        c.category_code,
        e.product_id,
        SUM(e.price) AS total_revenue
    FROM events AS e
    INNER JOIN products AS p
        ON e.product_id = p.product_id
    INNER JOIN categories AS c
        ON p.category_id = c.category_id
    WHERE e.event_type = 'purchase'
    GROUP BY
        c.category_code,
        e.product_id
),
ranked_products AS (
    SELECT
        pcr.category_code,
        pcr.product_id,
        pcr.total_revenue,
        DENSE_RANK() OVER (
            PARTITION BY pcr.category_code
            ORDER BY pcr.total_revenue DESC
        ) AS category_revenue_rank
    FROM product_category_revenue AS pcr
)
SELECT
    rp.category_code,
    rp.product_id,
    rp.total_revenue,
    rp.category_revenue_rank
FROM ranked_products AS rp
WHERE rp.category_revenue_rank <= 3
ORDER BY
    rp.category_code,
    rp.category_revenue_rank;

-- 3. What is the running total of daily revenue?
WITH daily_revenue AS (
    SELECT
        e.event_date,
        SUM(e.price) AS total_revenue
    FROM events AS e
    WHERE e.event_type = 'purchase'
    GROUP BY e.event_date
)
SELECT
    dr.event_date,
    dr.total_revenue,
    SUM(dr.total_revenue) OVER (
        ORDER BY dr.event_date
    ) AS running_total_revenue
FROM daily_revenue AS dr
ORDER BY dr.event_date;

-- 4. What is the 7-day moving average of daily revenue?
WITH daily_revenue AS (
    SELECT
        e.event_date,
        SUM(e.price) AS total_revenue
    FROM events AS e
    WHERE e.event_type = 'purchase'
    GROUP BY e.event_date
)
SELECT
    dr.event_date,
    dr.total_revenue,
    ROUND(
        AVG(dr.total_revenue) OVER (
            ORDER BY dr.event_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS seven_day_moving_average_revenue
FROM daily_revenue AS dr
ORDER BY dr.event_date;

-- 5. What was the previous day's revenue using LAG?
WITH daily_revenue AS (
    SELECT
        e.event_date,
        SUM(e.price) AS total_revenue
    FROM events AS e
    WHERE e.event_type = 'purchase'
    GROUP BY e.event_date
)
SELECT
    dr.event_date,
    dr.total_revenue,
    LAG(dr.total_revenue) OVER (
        ORDER BY dr.event_date
    ) AS previous_day_revenue,
    dr.total_revenue
        - LAG(dr.total_revenue) OVER (
            ORDER BY dr.event_date
        ) AS revenue_change
FROM daily_revenue AS dr
ORDER BY dr.event_date;

-- 6. How does each customer rank based on total spending?
SELECT
    e.user_id,
    SUM(e.price) AS total_spending,
    RANK() OVER (ORDER BY SUM(e.price) DESC) AS spending_rank
FROM events e
WHERE e.event_type = 'purchase'
GROUP BY e.user_id
ORDER BY spending_rank;

-- 7. What percentage of total revenue does each brand contribute?
SELECT
    p.brand,
    SUM(e.price) AS total_revenue,
    ROUND(
        SUM(e.price) * 100.0 /
        SUM(SUM(e.price)) OVER (),
        2
    ) AS revenue_contribution_percentage
FROM events e
JOIN products p
    ON e.product_id = p.product_id
WHERE e.event_type = 'purchase'
GROUP BY p.brand
ORDER BY revenue_contribution_percentage DESC;

-- 8. Which customers spent more than the average customer spending?
WITH customer_spending AS (
    SELECT
        user_id,
        SUM(price) AS total_spending
    FROM events
    WHERE event_type = 'purchase'
    GROUP BY user_id
)
SELECT *
FROM customer_spending
WHERE total_spending >
      (SELECT AVG(total_spending) FROM customer_spending)
ORDER BY total_spending DESC;
