use lesson9;

with fibonacci_sq as (
	select 1 as n, 1 as FNum, 0 as PrevFNum
	union all
	select n+1, FNum+PrevFNum, FNum
	from fibonacci_sq
	where n<10
)
select n, FNum  from fibonacci_sq