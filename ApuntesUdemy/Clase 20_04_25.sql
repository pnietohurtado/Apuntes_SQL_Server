-- Clase del 20.04.2025

-- Usando las funciones ISNULL y COALESED para poder identificar los valores nulos 

SELECT * FROM tblEmployee WHERE EmployeeMiddleName IS NULL; 

DECLARE @myOption AS VARCHAR(10) = 'Option B' 
SELECT ISNULL(@myOption, 'No Option') AS MyOptions -- Funciona como un operador ternario, donde en caso de que la variable sea null le vamos a dar un valor nosotros 'No Option'
GO

DECLARE @myOption AS VARCHAR(10) = NULL 
SELECT ISNULL(@myOption, 'Me cago en todo') AS MyOptions
GO 

SELECT ISNULL ('ABC', 1) AS MyAnswer 
SELECT COALESCE('ABC', 1) AS MyOtherAnswer -- Esta no va a funcionar ya que no es el dato que está buscando 
GO 


-- Pequeños paréntesis para poder añadir la tabla tblTransactionNew 
CREATE TABLE tblTransactionNew
(
	Amount SMALLMONEY NOT NULL, 
	DateOfTransaction SMALLDATETIME NOT NULL, 
	EployeeNumber INT NOT NULL 
) 
GO

SELECT * FROM tblTransaction; 

INSERT INTO tblTransactionNew VALUES (108, 2015-10-07  , 804), (200, 2014-11-15 , 864); 


-- Aprendiendo a usar MERGE 

-- Target table -> tblTransaction 
-- Source table -> tblTransactionNew 

BEGIN TRAN 
/*
ALTER TABLE tblTransaction 
ADD Comments VARCHAR(50) NULL -- Vamos a poder añadir una nueva columna de comentarios en nuestro merge table 
GO -- DDL 
*/
MERGE INTO tblTransaction AS T -- DML 
USING tblTransactionNew AS S 
ON T.EmployeeNumber = S.EployeeNumber AND 
T.DateOfTransaction = S.DateOfTransaction
WHEN MATCHED THEN 
	UPDATE SET Amount = T.Amount + S.Amount, Comments = 'MATCHED' 
WHEN NOT MATCHED BY TARGET THEN 
	INSERT (Amount, DateOfTransaction, EmployeeNumber, Comments) VALUES (S.Amount, S.DateOfTransaction, S.EployeeNumber, 'Inserted Row' )
WHEN NOT MATCHED BY SOURCE THEN 
	UPDATE SET Comments = 'Not Changed'; 
SELECT * FROM tblTransaction WHERE Comments IS NOT NULL ; 
ROLLBACK TRAN  

-- Para poder borrar las filas de la tabla SOURCE, lo único que tenemos que hacer es limitar los valores entrantes y poner un SIMPLE "DELETE" 
-- De la siguiente manera 
-- WHEN MATCHED AND T.Amount + S.Amount > 0 THEN 
--			UPDATE SET Amount = T.Amount + S.Amount
-- WHEN MATCHED THEN 
--			DELETE


SELECT * FROM tblTransaction WHERE EmployeeNumber = 109; 