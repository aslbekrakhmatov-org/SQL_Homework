create database lesson2
go
use lesson2;

drop table if exists test_identity
create table test_identity
(
	id int identity(1,1),
	name varchar(50)
);

insert into test_identity(name)
values('a'), ('b'), ('c'), ('d'), ('e');
select * from test_identity;

drop table test_identity;
delete from test_identity;
truncate table test_identity;

--Answers:
----1. When we use delete, identity column's values doesn't reset.
----2. When we use truncate, identity column's values reset.
----3. When we use drop, the whole table is deleted not only values in it unlike when we use delete and truncate.




