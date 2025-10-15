EASY LEVEL (10)

-- 1. Find the minimum price of a product
SELECT MIN(Price) AS MinPrice FROM Products;

-- 2. Find the maximum salary
SELECT MAX(Salary) AS MaxSalary FROM Employees;

-- 3. Count number of rows in Customers table
SELECT COUNT(*) AS TotalCustomers FROM Customers;

-- 4. Count number of unique product categories
SELECT COUNT(DISTINCT Category) AS UniqueCategories FROM Products;

-- 5. Total sales amount for product with id 7
SELECT SUM(SaleAmount) AS TotalSalesForProduct7
FROM Sales
WHERE ProductID = 7;

-- 6. Average age of employees
SELECT AVG(Age) AS AverageEmployeeAge FROM Employees;

-- 7. Number of employees in each department
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

-- 8. Min and Max price of products grouped by Category
SELECT Category, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

-- 9. Total sales per Customer
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

-- 10. Departments having more than 5 employees
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;

MEDIUM LEVEL (9)
-- 1. Total and average sales for each product category
SELECT P.Category, SUM(S.SaleAmount) AS TotalSales, AVG(S.SaleAmount) AS AvgSales
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY P.Category;

-- 2. Count number of employees from Department HR
SELECT COUNT(*) AS HREmployees
FROM Employees
WHERE DepartmentName = 'HR';

-- 3. Highest and lowest salary by department
SELECT DepartmentName, MAX(Salary) AS HighestSalary, MIN(Salary) AS LowestSalary
FROM Employees
GROUP BY DepartmentName;

-- 4. Average salary per department
SELECT DepartmentName, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName;

-- 5. AVG salary and COUNT of employees in each department
SELECT DepartmentName, AVG(Salary) AS AvgSalary, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

-- 6. Product categories with average price > 400
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;

-- 7. Total sales for each year
SELECT YEAR(SaleDate) AS SaleYear, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate);

-- 8. Customers who placed at least 3 orders
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;

-- 9. Departments with average salary > 60000
SELECT DepartmentName, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000;


HARD LEVEL (6)
-- 1. Average price per product category, filter >150
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;

-- 2. Total sales per customer, filter >1500
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;

-- 3. Total and average salary per department, filter >65000
SELECT DepartmentName, SUM(Salary) AS TotalSalary, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000;

-- 4. Total amount for orders > $50 for each customer with least purchase
-- (Assuming Orders.TotalAmount and Orders.Freight analog)
SELECT CustomerID,
       SUM(TotalAmount) AS TotalAbove50,
       MIN(TotalAmount) AS LeastPurchase
FROM Orders
WHERE TotalAmount > 50
GROUP BY CustomerID;

-- 5. Total sales and count of unique products sold in each month-year, filter months with >=2 products sold
SELECT YEAR(OrderDate) AS OrderYear,
       MONTH(OrderDate) AS OrderMonth,
       SUM(TotalAmount) AS TotalSales,
       COUNT(DISTINCT ProductID) AS UniqueProducts
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2;

-- 6. MIN and MAX order quantity per Year
SELECT YEAR(OrderDate) AS OrderYear,
       MIN(Quantity) AS MinQuantity,
       MAX(Quantity) AS MaxQuantity
FROM Orders
GROUP BY YEAR(OrderDate);


