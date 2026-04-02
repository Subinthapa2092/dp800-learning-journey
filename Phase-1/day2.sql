-- ================================
-- DAY 2 DB-800 PRACTICE SCRIPT
-- ================================

-- 1️⃣ Create Practice Database
CREATE DATABASE myfirstdb;
GO

-- Use the database
USE myfirstdb;
GO

-- 2️⃣ Create Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Age INT NOT NULL DEFAULT 15,
    Department VARCHAR(50) DEFAULT 'Unknown'
);
GO

-- 3️⃣ Insert Data into Students Table
INSERT INTO Students (StudentID, Name, Age, Department)
VALUES
    (1, 'Subin Thapa', 18, 'Data Science'),
    (2, 'Garima Sapkota', 18, 'CSIT'),
    (3, 'Sita', 19, DEFAULT),
    (4, 'Rahul Ahikari', DEFAULT, DEFAULT),
    (5, 'Mukesh Adhikari', 17, 'Information Technology');
GO

-- 4️⃣ Select & Filter Data
-- Select all students
SELECT * FROM Students;
GO

-- Filter by name
SELECT * FROM Students WHERE Name = 'Subin Thapa';
GO

-- 5️⃣ Create Employee Table
CREATE TABLE Employee (
    Employee_id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50),
    SalaryDate DATETIME DEFAULT GETDATE()
);
GO

-- 6️⃣ Insert Data into Employee Table
INSERT INTO Employee (Name)
VALUES
    ('Subin Thapa'),
    ('Rahul Ahikari'),
    ('Mukesh Adhikari'),
    ('Saubhagya Dhungana');
GO

-- 7️⃣ Select & Filter Employees
-- Select all employees
SELECT * FROM Employee;
GO

-- Filter employees inserted today
SELECT * FROM Employee
WHERE CAST(SalaryDate AS DATE) = CAST(GETDATE() AS DATE);
GO

-- 8️⃣ Update & Delete Practice (Optional Stretch)
-- Update department for a student
UPDATE Students
SET Department = 'Data Engineering'
WHERE Name = 'Sita';
GO

-- Delete one employee
DELETE FROM Employee
WHERE Name = 'Mukesh Adhikari';
GO

-- Check auto-increment after deletion
INSERT INTO Employee (Name) VALUES ('New Employee');
SELECT * FROM Employee;
GO