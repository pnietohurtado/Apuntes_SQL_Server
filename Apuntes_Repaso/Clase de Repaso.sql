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
-- HAVING COUNT(*) >= 50
ORDER BY Initial DESC



SELECT 
	DATENAME(MONTH, DateOfBirth) AS MonthNumber, 
	COUNT(*) AS NumberEmployees, 
	YEAR(DateOfBirth) 
FROM tblEmployee
GROUP BY DATENAME(MONTH, DateOfBirth ) , DATEPART(MONTH, DateOfBirth), YEAR(DateOfBirth)
ORDER BY DATEPART(MONTH, DateOfBirth)
-- *** You can't order by a value that is not in the SELECT statement, threrefore you have to 
-- include that "variable/data" into the SELECT or the GROUP BY. The problem is that adding a new 
-- data of column will bother our statement result, that's why we added that in the GROUP BY where it doesn't 
-- upset the result.



