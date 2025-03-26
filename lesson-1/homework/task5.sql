use lesson1;
drop table if exists account;
create table account
(
	account_id integer primary key, 
	balance decimal constraint CK_account_balance check(balance>=0),
	account_type varchar(20) constraint CK_account_type check (account_type in ('Saving', 'Checking'))
);
alter table account
drop constraint CK_account_balance, CK_account_type;
alter table account
add constraint CK_account_type check (account_type in ('Saving', 'Checking'))
alter table account
add constraint CK_account_balance check (balance>=0);
