-- Clase de repaso

SELECT 
	CONCAT(LEFT(e.EmployeeFirstName, 1),'. ' ,e.EmployeeLastName) AS Initial, 
	COUNT(*) 
FROM tblEmployee e
GROUP BY LEFT(e.EmployeeFirstName,1), e.EmployeeLastName
ORDER BY e.EmployeeLastName DESC


SELECT 
	TOP(5)  -- Brings back only the top 5 rows at the statement 
	CONCAT(LEFT(e.EmployeeFirstName, 1),'. ' ,e.EmployeeLastName) AS Initial, 
	COUNT(*) 
FROM tblEmployee e
GROUP BY LEFT(e.EmployeeFirstName,1), e.EmployeeLastName
ORDER BY e.EmployeeLastName DESC


SELECT 
	CONCAT(LEFT(e.EmployeeFirstName, 1),'. ' ,e.EmployeeLastName) AS Initial, 
	COUNT(*) 
FROM tblEmployee e
GROUP BY LEFT(e.EmployeeFirstName,1), e.EmployeeLastName
HAVING COUNT(*) >= 50
ORDER BY e.EmployeeLastName DESC