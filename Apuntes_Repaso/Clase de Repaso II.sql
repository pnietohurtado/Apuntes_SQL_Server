-- Clase II de Repaso de SQL 

SELECT * FROM tblEmployee

SELECT 
	-- year(e.DateOfBirth),  Esto no tiene ningún sentido 
	MAX(e.EmployeeNumber) as MaxEmployeeNumber 
FROM tblEmployee e
-- GROUP BY e.DateOfBirth Esto tampoco lo tiene 


SELECT * FROM tblEmployee
SELECT * FROM tblTransaction

SELECT 
	e.EmployeeFirstName AS FirstName, 
	e.EmployeeLastName AS LasName, 
	SUM(t.Amount) AS Total 
FROM tblEmployee e
	JOIN tblTransaction t ON e.EmployeeNumber = t.EmployeeNumber
GROUP BY e.EmployeeFirstName, e.EmployeeLastName
HAVING SUM(t.Amount) > 0


SELECT 
	e.EmployeeFirstName AS FirstName, 
	e.EmployeeLastName AS LasName, 
	SUM(t.Amount) AS Total 
FROM tblEmployee e
	JOIN tblTransaction t ON e.EmployeeNumber = t.EmployeeNumber
WHERE e.EmployeeNumber = 1046
GROUP BY e.EmployeeFirstName, e.EmployeeLastName


SELECT * FROM tblTransaction WHERE tblTransaction.EmployeeNumber = 1046

-- No hay 1046 EmployeeNumber, porque no hay transacción de este empleado en la tabla de transacciones 



-- Para incluir a este empleado hacemos los siguiente 

SELECT 
	e.EmployeeNumber AS Number, 
	e.EmployeeFirstName AS FirstName, 
	e.EmployeeLastName AS LasName, 
	SUM(t.Amount) AS Total 
FROM tblEmployee e
	LEFT JOIN tblTransaction t ON e.EmployeeNumber = t.EmployeeNumber
WHERE e.EmployeeNumber > 1010
GROUP BY e.EmployeeFirstName, e.EmployeeLastName, e.EmployeeNumber



-- Darnos el número de empleados por departamento 
SELECT 
	t.Department, 
	COUNT(*) AS NumberOfDepartment 
FROM tblEmployee t
GROUP BY t.Department
GO; 


-- Contar el número de departamentos que hay 
SELECT COUNT(NewTable.Department ) AS NumberOfDepartments 
FROM
(SELECT 
	t.Department, 
	COUNT(*) AS NumberOfDepartment 
FROM tblEmployee t
GROUP BY t.Department
) as NewTable 


--
--SELECT 
--	DISTINCT t.Department, 
--	CONVERT((VARCHAR(20),N'') AS DepartmentHead 
--INTO tblDepartment t
--FROM tblEmployee
--