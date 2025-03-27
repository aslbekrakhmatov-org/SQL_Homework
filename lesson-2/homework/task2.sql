use lesson2;

drop table if exists demo_data_types;
create table demo_data_types
(
	id int primary key,
	name varchar(50),
	description text,
	blog varchar(max),
	price decimal(10,2),
	number_of_moleculas bigint,
	expiry_date date,
	currenttime time,
	ui_id uniqueidentifier
)

insert into demo_data_types
values
(1, 'Org', 'Original dfhkjsahfksd djshadkfhs dfyrkdjfhsk kjhsdfksa fhsdjhfkdsjh', 'this is my blog', 100000.246,
1234566545665234566, GETDATE(), GETUTCDATE(), NEWID());

select * from demo_data_types;

