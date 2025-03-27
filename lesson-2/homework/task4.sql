use lesson2;

drop table if exists student;
create table student
(
	classes int not null,
	tuition_per_class float check(tuition_per_class>0),
	total_tuition as (classes*tuition_per_class)
);

insert into student
values
(3, 1000.25), 
(4, 1200.75),
(7, 835);

select * from student;