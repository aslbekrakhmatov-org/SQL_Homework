use lesson1;

drop table if exists books;
create table books
(
	book_id int primary key identity(1,1),
	title varchar(100) not null,
	price decimal check(price >0),
	genre varchar(50) default 'Unknown'
);

--checking
insert into books(title, price)
values
('Open letter', 10)

select * from books;
