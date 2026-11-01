use sq17challenge;


-- Q1. How many orders belong to each order status.

SELECT 
    order_status, 
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;




-- Q2. How many deliveries belong to each delivery status?


SELECT 
    delivery_status, 
    COUNT(delivery_id) AS total_deliveries
FROM deliveries
GROUP BY delivery_status
ORDER BY total_deliveries DESC;



-- Q3. On average, how many days does a completed delivery take?


SELECT 
    AVG(DATEDIFF(delivered_date, order_date)) AS avg_delivery_days
FROM orders
WHERE delivery_status = 'Delivered';



-- Q4. Which 10 delivered orders took the longest to arrive?


SELECT 
    order_id,
    order_date,
    delivered_date,
    DATEDIFF(delivered_date, order_date) AS delivery_days 
FROM orders
WHERE delivery_status = 'Delivered'
ORDER BY delivery_days DESC
LIMIT 10;



-- Q5. How does order volume change month by month?


SELECT 
    DATE_FORMAT(order_date) AS order_month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month ASC;




-- Q6. How are payment records distributed across statuses?


SELECT 
    payment_status, 
    COUNT(payment_id) AS total_payments
FROM payments
GROUP BY payment_status
ORDER BY total_payments DESC;



-- Q7. Which completed deliveries took longer than five days?


SELECT 
    order_id,
    order_date,
    delivered_date,
    DATEDIFF(delivered_date, order_date) AS delivery_days  
FROM orders
WHERE delivery_status = 'Delivered'
  AND DATEDIFF(delivered_date, order_date) > 5
ORDER BY delivery_days DESC;



-- Q8. Which customer cities have the longest average delivery times?


SELECT 
    c.city,
    AVG(DATEDIFF(o.delivered_date, o.order_date)) AS avg_delivery_days  
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.delivery_status = 'Delivered'
GROUP BY c.city
ORDER BY avg_delivery_days DESC;