-- Clase del 12_05_25

CREATE FUNCTION TransactionList(@EmployeeNumber INT) 
RETURNS TABLE AS RETURN 
(
	SELECT 
			* 
	FROM tblTransaction
	WHERE EmployeeNumber = @EmployeeNumber
)
GO 

SELECT * FROM dbo.TransactionList(123); -- Lo ponemos en el "FROM" ya que la función devuelve una tabla 
SELECT * FROM tblEmployee WHERE EXISTS (SELECT * FROM dbo.TransactionList(EmployeeNumber))




/*
SELECT * 
FROM tblEmployee E 
LEFT JOIN TransactionList(E.EmployeeNumber) T ON E.EmployeeNumber = T.EmployeeNumber
*/ -- Esto no se puede hacer 

SELECT * 
FROM tblEmployee E 
OUTER APPLY TransactionList(E.EmployeeNumber) T -- Esta es la forma correcta 
-- Además de "OUTTER APPLY" también tenemos "CROSS APPLY" 
-- OUTER APPLY = LEFT JOIN 
-- CROSS APPLY = INNER JOIN 




-- Sinónimos 
CREATE SYNONYM EmployeeTable 
FOR tblEmployee 
GO 

SELECT * FROM EmployeeTable
GO


-- Transacciones 

SELECT * 
FROM dbo.tblEmployee

BEGIN TRAN 
UPDATE tblEmployee SET EmployeeNumber = 122 WHERE EmployeeNumber = 123
SELECT * FROM tblEmployee WHERE EmployeeNumber = 122; 
ROLLBACK TRAN 

