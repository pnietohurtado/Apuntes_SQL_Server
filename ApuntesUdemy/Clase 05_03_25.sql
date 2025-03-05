-- Clase del 05.03.2025

USE CursoUdemy 
GO

SELECT * FROM tblEmployee; 

SELECT 
		* 
FROM tblEmployee
WHERE EmployeeFirstName <> 'Pepe';

SELECT *
FROM tblEmployee
WHERE NOT (EmployeeNumber > 132 AND EmployeeNumber < 135); 

