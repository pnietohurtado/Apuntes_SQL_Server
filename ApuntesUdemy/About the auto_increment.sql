-- Create a Table
-- CREATE DATABASE CursoUdemy; 
USE CursoUdemy; 
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

ALTER TABLE tblEmployee ALTER COLUMN Department VARCHAR(20); 
ALTER TABLE tblEmployee ALTER COLUMN DateOfBirth DATE NULL; 

SET IDENTITY_INSERT tblEmployee ON; --  De esta forma nos va a permitir añadir una ID específico pese a que tengamos el "IDENTITY" o "AUTO_INCREMENT". 

INSERT INTO tblEmployee(EmployeeNumber, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeGovernmentID,Department)
VALUES (134, 'Dylan', 'A', 'Word', '26524856Z' , 'Customer Relations' ),  
(133, 'Dylan', 'A', 'Word', '26524856Z' , 'Customer Relations' ),
(135, 'Dylan', 'A', 'Word', '26524856Z' , 'Customer Relations' );

SELECT * FROM tblEmployee;
