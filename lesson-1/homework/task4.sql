use lesson1;

drop table if exists category;
create table category
(
	category_id integer primary key,
	category_name varchar(50)
);

drop table if exists item;
create table item
(
	item_id integer primary key,
	item_name varchar(50), 
	category_id integer
);

alter table item
add constraint FK_category foreign key (category_id) references category(category_id);