-- Total Revenue:
SELECT SUM(price + freight_value) AS total_revenue
FROM order_items;

-- Revenue by Month:
SELECT 
    strftime('%Y-%m', o.order_purchase_timestamp) AS month,
    SUM(oi.price + oi.freight_value) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

-- Top 10 Products BY Revenue: (Screenshot of the result attached revenus.png)
SELECT 
    joi.product_id, p.product_category_name,
    SUM(joi.price + joi.freight_value) AS revenue
FROM order_items joi join products p on joi.product_id = p.product_id   
GROUP BY joi.product_id, p.product_category_name
ORDER BY revenue DESC
LIMIT 10;

-- Top Customers by revenue: (Screenshot of the result attached top_customers.png)
SELECT 
    o.customer_id,
    SUM(oi.price + oi.freight_value) AS gross_revenue
    FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY gross_revenue DESC
LIMIT 10;

-- Average Order Value:
SELECT 
    o.order_id,
    SUM(oi.price + oi.freight_value) AS order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id
ORDER BY order_value DESC
LIMIT 10;

-- Order Count per Customer:
SELECT 
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS order_count
FROM orders o join customers c on o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
ORDER BY order_count DESC
LIMIT 10;  


