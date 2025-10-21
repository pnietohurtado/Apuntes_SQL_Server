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



SELECT 
	DISTINCT d.Department AS Department, 
	SUM(tr.Amount) AS Total 
FROM tblDepartment d
	LEFT JOIN tblEmployee t ON d.Department = t.Department 
	LEFT JOIN tblTransaction tr ON t.EmployeeNumber = tr.EmployeeNumber
GROUP BY d.Department
ORDER BY SUM(tr.Amount) DESC


INSERT INTO tblDepartment(Department,DepartmentHead) VALUES ('Accounts', 'James'); 
DELETE tblDepartment WHERE tblDepartment.DepartmentHead LIKE 'James'; 





SELECT 
	e.EmployeeNumber AS ENumber, 
	e.EmployeeFirstName AS EFirstName, 
	e.EmployeeLastName AS ELastName, 
	t.EmployeeNumber AS TNumber, 
	SUM(t.Amount) AS TotalAmount 
FROM tblEmployee e 
	LEFT JOIN tblTransaction t ON e.EmployeeNumber = t.EmployeeNumber
WHERE t.EmployeeNumber IS NULL 
GROUP BY e.EmployeeNumber, e.EmployeeFirstName, e.EmployeeLastName, t.EmployeeNumber
ORDER BY e.EmployeeNumber, e.EmployeeFirstName, e.EmployeeLastName, t.EmployeeNumber ASC 

 -- subconsulta 

SELECT tble.EFirstName, tble.ELastName, tble.ENumber
FROM (
SELECT 
	e.EmployeeNumber AS ENumber, 
	e.EmployeeFirstName AS EFirstName, 
	e.EmployeeLastName AS ELastName, 
	t.EmployeeNumber AS TNumber, 
	SUM(t.Amount) AS TotalAmount 
FROM tblEmployee e 
	LEFT JOIN tblTransaction t ON e.EmployeeNumber = t.EmployeeNumber
WHERE t.EmployeeNumber IS NULL 
GROUP BY e.EmployeeNumber, e.EmployeeFirstName, e.EmployeeLastName, t.EmployeeNumber
-- ORDER BY e.EmployeeNumber, e.EmployeeFirstName, e.EmployeeLastName, t.EmployeeNumber ASC 
) AS tble
WHERE tble.TNumber IS NULL 




SELECT *
FROM (
SELECT 
	e.EmployeeNumber AS ENumber, 
	e.EmployeeFirstName AS EFirstName, 
	e.EmployeeLastName AS ELastName, 
	t.EmployeeNumber AS TNumber, 
	SUM(t.Amount) AS TotalAmount 
FROM tblEmployee e 
	RIGHT JOIN tblTransaction t ON e.EmployeeNumber = t.EmployeeNumber
WHERE t.EmployeeNumber IS NULL 
GROUP BY e.EmployeeNumber, e.EmployeeFirstName, e.EmployeeLastName, t.EmployeeNumber
-- ORDER BY e.EmployeeNumber, e.EmployeeFirstName, e.EmployeeLastName, t.EmployeeNumber ASC 
) AS tble
WHERE tble.ENumber IS NULL 