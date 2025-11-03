-- Tercera clase de Repaso 


BEGIN TRAN 

--SELECT * FROM tblTransaction WHERE EmployeeNumber = 3

UPDATE tblTransaction SET EmployeeNumber = 194
OUTPUT inserted.EmployeeNumber, deleted.EmployeeNumber
FROM tblTransaction 
WHERE EmployeeNumber = 3

--SELECT * FROM tblTransaction WHERE EmployeeNumber = 194

ROLLBACK TRAN 




SELECT
	t.EmployeeNumber AS TEmployeeNumber, 
	e.EmployeeNumber AS EEmployeeNumber, 
	SUM(Amount) AS SumAmount
FROM tblTransaction t
		left JOIN tblEmployee e ON t.EmployeeNumber = e.EmployeeNumber
GROUP BY t.EmployeeNumber, e.EmployeeNumber
ORDER BY EEmployeeNumber



BEGIN TRAN 

UPDATE tblEmployee SET DateOfBirth = '2101-01-02' 
WHERE EmployeeNumber = 537
SELECT * FROM tblEmployee ORDER BY DateOfBirth DESC

ROLLBACK TRAN 




SELECT 
		e.EmployeeGovernmentID AS ID ,
		COUNT(e.EmployeeGovernmentID) AS MyCount 
FROM tblEmployee e
GROUP BY e.EmployeeGovernmentID
HAVING COUNT(e.EmployeeGovernmentID) > 1


SELECT * FROM tblEmployee WHERE EmployeeGovernmentID IN ('HN513777D')
SELECT * FROM tblEmployee

