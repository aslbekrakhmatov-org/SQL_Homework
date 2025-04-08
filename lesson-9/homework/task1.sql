create database lesson9
go
use lesson9;

CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

;with Job_Rankings as (
	select e.*, 0 as Depth
	from Employees e
	where ManagerID is null

	union all
	select e.EmployeeID, e.ManagerID, e.JobTitle, jr.Depth+1
	from Employees e
	join Job_Rankings jr
	on e.ManagerID=jr.EmployeeID
)
select * from Job_Rankings
order by Depth, EmployeeID

