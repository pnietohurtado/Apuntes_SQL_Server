-- Clase del 18/06/2025

BEGIN TRANSACTION MarkedTransaction WITH MARK 
SELECT 
	* 
FROM [dbo].tblEmployee

UPDATE tblEmployee SET EmployeeNumber = 122 WHERE EmployeeNumber = 123
ROLLBACK TRAN 
GO 





BEGIN TRAN 
	SELECT @@TRANCOUNT
	BEGIN TRAN 
		UPDATE tblEmployee SET EmployeeNumber = 122 WHERE EmployeeNumber = 123
	COMMIT TRAN 
ROLLBACK TRAN -- En este caso da igual que se haga el commit dentro ya que el "ROLLBACK TRAN" de fuera cancela todo lo que esté dentro de la transacción 
SELECT @@TRANCOUNT

SELECT * FROM tblEmployee
UPDATE tblEmployee SET EmployeeNumber = 123 WHERE EmployeeNumber = 122





BEGIN TRAN 
SELECT * FROM tblEmployee
COMMIT TRAN 

BEGIN TRAN 
UPDATE tblEmployee SET EmployeeNumber = 122 WHERE EmployeeNumber = 123 
WAITFOR DELAY '00:00:10' -- Se va a encargar de retrasar la ejecución de la transacción durante 10 segundos 
ROLLBACK TRAN






