use lesson1;

drop table if exists product;
create table product
(
	product_id integer unique,
	product_name varchar(50),
	price float
);
alter table product
drop constraint UQ__product__47027DF414A1F15D;
alter table product
add constraint UQ_product_id unique(product_id);

alter table product
add constraint UQ_product_id_name unique(product_id, product_name);