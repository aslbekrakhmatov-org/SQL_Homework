use lesson9;

with factorial as(
	select Cast(1 as Bigint) as Num,
		Cast(1 as bigint) as Factorial
	union all
	select Num+1, Factorial*(Num+1)
	from factorial
	where Num<10
)
select * from factorial