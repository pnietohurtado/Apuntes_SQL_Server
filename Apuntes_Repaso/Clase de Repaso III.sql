-- Tercera clase de Repaso 


BEGIN TRAN 

--SELECT * FROM tblTransaction WHERE EmployeeNumber = 3

UPDATE tblTransaction SET EmployeeNumber = 194
OUTPUT inserted.EmployeeNumber, deleted.EmployeeNumber
FROM tblTransaction 
WHERE EmployeeNumber = 3

--SELECT * FROM tblTransaction WHERE EmployeeNumber = 194

ROLLBACK TRAN 