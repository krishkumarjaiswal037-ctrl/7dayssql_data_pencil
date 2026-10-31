use sq17challenge;

-- 1.Count the total number of customers registered in the database.
SELECT COUNT(customer_id) AS total_customers
FROM customers;


-- 2. Count the number of customers in each city to identify which cities have the most customers.

SELECT 
    city, 
    COUNT(customer_id) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;



-- 3.dentify the top 10 customers who placed the highest number of non-cancelled orders.

SELECT 
    customers, 
    COUNT(order_id) AS total_orders
FROM orders
WHERE order_status != 'Cancelled'  -- Adjust column name/status value as per your schema
GROUP BY customers
ORDER BY total_orders DESC
LIMIT 10;




-- 4.Calculate the total spending of each customer based on order item values, excluding cancelled orders.

SELECT 
    o.customers, 
    SUM(oi.quantity * oi.unit_price) AS total_spending
FROM orders o
JOIN order_items oi ON o.order_id = oi.orders_id
WHERE o.order_status != 'Cancelled'
GROUP BY o.customers
ORDER BY total_spending DESC;



-- 5.Calculate the average spending per customer among customers who have placed at least one non-cancelled order.

WITH customer_totals AS (
    SELECT 
        o.customers, 
        SUM(oi.quantity * oi.unit_price) AS total_spent
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status != 'Cancelled'
    GROUP BY o.customers
)
SELECT AVG(total_spent) AS avg_spending_per_customer
FROM customer_totals;








-- 6.Find customers who have placed more than five non-cancelled orders.

SELECT 
    customer1, 
    COUNT(order_id) AS total_orders
FROM orders
WHERE order_status != 'Cancelled'
GROUP BY customers
HAVING COUNT(order_id) > 5
ORDER BY total_orders DESC;









-- 7.Count the number of customers in each customer segment.

SELECT 
    customer_segment, 
    COUNT(customer_id) AS customer_count
FROM customers
GROUP BY customer_segment
ORDER BY customer_count DESC;






-- 8.Calculate the average number of non-cancelled orders per customer, including customers with zero qualifying orders.

SELECT 
    COUNT(o.order_id) * 1.0 / COUNT(DISTINCT c.customer_id) AS avg_orders_per_customer
FROM customers c
LEFT JOIN orders o 
    ON c.customer_id = o.customer_id 
    AND o.order_status != 'Cancelled';



-- 9.Identify the top 10 customers who generated the highest item sales value from non-cancelled orders.

SELECT 
    o.customer_id, 
    SUM(oi.quantity * oi.unit_price) AS total_sales_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status != 'Cancelled'
GROUP BY o.customer_id
ORDER BY total_sales_value DESC
LIMIT 10;





-- 10.Count the number of new customer registrations per month and display the results chronologically.

SELECT 
    DATE_FORMAT(signup_date, '%Y-%m') AS signup_month,  -- For PostgreSQL, use TO_CHAR(signup_date, 'YYYY-MM')
    COUNT(customer_id) AS new_customers
FROM customers
GROUP BY DATE_FORMAT(signup_date, '%Y-%m')
ORDER BY signup_month ASC;










