use lesson2;

drop table if exists photos;
create table photos
(
	id int primary key,
	photo varbinary(max)
);

insert into photos
select 1, bulkcolumn 
from openrowset(bulk 'C:\Users\Aslbek Rakhmatov\Downloads\Telegram Desktop\IMG_2257.PNG', single_blob)
as image;

select * from photos;