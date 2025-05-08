-- Clase del 08_05_25
BEGIN TRAN 
ALTER TABLE tblEmployee 
ADD Manager INT 
GO 
UPDATE tblEmployee
SET Manager = ((EmployeeNumber -123)/10) + 123
WHERE EmployeeNumber > 123
SELECT E.EmployeeNumber, E.EmployeeFirstName, E.EmployeeLastName, E.Manager, M.EmployeeFirstName
FROM tblEmployee AS E
	JOIN tblEmployee M ON E.Manager = M.EmployeeNumber
ROLLBACK TRAN
GO


-- The chain of command 
-- recursive CTE  (Es básicamente lo mismo que la función "WITH") 

BEGIN TRAN 
ALTER TABLE tblEmployee
ADD Manager INT 
GO 
UPDATE tblEmployee
SET Manager = ((EmployeeNumber - 123)/10)+123
WHERE EmployeeNumber > 123; 
WITH myTable AS 
(SELECT EmployeeNumber, EmployeeFirstName, EmployeeLastName, 0 AS BossLevel FROM tblEmployee WHERE Manager IS NULL
UNION ALL 
SELECT E.EmployeeNumber, E.EmployeeFirstName, E.EmployeeLastName, T.BossLevel + 1 FROM tblEmployee E JOIN myTable T ON E.Manager = T.EmployeeNumber ) 
SELECT * FROM myTable 
ROLLBACK TRAN 
GO


-- FUNCTIONS 


CREATE FUNCTION AmountPlusOne(@Amount SMALLMONEY)
RETURNS INT
AS
BEGIN

    RETURN @Amount + 1; 

END
GO

SELECT
		DateOfTransaction, 
		EmployeeNumber, 
		Amount, 
		dbo.AmountPlusOne(Amount) -- En SQLServer es necasrio que pongamos "dbo" en las funciones, esto es conocido como "schema" 
FROM tblTransaction
GO




-- Una función escalar más complicada 

IF EXISTS(
SELECT * FROM sys.objects WHERE name = 'NumberOfTransaction' ) 
DROP FUNCTION NumberOfTransaction
GO
CREATE FUNCTION NumberOfTransaction(@EmployeeNumber INT) 
RETURNS INT 
AS 
BEGIN 
	DECLARE @NumberOfTransactions INT; 

	SELECT 
			@NumberOfTransactions = COUNT(*) 
	FROM tblTransaction
	WHERE EmployeeNumber = @EmployeeNumber; 

	RETURN @NumberOfTransactions; 
END
GO 


