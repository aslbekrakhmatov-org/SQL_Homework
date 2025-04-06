use lesson7;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);


INSERT INTO Customers VALUES 
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Orders VALUES 
(101, 1, '2024-01-01'), (102, 1, '2024-02-15'),
(103, 2, '2024-03-10'), (104, 2, '2024-04-20');

INSERT INTO OrderDetails VALUES 
(1, 101, 1, 2, 10.00), (2, 101, 2, 1, 20.00),
(3, 102, 1, 3, 10.00), (4, 103, 3, 5, 15.00),
(5, 104, 1, 1, 10.00), (6, 104, 2, 2, 20.00);

INSERT INTO Products VALUES 
(1, 'Laptop', 'Electronics'), 
(2, 'Mouse', 'Electronics'),
(3, 'Book', 'Stationery');

--task1
select 
c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate
from Customers c
left join Orders o
on c.CustomerID=o.CustomerID

--task2
select 
c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate
from Customers c
left join Orders o
on c.CustomerID=o.CustomerID
where o.OrderID is null

-- task3

select 
o.OrderID, od.ProductID, od.Price, od.Quantity
from Orders o
join OrderDetails od
on o.OrderID = od.OrderID

--task4
select c.CustomerID, c.CustomerName
from Customers c
join orders o
on c.CustomerID=o.CustomerID
group by c.CustomerID, c.CustomerName
having COUNT(o.OrderID)>1

--task5
with Max_Product_Table as (SELECT o.OrderID, max(Price) as MaxPrice
	from Orders o
	join OrderDetails od
	on o.OrderID=od.OrderID
	group by o.OrderID)

select MPT.OrderID, od.ProductID ,MPT.MaxPrice
from Max_Product_Table MPT
join OrderDetails od
on MPT.OrderID=od.OrderID
where MPT.MaxPrice=od.Price

--task6
with Cus_Ord_Table as (select c.CustomerID, c.CustomerName, o.OrderDate, o.OrderID,
ROW_NUMBER() over(partition by c.CustomerID order by o.OrderDate desc) as date_rank
from Customers c
join Orders o
on c.CustomerID=o.CustomerID)
select  CustomerName, OrderDate, OrderID
from Cus_Ord_Table 
where date_rank=1;

--task7
select c.CustomerName
from (select p.ProductID,
p.Category,
od.OrderID,
case when p.Category='Electronics' then 0 else 1 end as NotElectronics
from Products p
join OrderDetails od
on p.ProductID=od.ProductID) as OD_Prd
join Orders o
on o.OrderID=OD_Prd.OrderID
join Customers c
on c.CustomerID=o.CustomerID
group by c.CustomerName
having sum(OD_Prd.NotElectronics)=0;

--task8
select c.CustomerName
from (select p.ProductID,
p.Category,
od.OrderID,
case when p.Category='Stationery' then 1 else 0 end as Stationery
from Products p
join OrderDetails od
on p.ProductID=od.ProductID) as OD_Prd
join Orders o
on o.OrderID=OD_Prd.OrderID
join Customers c
on c.CustomerID=o.CustomerID
group by c.CustomerName
having sum(OD_Prd.Stationery)>=1;

-- task9
with TotalSpent_Table as (select o.CustomerID, sum(od.Price*od.Quantity) as TotalSpent
from OrderDetails od
join Orders o
on od.OrderID=o.OrderID
group by o.CustomerID)

select tst.CustomerID, c.CustomerName, tst.TotalSpent
from TotalSpent_Table tst
join Customers c
on tst.CustomerID=c.CustomerID

