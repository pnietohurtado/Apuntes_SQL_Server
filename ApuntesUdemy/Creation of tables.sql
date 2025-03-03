-- Create a Table
CREATE DATABASE CursoUdemy; 

CREATE TABLE tblEmployee
(
	EmployeeNumber INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
	EmployeeFirstName VARCHAR(50) NOT NULL, 
	EmployeeMiddleName VARCHAR(20) NULL, 
	EmployeeLastName VARCHAR(20) NOT NULL, 
	EmployeeGovernmentID CHAR(10) NULL, 
	DateOfBirth DATE NOT NULL
); 

ALTER TABLE tblEmployee ADD Department VARCHAR(10); 

ALTER TABLE tblEmployee ALTER COLUMN Department VARCHAR(15); 
ALTER TABLE tblEmployee ALTER COLUMN DateOfBirth DATE NULL; 

INSERT INTO tblEmployee(EmployeeNumber, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeGovernmentID,Department)
VALUES (132, 'Dylan', 'A', 'Word', '26524856Z' , 'Customer Relations' ); 