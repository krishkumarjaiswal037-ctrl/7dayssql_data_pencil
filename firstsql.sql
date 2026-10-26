create database sq17challenge;
use sq17challenge;

create table customers(
  customer_id int primary key,
  full_name varchar(110) not null,
  email varchar(110) not null,
  city varchar(60) not null,
  singup_date date not null,
  segment varchar(30) not null
);



create table products(
  product_id int primary key,
  product_name varchar(110) not null,
  category varchar(35),
  price decimal(10,2),
  cost decimal(10,2)
);


create table orders(
  orders_id int primary key,
  costomer_id int not null,
  order_date date not null,
  status varchar(20),
  channel varchar(20)
  
  foreign key (customer_id) reference customers(customer_id)
);



create table order_items(
   order_item int primary key,
    order_name varchar(30) not null,
    order_rank int 
);


create table payments(
    payment_id int primary key,
    customer_name varchar(20) not null,
    order_item varchar(30) not null
);


create table deliveries(
   deliveries_num int primary key,
   customer_name varchar(20) not null,
   order_name varchar(30) not null
);






