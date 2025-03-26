use lesson1;

drop table if exists invoices;
create table invoices
(
	invoice_id int identity(1,1) primary key, 
	amount decimal
);

insert into invoices(amount)
values 
(563876),
(759837),
(496),
(774.6),
(1);

select * from invoices;

set identity_insert invoices on;

insert into invoices(invoice_id, amount)
values (100, 135.13);

set identity_insert invoices off;

select * from invoices;