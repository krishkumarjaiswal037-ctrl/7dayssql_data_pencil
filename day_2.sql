use sq17challenge;

-- Q1.Finding Total Orders

select count(*) as total_orders
from orders;


-- Q2.Orders Status counts

select status, count(*) as total_orders
from orders
group by status;


-- Q3.10 Most Recent Orders.(By Ordes Date)

select order_date, count(*) as total_orders
from orders
group by order_date
order by order_date asc;


-- Q4,Highest Value Order

SELECT MAX(price) AS highest_order_amount
FROM products;

-- Q5.Daily Order Volume

SELECT 
    singup_date,
    COUNT(customer_id) AS daily_order_volume
FROM customers
GROUP BY singup_date
ORDER BY singup_date asc;



-- Q6.Montly Order Trend

select month(order_date), count(*) as total_orders
from orders
group by month(order_date)
order by month(order_date) asc;


-- Q7.Avg Order Value(Round)

select round(avg(order_amount),2) as avg_order
from 
(select order_rank, sum(quantity*unit_prize) as order_amount
from orders
group by order_id) as order_total;


-- Q8.Top 10 Customer by order count
SELECT 
    order_id,
    order_name,
    COUNT(order_id) AS total_orders
FROM order_items
GROUP BY order_id, order_name
ORDER BY total_orders asc
LIMIT 10;

