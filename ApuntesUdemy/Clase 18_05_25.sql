-- Clase del 18.05.2025

BEGIN TRANSACTION 

SELECT * FROM tblEmployee; 
UPDATE tblEmployee SET EmployeeNumber = 122 
WHERE EmployeeNumber = 123; 

COMMIT TRAN 