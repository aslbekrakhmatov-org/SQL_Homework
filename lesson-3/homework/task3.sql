use lesson3;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Products (ProductID, ProductName, Category, Price, Stock)
VALUES 
    (1, 'Laptop', 'Electronics', 1200, 15),
    (2, 'Smartphone', 'Electronics', 800, 30),
    (3, 'Desk Chair', 'Furniture', 150, 5),
    (4, 'LED TV', 'Electronics', 1400, 8),
    (5, 'Coffee Table', 'Furniture', 250, 0),
    (6, 'Headphones', 'Accessories', 200, 25),
    (7, 'Monitor', 'Electronics', 350, 12),
    (8, 'Sofa', 'Furniture', 900, 2),
    (9, 'Backpack', 'Accessories', 75, 50),
    (10, 'Gaming Mouse', 'Accessories', 120, 20);

WITH MaxPriceByCatg AS(
	SELECT Category, 
	MAX(Price) AS MaxPrice
	FROM Products P
	GROUP BY Category
)
SELECT P.*, 
	IIF(Stock=0, 'Out of stock',
	IIF(Stock BETWEEN 1 AND 10, 'Low stock', 'In Stock')
	) AS Status
FROM Products P
JOIN MaxPriceByCatg MPC
ON P.Category = MPC.Category -- AND P.Price=MPC.MaxPrice (THIS CONDITION IS FOR WHEN WE WANT TO SEE PRODUCT WHICH ARE HAVE MAXPRICE BUT I PREFER TO COMMENT IT FOR USING OFFSET)
ORDER BY P.Price DESC
OFFSET 5 ROWS;
