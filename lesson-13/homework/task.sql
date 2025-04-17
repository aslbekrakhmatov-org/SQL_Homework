use lesson13;

go
CREATE or Alter FUNCTION dbo.CalendarMonth(@givendate date = null)
RETURNS @CalendarTable table(
	Sunday nvarchar(255),
	Monday nvarchar(255),
	Tuesday nvarchar(255),
	Wednesday nvarchar(255),
	Thursday nvarchar(255),
	Friday nvarchar(255),
	Saturday nvarchar(255))
AS
BEGIN
	SET @givendate = ISNULL(@givendate, GETDATE());
	declare @enddate date = eomonth(@givendate);
	declare @startdate date = dateadd(DAY, 1, eomonth(@givendate, -1));

	;with cte1 as (
		select @startdate as MDay
		union all
		select Dateadd(DAY, 1, MDay)
		from cte1
		where Dateadd(DAY, 1, MDay)<=@enddate),
	cte2 as (select MDay,
		(DATEPART(WEEKDAY, MDay) + @@DATEFIRST - 1) % 7 as WeekDay,
		DATEDIFF(WEEK, @startdate, MDay) as WeekNum
		from cte1)
	insert into @CalendarTable
	select
		MAX(case when WeekDay=0 then Day(MDay) end) as Sunday,
		MAX(case when WeekDay=1 then Day(MDay) end) as Monday,
		MAX(case when WeekDay=2 then Day(MDay) end) as Tuesday,
		MAX(case when WeekDay=3 then Day(MDay) end) as Wednesday,
		MAX(case when WeekDay=4 then Day(MDay) end) as Thursday,
		MAX(case when WeekDay=5 then Day(MDay) end) as Friday,
		MAX(case when WeekDay=6 then Day(MDay) end) as Saturday
	from cte2
		group by WeekNum
	return;
END
go
select * from dbo.CalendarMonth(NULL)
