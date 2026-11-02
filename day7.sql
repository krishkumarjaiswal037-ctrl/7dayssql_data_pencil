use sq17challenge;

-- Q1. Total Orders and Order Status Distribution

SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status;


-- Q2. Total Sales Value from Non-Cancelled Orders.


SELECT SUM(OI.quantity * OI.unit_price) AS total_sales
FROM order_items OI
JOIN orders O ON OI.order_id = O.order_id
WHERE O.status != 'Cancelled';



-- Q3. Months with the Highest and Lowest Order Volumes.


SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month, COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY total_orders DESC
limit 1;


-- Q4. Sales Value by Sales Channel

SELECT o.channel, SUM(OI.quantity * OI.unit_price) AS total_sales
FROM orders O
JOIN order_items OI ON O.order_id = OI.order_id
WHERE O.status != 'Cancelled'
GROUP BY o.channel;


-- Q5. Sales Value by Product Category
SELECT 
    p.category, 
    SUM(oi.quantity * oi.unit_price) AS sales_value
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status != 'Cancelled'
GROUP BY p.category
ORDER BY sales_value DESC;


-- Q6. Top 10 Products by Sales Value
SELECT 
    p.product_id, 
    p.product_name, 
    SUM(oi.quantity * oi.unit_price) AS sales_value
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status != 'Cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY sales_value DESC
LIMIT 10;


-- Q7. Products with No Sales from Non-Cancelled Orders

SELECT 
    p.product_id, 
    p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id AND o.order_status != 'Cancelled'
WHERE o.order_id IS NULL;


-- Q8. Estimated Product Profit by Category

SELECT 
    p.category, 
    SUM(oi.quantity * (oi.unit_price - p.cost)) AS total_estimated_profit
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status != 'Cancelled'
GROUP BY p.category
ORDER BY total_estimated_profit DESC;



-- Q9. Top 10 Customers by Non-Cancelled Order Count

SELECT 
    customer_id, 
    COUNT(order_id) AS order_count
FROM orders
WHERE order_status != 'Cancelled'
GROUP BY customer_id
ORDER BY order_count DESC
LIMIT 10;


-- Q10. Top 10 Customers by Calculated Spending

SELECT 
    o.customer_id, 
    SUM(oi.quantity * oi.unit_price) AS total_spending
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status != 'Cancelled'
GROUP BY o.customer_id
ORDER BY total_spending DESC
LIMIT 10;


-- Q11. Cities with the Largest Customer Base

SELECT 
    city, 
    COUNT(customer_id) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;



-- Q12. Average Customer Spending by Segment

SELECT 
    c.customer_segment, 
    AVG(customer_totals.total_spent) AS avg_spending
FROM customers c
JOIN (
    SELECT 
        o.customer_id, 
        SUM(oi.quantity * oi.unit_price) AS total_spent
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status != 'Cancelled'
    GROUP BY o.customer_id
) customer_totals ON c.customer_id = customer_totals.customer_id
GROUP BY c.customer_segment
ORDER BY avg_spending DESC;


-- Q13. Payment Status Distribution

SELECT 
    payment_status, 
    COUNT(payment_id) AS total_payments
FROM payments
GROUP BY payment_status
ORDER BY total_payments DESC;



-- Q14. Average Delivery Time

SELECT 
    AVG(DATEDIFF(delivered_date, order_date)) AS avg_delivery_days
FROM orders
WHERE order_status = 'Delivered';  -- Adjust status label if tracked via delivery_status



-- Q15. Orders Taking More Than Five Days to Deliver

SELECT 
    order_id,
    customer_id,
    order_date,
    delivered_date,
    DATEDIFF(delivered_date, order_date) AS delivery_days
FROM orders
WHERE order_status = 'Delivered'
  AND DATEDIFF(delivered_date, order_date) > 5
ORDER BY delivery_days DESC;
