/* 
    EASY 
   

/* 1) EmployeeName, Salary, DepartmentName */
SELECT e.Name AS EmployeeName, e.Salary, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE e.Salary > 50000;

/* 2) FirstName, LastName, OrderDate — orders in 2023 */
SELECT c.FirstName, c.LastName, o.OrderDate
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023;

/* 3) All employees with (possibly NULL) department name */
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON d.DepartmentID = e.DepartmentID;

/* 4) All suppliers and the products they supply (include suppliers with none) */
SELECT s.SupplierName, p.ProductName
FROM Suppliers s
LEFT JOIN Products p ON p.SupplierID = s.SupplierID
ORDER BY s.SupplierName, p.ProductName;

/* 5) Orders and payments, include unmatched on both sides */
SELECT 
  COALESCE(o.OrderID, p.OrderID) AS OrderID,
  o.OrderDate,
  p.PaymentDate,
  p.Amount
FROM Orders o
FULL OUTER JOIN Payments p ON p.OrderID = o.OrderID
ORDER BY OrderID;

/* 6) Employee -> Manager mapping */
SELECT e.Name AS EmployeeName, m.Name AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON m.EmployeeID = e.ManagerID;

/* 7) Students enrolled in 'Math 101' */
SELECT s.Name AS StudentName, c.CourseName
FROM Enrollments en
JOIN Students s   ON s.StudentID = en.StudentID
JOIN Courses  c   ON c.CourseID  = en.CourseID
WHERE c.CourseName = 'Math 101';

/* 8) Customers with an order where Quantity > 3 (per order row) */
SELECT c.FirstName, c.LastName, o.Quantity
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.Quantity > 3;

/* 9) Employees in 'Human Resources' */
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName = 'Human Resources';


/* 
   MEDIUM 
 */

/* 1) Departments with more than 5 employees */
SELECT d.DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(*) > 5;

/* 2) Products never sold (no rows in Sales) */
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Sales s ON s.ProductID = p.ProductID
WHERE s.ProductID IS NULL;

/* 3) Customers who placed at least one order + their total */
SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
GROUP BY c.FirstName, c.LastName;

/* 4) Only rows where both employee and department exist (inner join) */
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID;

/* 5) Pairs of employees with the same ManagerID */
SELECT e1.Name AS Employee1, e2.Name AS Employee2, e1.ManagerID
FROM Employees e1
JOIN Employees e2 
  ON e1.ManagerID = e2.ManagerID 
 AND e1.EmployeeID < e2.EmployeeID
WHERE e1.ManagerID IS NOT NULL;

/* 6) Orders in 2022 with customer name */
SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2022;

/* 7) Sales dept employees with salary > 60000 */
SELECT e.Name AS EmployeeName, e.Salary, d.DepartmentName
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName = 'Sales' AND e.Salary > 60000;

/* 8) Only orders that HAVE a payment */
SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
FROM Orders o
JOIN Payments p ON p.OrderID = o.OrderID;

/* 9) Products never ordered (Orders table) */
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Orders o ON o.ProductID = p.ProductID
WHERE o.ProductID IS NULL;


/* 
    HARD 
*/

/* 1) Employees with salary > dept average */
SELECT e.Name AS EmployeeName, e.Salary
FROM Employees e
WHERE e.Salary > (
  SELECT AVG(e2.Salary) FROM Employees e2
  WHERE e2.DepartmentID = e.DepartmentID
);

/* 2) Orders before 2020 with NO payment */
SELECT o.OrderID, o.OrderDate
FROM Orders o
LEFT JOIN Payments p ON p.OrderID = o.OrderID
WHERE o.OrderDate < '2020-01-01'
  AND p.OrderID IS NULL;

/* 3) Products without a matching category */
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Categories c ON c.CategoryID = p.Category
WHERE c.CategoryID IS NULL;

/* 4) Employee pairs with same manager AND both salaries > 60000 */
SELECT 
  e1.Name AS Employee1,
  e2.Name AS Employee2,
  e1.ManagerID,
  CASE WHEN e1.Salary < e2.Salary THEN e1.Salary ELSE e2.Salary END AS Salary
FROM Employees e1
JOIN Employees e2 
  ON e1.ManagerID = e2.ManagerID 
 AND e1.EmployeeID < e2.EmployeeID
WHERE e1.ManagerID IS NOT NULL
  AND e1.Salary > 60000
  AND e2.Salary > 60000;

/* 5) Employees in departments starting with 'M' */
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName LIKE 'M%';

/* 6) Sales with amount > 500 including product names */
SELECT s.SaleID, p.ProductName, s.SaleAmount
FROM Sales s
JOIN Products p ON p.ProductID = s.ProductID
WHERE s.SaleAmount > 500;

/* 7) Students NOT enrolled in 'Math 101' */
SELECT s.StudentID, s.Name AS StudentName
FROM Students s
WHERE NOT EXISTS (
  SELECT 1
  FROM Enrollments en
  JOIN Courses c ON c.CourseID = en.CourseID
  WHERE en.StudentID = s.StudentID
    AND c.CourseName = 'Math 101'
);

/* 8) Orders missing payment details */
SELECT o.OrderID, o.OrderDate, p.PaymentID
FROM Orders o
LEFT JOIN Payments p ON p.OrderID = o.OrderID
WHERE p.PaymentID IS NULL;

/* 9) Products in 'Electronics' or 'Furniture' */
SELECT p.ProductID, p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON c.CategoryID = p.Category
WHERE c.CategoryName IN ('Electronics','Furniture');
  
