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