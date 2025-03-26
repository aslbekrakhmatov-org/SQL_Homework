use lesson1;

drop table if exists book;
create table book(
	book_id int Primary Key,
	title varchar(100),
	author varchar(100),
	published_year int check (published_year >= 1400 AND published_year <= YEAR(GETDATE()))
)

drop table if exists member;
create table member(
	member_id int Primary Key,
	name varchar(100),
	email varchar(100),
	phone_number  varchar(50)
)

drop table if exists loan;
create table loan(
	loan_id int Primary Key,
	book_id int,
	constraint FK_book_id foreign key (book_id) references book(book_id),
	member_id int,
	constraint FK_member_id foreign key (member_id) references member(member_id),
	loan_date date not null,
	return_date date default null
);

-- inserting

INSERT INTO book (book_id, title, author, published_year) VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', 1960),
(2, '1984', 'George Orwell', 1949),
(3, 'The Great Gatsby', 'F. Scott Fitzgerald', 1925);

INSERT INTO member (member_id, name, email, phone_number) VALUES
(101, 'Alice Johnson', 'alice@example.com', '123-456-7890'),
(102, 'Bob Smith', 'bob@example.com', '987-654-3210'),
(103, 'Charlie Brown', 'charlie@example.com', '555-123-4567');

INSERT INTO loan (loan_id, book_id, member_id, loan_date, return_date) VALUES
(201, 1, 101, '2025-03-01', '2025-03-15'),
(202, 2, 102, '2025-03-05', NULL), -- Still borrowed
(203, 3, 103, '2025-03-10', NULL); -- Still borrowed


SELECT * FROM book;
SELECT * FROM member;
SELECT * FROM loan;