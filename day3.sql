use sq17challenge;

-- 1.Calculate the total value of all order items.
SELECT 
    SUM(oi.quantity * oi.unit_price) AS total_sales_value
FROM orders o
join order_items oi
on o.order_id = oi.order_id
where status <> 'cancelled';





-- 2.Identify which product categories generate the most sales
select

 SUM(oi.quantity * oi.unit_price) AS total_sales_value
FROM orders o
join order_items oi
on o.order_id = oi.order_id
join products p
on o.product_id = p.product_id
where o.status <> 'cancelled'
group by p.category;






-- 3. Find the ten products generating the highest revenue.
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM productds oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue asc
LIMIT 10;




-- 4.Calculate revenue month by month.
SELECT 
    DATE_TRUNC('month', o.order_date) AS sales_month, 
    SUM(oi.quantity * oi.unit_price) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY 1
ORDER BY sales_month ASC;





-- 5. Identify which sales channels generate the highest revenue.
SELECT 
    o.sales_channel,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.sales_channel
ORDER BY total_revenue DESC;









-- 6. Calculate the total quantity of products sold in each category.
SELECT 
    c.category_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_quantity_sold DESC;



-- 7. Count how many payments were made using each payment method
SELECT 
    payment_method,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_method
ORDER BY total_payments DESC;



-- 8.Count payments by their status.
SELECT 
    payment_status,
    COUNT(*) AS payment_count
FROM payments
GROUP BY payment_status
ORDER BY payment_count DESC;




-- 9.Calculate the average recorded payment amount.
SELECT 
    AVG(payment_amount) AS average_payment_amount
FROM payments;



-- 10. Calculate the total recorded payment amount for each payment method
SELECT 
    payment_method,
    SUM(payment_amount) AS total_payment_amount
FROM payments
GROUP BY payment_method
ORDER BY total_payment_amount desc;