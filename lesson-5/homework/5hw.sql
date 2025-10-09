---------------------------------------------
-- LESSON 5: ALIASES, UNION, CASE, IIF, IF, WHILE
-- Author: Jaloliddin
-- SQL Server Practice Script
---------------------------------------------

-- 1️⃣ CREATE DATABASE AND USE IT
CREATE DATABASE Lesson5_DB;
GO
USE Lesson5_DB;
GO

---------------------------------------------
-- 2️⃣ CREATE TABLES
---------------------------------------------

-- Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

-- Products_Discounted table
CREATE TABLE Products_Discounted (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2),
    StockQuantity INT
);

-- Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Country VARCHAR(30)
);

-- Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Sales table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    SaleAmount DECIMAL(10,2)
);

---------------------------------------------
-- 3️⃣ INSERT SAMPLE DATA
---------------------------------------------

INSERT INTO Products VALUES
(1, 'Laptop', 1500),
(2, 'Mouse', 25),
(3, 'Keyboard', 45),
(4, 'Monitor', 800),
(5, 'Phone', 1200);

INSERT INTO Products_Discounted VALUES
(1, 'Laptop', 1400, 50),
(2, 'Mouse', 20, 200),
(3, 'Keyboard', 40, 150),
(6, 'Tablet', 700, 80);

INSERT INTO Customers VALUES
(1, 'Ali', 'Karimov', 'Uzbekistan'),
(2, 'Laylo', 'Rasulova', 'Kazakhstan'),
(3, 'John', 'Smith', 'Poland'),
(4, 'Aisha', 'Khan', 'UAE');

INSERT INTO Orders VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4);

INSERT INTO Sales VALUES
(1, 1, 600),
(2, 3, 150),
(3, 4, 700);

---------------------------------------------
-- 🟢 EASY LEVEL
---------------------------------------------

-- 1. Rename ProductName as Name
SELECT ProductName AS Name FROM Products;

-- 2. Rename Customers as Client
SELECT * FROM Customers AS Client;

-- 3. Combine product names using UNION
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 4. Find common product names (INTERSECT)
SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discounted;

-- 5. Distinct customers
SELECT DISTINCT FirstName, LastName, Country
FROM Customers;

-- 6. Conditional column using CASE
SELECT ProductName,
       Price,
       CASE
           WHEN Price > 1000 THEN 'High'
           ELSE 'Low'
       END AS PriceCategory
FROM Products;

-- 7. Use IIF for stock status
SELECT ProductName,
       StockQuantity,
       IIF(StockQuantity > 100, 'Yes', 'No') AS InStock
FROM Products_Discounted;

---------------------------------------------
-- 🟡 MEDIUM LEVEL
---------------------------------------------

-- 1. Combine results with UNION (again)
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 2. Products in Products but not in Discounted (EXCEPT)
SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM Products_Discounted;

-- 3. IIF for price category
SELECT ProductName,
       Price,
       IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceCategory
FROM Products;

---------------------------------------------
-- 🔴 HARD LEVEL
---------------------------------------------

-- 1. CASE for sales tiers
SELECT SaleID,
       SaleAmount,
       CASE 
           WHEN SaleAmount > 500 THEN 'Top Tier'
           WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
           ELSE 'Low Tier'
       END AS SaleCategory
FROM Sales;

-- 2. Customers who placed orders but not in Sales
SELECT CustomerID FROM Orders
EXCEPT
SELECT CustomerID FROM Sales;

-- 3. Discount percentage based on quantity
SELECT CustomerID,
       Quantity,
       CASE
           WHEN Quantity = 1 THEN '3%'
           WHEN Quantity BETWEEN 2 AND 3 THEN '5%'
           ELSE '7%'
       END AS DiscountPercentage
FROM Orders;

---------------------------------------------
