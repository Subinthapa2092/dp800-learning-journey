--- Creation of Students table with specified columns and constraints
-- Using the PostgreSQL syntax for creating a table and inserting values
CREATE TABLE Students(
StudentID int primary key,
Name varchar(50) Not null,
Age int not null default 15,
Department Varchar(50) Default 'Unknown' --- '' is used insted of " " in sql 
);

--- Inserting the Values in the Table:: 
insert into Students(studentid,name,age,department)
values
(1,'Subin Thapa',18,'Data Science'),
(2,'Garima Sapkota',18,'Csit'),
(3,'Sita',19,Default);

-- Filtering the name of Students::
select *from Students where name = 'Subin Thapa';
-- Types of the comment- single line(--)
/*
This is a Multi Line Comment in the SQl
*/
-- Creating the Employee Table with specified columns and constraints
CREATE TABLE employee (
    Employee_id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50),
    salaryDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Inserting values into the Employee table

insert into  employee(name)
values
('Subin Thapa'),
('Rahul Ahikari'),
('Mukesh Adhikari'),
('Saubhagya Dhungana');