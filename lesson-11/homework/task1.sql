use lesson11;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES
    (1, 'Alice', 'HR', 5000),
    (2, 'Bob', 'IT', 7000),
    (3, 'Charlie', 'Sales', 6000),
    (4, 'David', 'HR', 5500),
    (5, 'Emma', 'IT', 7200);

create table #EmployeeTransfers(
	EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
)

insert into #EmployeeTransfers
select EmployeeID, Name, 
	case 
		when Department='HR' then 'IT'
		when Department='IT' then 'Sales'
		else 'HR'
	end as Department, Salary
from Employees

select * from Employees
select * from #EmployeeTransfers

















