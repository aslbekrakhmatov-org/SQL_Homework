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
from Medians
