use lesson6;

drop table if exists Departments
create table Departments(
	DepartmentID int primary key identity(101, 1),
	DepartmentName varchar(50)
)

insert into Departments
values 
('IT'), ('HR'), ('Finance'), ('Marketing');

drop table if exists Employees
create table Employees(
		EmployeeID int primary key identity,
		name varchar(50),
		DepartmentID int foreign key references Departments(DepartmentID),
		salary int
)

insert into Employees(name, DepartmentID, salary)
values
	('Alice', 101, 60000),
	('Bob', 102, 70000),
	('Charlie', 101, 65000),
	('David', 103, 72000),
	('Eva', Null, 68000);

drop table if exists Projects
create table Projects(
		ProjectID int primary key identity,
		ProjectName varchar(50),
		EmployeeID int foreign key references Employees(EmployeeID)
)

insert into Projects(ProjectName, EmployeeID)
values
	('Alpha', 1),
	('Beta', 2),
	('Gamma', 1),
	('Delta', 4),
	('Omega', NULL);

-- task1
select e.EmployeeID,
e.name as EmployeeName,
e.salary,
d.DepartmentID,
d.DepartmentName
from Employees as e
inner join Departments as d
on e.DepartmentID=d.DepartmentID

--task2 
select e.EmployeeID,
e.name as EmployeeName,
e.salary,
d.DepartmentID,
d.DepartmentName
from Employees as e
left join Departments as d
on e.DepartmentID=d.DepartmentID

--task3
select e.EmployeeID,
e.name as EmployeeName,
e.salary,
d.DepartmentID,
d.DepartmentName
from Employees as e
right join Departments as d
on e.DepartmentID=d.DepartmentID

--task4
select e.EmployeeID,
e.name as EmployeeName,
e.salary,
d.DepartmentID,
d.DepartmentName
from Employees as e
full outer join Departments as d
on e.DepartmentID=d.DepartmentID

-- task5
with all_departments as (select e.EmployeeID,
	e.name as EmployeeName,
	e.salary,
	d.DepartmentID,
	d.DepartmentName
	from Employees as e
	right join Departments as d
	on e.DepartmentID=d.DepartmentID)
select DepartmentName, isnull(sum(salary), 0) as TotalSalaryExp
from all_departments
group by DepartmentName

-- task6
select * from Departments
cross join Projects

--task7

with EMP_DEP as(select
	e.EmployeeID, e.name, d.DepartmentName
	from Employees as e
	left join Departments as d
	on e.DepartmentID = d.DepartmentID)

select ed.EmployeeID, ed.name, ed.DepartmentName, p.ProjectName
from EMP_DEP as ed
left join Projects as p
on ed.EmployeeID = p.EmployeeID