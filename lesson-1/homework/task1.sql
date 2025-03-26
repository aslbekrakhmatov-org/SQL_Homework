--create database lesson1;
--go
use lesson1;

drop table if exists student;
create table student
(
	id integer,
	name varchar(50),
	age integer
);
alter table student
alter column id integer not null;

--insert into student(id, name, age)
--values(1, null, 18);
--select * from student;
