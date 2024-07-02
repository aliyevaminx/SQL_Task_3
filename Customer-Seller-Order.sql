CREATE TABLE Sellers (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50),
	Surname NVARCHAR(50),
	City NVARCHAR(50)
)

INSERT INTO Sellers
VALUES
	('SellerName1', 'SellerSurname1', 'Sumqayit' ),
	('SellerName2', 'SellerSurname2', 'Baki' ),
	('SellerName3', 'SellerSurname3', 'Gence' ),
	('SellerName4', 'SellerSurname4', 'Mingecevir' ),
	('SellerName5', 'SellerSurname5', 'Xacmaz' ),
	('SellerName6', 'SellerSurname6', 'Sumqayit' )

CREATE TABLE Customers (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50),
	Surname NVARCHAR(50),
	City NVARCHAR(50)
)

INSERT INTO Customers
VALUES
	('CustomerName1', 'CustomerSurname1', 'Mingecevir' ),
	('CustomerName2', 'CustomerSurname2', 'Sumqayit' ),
	('CustomerName3', 'CustomerSurname3', 'Balaken' ),
	('CustomerName4', 'CustomerSurname4', 'Sumqayit' ),
	('CustomerName5', 'CustomerSurname5', 'Sumqayit' ),
	('CustomerName6', 'CustomerSurname6', 'Balaken' )

CREATE TABLE Orders (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	OrderDate DATE,
	Amount DECIMAL(16, 2),
	[State] NVARCHAR(50),
	SellerId INT,
	CustomerId INT,
	FOREIGN KEY(SellerId) REFERENCES Sellers(Id),
	FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
)  

INSERT INTO Orders
VALUES
	('2024-06-03', 560, 'Catdirilmada', 2, 1),
	('2024-06-05', 560, 'Catdirilmada', 4, 1),
	('2024-06-07', 560, 'Catdirilmada', 4, 1),
	('2024-06-08', 560, 'Catdirilmada', 2, 1),
	('2004-06-03', 560, 'Catdirilmada', 3, 1),
	('2004-06-03', 560, 'Catdirilmada', 2, 1),
	('2004-06-03', 560, 'Catdirilmada', 2, 1),
	('2024-06-03', 560, 'Catdirilmada', 2, 1),
	('2004-02-03', 560, 'Tamamlanib', 3, 1),
	('2004-02-03', 560, 'Tamamlanib', 3, 1),
	('2004-02-03', 560, 'Tamamlanib', 3, 1),
	('2004-02-03', 560, 'Tamamlanib', 3, 1),
	('2004-02-03', 560, 'Tamamlanib', 3, 1),
	('2004-02-03', 560, 'Tamamlanib', 3, 1),
	('2004-02-03', 560, 'Tamamlanib', 3, 1),
	('2004-02-03', 560, 'Tamamlanib', 3, 1),
	('2004-02-03', 560, 'Tamamlanib', 3, 1),
	('2024-04-04', 1203.43, 'Catdirilmada', 4, 5 ),
	('2024-02-05', 423.42, 'Tamamlanib', 3, 2),
	('2004-02-03', 1245.52, 'Tamamlanib', 3, 1),
	('2004-02-03', 560, 'Tamamlanib', 3, 1),
	('2004-02-03', 900, 'Tamamlanib', 3, 1),
	('2004-02-03', 4215.23, 'Tamamlanib', 3, 1),
	('2000-02-02', 2142.52, 'Catdirilmada', 2, 4)

SELECT * FROM Customers
SELECT * FROM Sellers
SELECT * FROM Orders

SELECT c.Name AS CustomerName, c.Surname AS CustomerSurname, SUM(o.Amount) AS TotalAmount 
FROM Customers c
JOIN Orders o ON c.Id = o.CustomerId
GROUP BY c.Id, c.Name, c.Surname
HAVING SUM(o.Amount) > 1000

SELECT c.Name AS CustomerName, c.Surname AS CustomerSurname, s.Name AS SellerName, s.Surname AS SellerSurname, c.City AS CityName
FROM Customers c
JOIN Sellers s ON s.City = c.City

SELECT o.OrderDate AS OrderDate, o.State AS OrderStatus, o.Amount AS TotalAmount ,c.Name AS CustomerName, c.Surname AS CustomerSurname, s.Name AS SellerName, s.Surname AS SellerSurname
FROM Orders o
JOIN Customers c ON o.CustomerId = c.Id
JOIN Sellers s ON o.SellerId = s.Id
WHERE o.OrderDate >= '2024-01-04' AND o.State = 'Tamamlanib'

SELECT s.Name AS SellerName, s.Surname AS SellerSurname, COUNT(o.Id) AS CompletedOrders
FROM Sellers s
JOIN Orders o ON s.Id = o.SellerId
WHERE o.State = 'Tamamlanib'
GROUP BY s.Id, s.Name, s.Surname
HAVING COUNT(o.Id) > 10
		
SELECT c.Name AS CustomerName, c.Surname AS CustomerSurname, COUNT(o.Id) AS OrderCount
FROM Customers c
JOIN Orders o ON c.Id = o.CustomerId
GROUP BY c.Id, c.Name, c.Surname
ORDER BY COUNT(o.Id) DESC

SELECT o.Id AS OrderId, o.OrderDate AS OrderDate, o.Amount AS OrderAmount, o.State AS OrderStatus, s.Name AS SellerName, s.Surname AS SellerSurname
FROM Orders o
JOIN Sellers s ON o.SellerId = s.Id
WHERE o.State = 'Catdirilmada'
ORDER BY o.OrderDate 

SELECT o.Id AS OrderId, o.OrderDate AS OrderDate, o.State AS OrderStatus, o.Amount AS TotalAmount ,c.Name AS CustomerName, c.Surname AS CustomerSurname, s.Name AS SellerName, s.Surname AS SellerSurname
FROM Orders o
JOIN Customers c ON o.CustomerId = c.Id
JOIN Sellers s ON o.SellerId = s.Id
WHERE o.State != 'Tamamlanib' AND DATEDIFF(month, o.OrderDate, GETDATE()) <= 1