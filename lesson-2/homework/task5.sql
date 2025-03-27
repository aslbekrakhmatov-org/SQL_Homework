use lesson2;

drop table if exists worker;
create table worker
(
	id int,
	name varchar(50)
);

bulk insert worker
from 'D:\SQL_Homework\lesson-2\employee.csv' with
(
	firstrow = 2, 
	fieldterminator = ',',
	rowterminator = '\n'
);

select * from worker;