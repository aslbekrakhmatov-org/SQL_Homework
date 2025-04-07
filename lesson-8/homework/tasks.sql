DROP TABLE IF EXISTS Groupings;

CREATE TABLE Groupings
(
StepNumber  INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NOT NULL,
[Status]    VARCHAR(100) NOT NULL
);
INSERT INTO Groupings (StepNumber, TestCase, [Status]) 
VALUES
(1,'Test Case 1','Passed'),
(2,'Test Case 2','Passed'),
(3,'Test Case 3','Passed'),
(4,'Test Case 4','Passed'),
(5,'Test Case 5','Failed'),
(6,'Test Case 6','Failed'),
(7,'Test Case 7','Failed'),
(8,'Test Case 8','Failed'),
(9,'Test Case 9','Failed'),
(10,'Test Case 10','Passed'),
(11,'Test Case 11','Passed'),
(12,'Test Case 12','Passed');

-----------------------------------------

DROP TABLE IF EXISTS [dbo].[EMPLOYEES_N];

CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
)
 
INSERT INTO [dbo].[EMPLOYEES_N]
VALUES
	(1001,'Pawan','1975-02-21'),
	(1002,'Ramesh','1976-02-21'),
	(1003,'Avtaar','1977-02-21'),
	(1004,'Marank','1979-02-21'),
	(1008,'Ganesh','1979-02-21'),
	(1007,'Prem','1980-02-21'),
	(1016,'Qaue','1975-02-21'),
	(1155,'Rahil','1975-02-21'),
	(1102,'Suresh','1975-02-21'),
	(1103,'Tisha','1975-02-21'),
	(1104,'Umesh','1972-02-21'),
	(1024,'Veeru','1975-02-21'),
	(1207,'Wahim','1974-02-21'),
	(1046,'Xhera','1980-02-21'),
	(1025,'Wasil','1975-02-21'),
	(1052,'Xerra','1982-02-21'),
	(1073,'Yash','1983-02-21'),
	(1084,'Zahar','1984-02-21'),
	(1094,'Queen','1985-02-21'),
	(1027,'Ernst','1980-02-21'),
	(1116,'Ashish','1990-02-21'),
	(1225,'Bushan','1997-02-21');

-- task1

SELECT 
	MIN(StepNumber) as [Min Step Number],
	MAX(StepNumber) as [Max Step Number],
	MAX([Status]) as [Status],
	COUNT(StepNumber) as [Consecutive Count]
from (select *,
	(ROW_NUMBER() over(order by StepNumber)-ROW_NUMBER() over(partition by [Status] order by StepNumber)) as checker
	from Groupings) HelpTable
group by [Status], checker
order by [Min Step Number]

-- task2

with HiredYears as (
	select distinct Year(HIRE_DATE) as Hired_Year
	from EMPLOYEES_N
),
AllYears as (
	select (ROW_NUMBER() over(order by (select null))+1971) as [Year]
	from string_split(replicate(',', 2025-1972), ',', 1)
), 
NotHiredYears as (
	select [Year] as Not_Hired_Year
	from AllYears
	where [Year] not in (select Hired_Year from HiredYears)
),
HelpTable as (
	select Not_Hired_Year,
	Not_Hired_Year - ROW_NUMBER() over(order by Not_Hired_Year) as help_column
	from NotHiredYears
),
OutputTable as(
	select MIN(Not_Hired_Year) as StartYear, MAX(Not_Hired_Year) as EndYear
	from HelpTable
	group by help_column
)
select 
CONCAT(StartYear, ' - ', EndYear) as Years
from OutputTable