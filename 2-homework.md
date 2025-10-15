# Lesson 2: DDL and DML Commands

> **Notes before doing the tasks:**
> - Tasks should be solved using **SQL Server**.
> - Case insensitivity applies.
> - Alias names do not affect the score.
> - Scoring is based on the **correct output**.
> - One correct solution is sufficient.

---

### **Basic-Level Tasks (10)**  
1. Create a table `Employees` with columns: `EmpID` INT, `Name` (VARCHAR(50)), and `Salary` (DECIMAL(10,2)).  
2. Insert three records into the `Employees` table using different INSERT INTO approaches (single-row insert and multiple-row insert).  
3. Update the `Salary` of an employee to `7000` where `EmpID = 1`.  
4. Delete a record from the `Employees` table where `EmpID = 2`.  
5. Give a brief definition for difference between `DELETE`, `TRUNCATE`, and `DROP`.
6. Modify the `Name` column in the `Employees` table to `VARCHAR(100)`.  
7. Add a new column `Department` (`VARCHAR(50)`) to the `Employees` table.  
8. Change the data type of the `Salary` column to `FLOAT`.  
9. Create another table `Departments` with columns `DepartmentID` (INT, PRIMARY KEY) and `DepartmentName` (VARCHAR(50)).  
10. Remove all records from the `Employees` table without deleting its structure.  

---

### **Intermediate-Level Tasks (6)**  
11. Insert five records into the `Departments` table using `INSERT INTO SELECT` method(you can write anything you want as data).  
12. Update the `Department` of all employees where `Salary > 5000` to 'Management'.  
13. Write a query that removes all employees but keeps the table structure intact.   
14. Drop the `Department` column from the `Employees` table.   
15. Rename the `Employees` table to `StaffMembers` using SQL commands.  
16. Write a query to completely remove the `Departments` table from the database.  

---

### **Advanced-Level Tasks (9)**        
17. Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
18. Add a CHECK constraint to ensure Price is always greater than 0.
19. Modify the table to add a StockQuantity column with a DEFAULT value of 50.
20. Rename Category to ProductCategory
21. Insert 5 records into the Products table using standard INSERT INTO queries.
22. Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
23. Rename the Products table to Inventory.
24. Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.
25. Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to `Inventory` table.
