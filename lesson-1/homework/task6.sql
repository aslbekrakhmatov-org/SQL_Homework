use lesson1;

drop table if exists customer;
create table customer
(
	customer_id integer primary key, 
	customer_name varchar(50),
	city varchar(50) constraint DF_city default 'Unknown'
);
alter table customer
drop constraint DF_city;
alter table customer
add constraint DF_city default 'Unknown' for city;

