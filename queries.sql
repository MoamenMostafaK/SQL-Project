-- total revenue, freight, combined
SELECT
    ROUND(SUM(price), 2) AS total_revenue,
    ROUND(SUM(freight_value), 2) AS total_freight,
    ROUND(SUM(price + freight_value), 2) AS combined_total
FROM order_items;


-- revenue by month for delivered orders
WITH MonthlyRevenue AS (
    SELECT
        strftime('%Y-%m', o.order_purchase_timestamp) AS month,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY 1
)
SELECT
    month,
    revenue,
    ROUND(revenue - LAG(revenue) OVER (ORDER BY month), 2) AS revenue_diff,
    ROUND(((revenue / LAG(revenue) OVER (ORDER BY month)) - 1) * 100, 2) AS mom_growth_pct
FROM MonthlyRevenue;


-- top categories by revenue
WITH ProductSales AS (
    SELECT
        p.product_category_name,
        SUM(oi.price + oi.freight_value) AS revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY 1
)
SELECT
    product_category_name,
    ROUND(revenue, 2) AS revenue,
    ROUND(100.0 * revenue / (SELECT SUM(revenue) FROM ProductSales), 2) 
        AS revenue_share_pct
FROM ProductSales
ORDER BY revenue DESC
LIMIT 10;


-- top customers by spending
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY 1
ORDER BY total_spent DESC
LIMIT 10;


-- order value min/avg/max
WITH OrderTotals AS (
    SELECT
        o.order_id,
        SUM(oi.price + oi.freight_value) AS total_value
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY 1
)
SELECT
    ROUND(AVG(total_value), 2) AS avg_order_value,
    ROUND(MIN(total_value), 2) AS min_order_value,
    ROUND(MAX(total_value), 2) AS max_order_value
FROM OrderTotals;


-- customer order frequency
SELECT
    order_count,
    COUNT(customer_unique_id) AS num_customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY 1
)
GROUP BY 1
ORDER BY order_count DESC;