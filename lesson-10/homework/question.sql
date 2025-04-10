use lesson10;

with ProcessTable as (
	select Num from Shipments
	union all
	select 0 union all
	select 0 union all
	select 0 union all
	select 0 union all
	select 0 union all
	select 0 union all
	select 0
),
CountTable as (
	select count(*) as TotalCount from ProcessTable
),
RankedTable as (
	select Num, ROW_NUMBER() over(order by Num) as Num_Rank
	from ProcessTable
),
Medians as (
	select Num
	from RankedTable rt
	cross join CountTable ct
	where (ct.TotalCount%2=0 and Num_Rank in (ct.TotalCount/2, ct.TotalCount/2+1)) or
	(ct.TotalCount%2=1 and Num_Rank = ceiling(ct.TotalCount/2))
)
select avg(Num) as Median
from Medians;

;with TotalDays as(
	select 1 as n 
	union all
	select n+1
	from TotalDays
	where n<40
), 
ProcessTable as (
	select td.n as Day, s.num as Shipments
	from TotalDays td
	left join Shipments s
	on td.n = s.n
),
RankedTable as (
	select Num, ROW_NUMBER() over(order by Num) as rn
	from ProcessTable
),
TotalCount as (
	select count(*) as tc from ProcessTable
)
SELECT AVG(CAST(Num AS FLOAT)) AS Median
FROM RankedTable r
JOIN TotalCount t ON 1 = 1
WHERE rn IN (FLOOR((t.tc + 1)/2.0), CEILING((t.tc + 1)/2.0));




