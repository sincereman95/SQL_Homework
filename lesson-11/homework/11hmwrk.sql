/* 
    EASY-LEVEL 
  */

/* 1) Orders after 2022 with customer names */
SELECT 
    o.OrderID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderDate
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.OrderDate > '2022-12-31';

/* 2) Employees in Sales or Marketing */
SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName IN ('Sales','Marketing');

/* 3) Highest salary per department */
SELECT 
    d.DepartmentName,
    MAX(e.Salary) AS MaxSalary
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;

/* 4) USA customers who placed orders in 2023 */
SELECT
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    o.OrderDate
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA'
  AND YEAR(o.OrderDate) = 2023;

/* 5) How many orders each customer has placed (include zero) */
SELECT
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON o.CustomerID = c.CustomerID
GROUP BY CONCAT(c.FirstName, ' ', c.LastName)
ORDER BY CustomerName;

/* 6) Products supplied by Gadget Supplies or Clothing Mart */
SELECT 
    p.ProductName,
    s.SupplierName
FROM Products p
JOIN Suppliers s ON s.SupplierID = p.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies','Clothing Mart');

/* 7) Most recent order per customer (include customers with no orders) */
SELECT
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
LEFT JOIN Orders o ON o.CustomerID = c.CustomerID
GROUP BY CONCAT(c.FirstName, ' ', c.LastName)
ORDER BY CustomerName;


/* 
   MEDIUM-LEVEL (6)
*/

/* 1) Customers with any order where TotalAmount > 500 */
SELECT
    DISTINCT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.TotalAmount AS OrderTotal
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.TotalAmount > 500;

/* 2) Product sales in 2022 OR SaleAmount > 400 */
SELECT
    p.ProductName,
    s.SaleDate,
    s.SaleAmount
FROM Sales s
JOIN Products p ON p.ProductID = s.ProductID
WHERE YEAR(s.SaleDate) = 2022
   OR s.SaleAmount > 400;

/* 3) Each product with total sales amount (include products never sold) */
SELECT
    p.ProductName,
    ISNULL(SUM(s.SaleAmount), 0) AS TotalSalesAmount
FROM Products p
LEFT JOIN Sales s ON s.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY p.ProductName;

/* 4) Employees in HR (Human Resources) with Salary > 60000 */
SELECT
    e.Name AS EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE (d.DepartmentName IN ('Human Resources','HR'))
  AND e.Salary > 60000;

/* 5) Products sold in 2023 AND had >100 in stock (using current StockQuantity) */
SELECT
    p.ProductName,
    s.SaleDate,
    p.StockQuantity
FROM Sales s
JOIN Products p ON p.ProductID = s.ProductID
WHERE YEAR(s.SaleDate) = 2023
  AND p.StockQuantity > 100;

/* 6) Employees who work in Sales OR were hired after 2020 */
SELECT
    e.Name AS EmployeeName,
    d.DepartmentName,
    e.HireDate
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName = 'Sales'
   OR e.HireDate > '2020-12-31'
ORDER BY e.HireDate;


/* 
   🔴 HARD-LEVEL (6 provided)
*/

/* 1) USA orders where Address starts with 4 digits */
SELECT
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    c.Address,
    o.OrderDate
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA'
  AND c.Address LIKE '[0-9][0-9][0-9][0-9]%';

/* 2) Sales for Electronics category OR SaleAmount > 350
      Note: Products.Category is INT now; join to Categories for name. */
SELECT
    p.ProductName,
    cat.CategoryName AS Category,
    s.SaleAmount
FROM Sales s
JOIN Products p ON p.ProductID = s.ProductID
LEFT JOIN Categories cat ON cat.CategoryID = p.Category
WHERE (cat.CategoryName = 'Electronics') OR (s.SaleAmount > 350);

/* 3) Number of products available in each category */
SELECT
    cat.CategoryName,
    COUNT(p.ProductID) AS ProductCount
FROM Categories cat
LEFT JOIN Products p ON p.Category = cat.CategoryID
GROUP BY cat.CategoryName
ORDER BY cat.CategoryName;

/* 4) Orders where customer is from Los Angeles and amount > 300 */
SELECT
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    c.City,
    o.OrderID,
    o.TotalAmount AS Amount
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
WHERE c.City = 'Los Angeles'
  AND o.TotalAmount > 300;

/* 5) Employees in HR or Finance, OR name contains at least 4 vowels */
SELECT
    e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName IN ('Human Resources','Finance')
   OR (
        /* Count vowels a,e,i,o,u in the name (case-insensitive) */
        (LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name),'a','')))
      + (LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name),'e','')))
      + (LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name),'i','')))
      + (LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name),'o','')))
      + (LEN(LOWER(e.Name)) - LEN(REPLACE(LOWER(e.Name),'u','')))
      >= 4
      )
ORDER BY EmployeeName;

/* 6) Employees in Sales or Marketing AND salary > 60000 */
SELECT
    e.Name AS EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName IN ('Sales','Marketing')
  AND e.Salary > 60000
ORDER BY e.Salary DESC;
