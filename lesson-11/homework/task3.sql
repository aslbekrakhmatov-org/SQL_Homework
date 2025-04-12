use lesson11;

CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);


create view vw_MonthlyWorkSummary as
with perEmp as (select 
	EmployeeID, sum(HoursWorked) as TotalHoursWorked 
	from WorkLog
	group by EmployeeID
),
perDep as (
	select Department, sum(HoursWorked) as TotalHoursDepartment, avg(HoursWorked) as AvgHoursDepartment 
	from Worklog
	group by Department
)
select w.EmployeeID, w.EmployeeName, w.Department, w.HoursWorked, w.WorkDate, pe.TotalHoursWorked, pd.TotalHoursDepartment, pd.AvgHoursDepartment
from WorkLog w
join perEmp pe on pe.EmployeeID=w.EmployeeID
join perDep pd on pd.Department=w.Department


select * from vw_MonthlyWorkSummary
select * from WorkLog