
------------------------------------------------------
-- LESSON 3: Importing and Exporting Data (SQL Server)
-- Covers: BULK INSERT, Constraints, Identity, NULLs
------------------------------------------------------

------------------------------------------------------
-- 🟢 EASY LEVEL TASKS
------------------------------------------------------

-- 1. Define BULK INSERT
-- BULK INSERT imports data from a file into a SQL Server table quickly.

-- 2. File formats: CSV, TXT, XLSX, XML/JSON

-- 3. Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

-- 4. Insert records
INSERT INTO Products (ProductID, ProductName, Price)
VALUES 
(1, 'Laptop', 1200.00),
(2, 'Phone', 700.00),
(3, 'Tablet', 450.00);

-- 5. NULL vs NOT NULL explained in theory.

-- 6. Add UNIQUE constraint to ProductName
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

-- 7. Comment example
-- This query adds a unique constraint to the ProductName column

-- 8. Add CategoryID column
ALTER TABLE Products
ADD CategoryID INT;

-- 9. Create Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

-- 10. IDENTITY example
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    OrderName VARCHAR(50)
);

------------------------------------------------------
-- 🟠 MEDIUM LEVEL TASKS
------------------------------------------------------

-- 1. BULK INSERT example
-- (Assumes file C:\Data\products.txt exists)
-- BULK INSERT Products
-- FROM 'C:\Data\products.txt'
-- WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);

-- 2. Add FOREIGN KEY
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

-- 3. PRIMARY vs UNIQUE explained in theory.

-- 4. CHECK constraint (Price > 0)
ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

-- 5. Add Stock column (NOT NULL)
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

-- 6. ISNULL example
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;

-- 7. FOREIGN KEY purpose: maintains referential integrity.

------------------------------------------------------
-- 🔴 HARD LEVEL TASKS
------------------------------------------------------

-- 1. Customers table with CHECK (Age >= 18)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Age INT CHECK (Age >= 18)
);

-- 2. Table with IDENTITY starting at 100 incrementing by 10
CREATE TABLE Invoices (
    InvoiceID INT IDENTITY(100,10) PRIMARY KEY,
    InvoiceDate DATE
);

-- 3. Composite PRIMARY KEY
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);

-- 4. COALESCE vs ISNULL explained in theory.

-- 5. Employees table with UNIQUE Email
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

-- 6. FOREIGN KEY with CASCADE actions
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories_Cascade
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID)
ON DELETE CASCADE
ON UPDATE CASCADE;
