use lesson1;

drop table if exists orders;
create table orders
(
	order_id integer, 
	customer_name varchar(50),
	order_date date
);
alter table orders
add constraint UQ_order_id primary key(order_id);

