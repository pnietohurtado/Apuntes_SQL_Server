-- Clase del 08_04_2025
-- UNION y UNION ALL 

SELECT CONVERT(CHAR(5), 'hi')  AS 'Nombre de la columna' -- Los nombres de las columnas deben estar indicados en la primera consulta. En la segunda no funcionarán 
UNION  -- Básicamente el "UNION" sirve para poder unir en una única sentencia dos datos distintos, pero del mismo tipo 
SELECT CONVERT(CHAR(11), 'hello there'); 


SELECT 'hi there' 
UNION  -- En este no se pueden unir ambas consultas ya que no tienen el mismo tipo de datos 
SELECT 4; 


SELECT CONVERT(CHAR(5), 'hi')  AS 'Nombre de la columna' 
UNION 
SELECT CONVERT(CHAR(11), 'hello there')
UNION 
SELECT CONVERT(CHAR(11), 'hello') 
UNION 
SELECT CONVERT(CHAR(11), 'hi') -- Sólamente me va a printar 3 columnas ya que ha detectado que una está repetida, para ello usamos UNION ALL 



SELECT CONVERT(CHAR(5), 'hi')  AS 'Nombre de la columna' 
UNION ALL
SELECT CONVERT(CHAR(11), 'hello there')
UNION ALL
SELECT CONVERT(CHAR(11), 'hello') 
UNION ALL
SELECT CONVERT(CHAR(11), 'hi') -- En este caso si que nos va a mostrar las tres salidas de las consultas que hemos realizado 





-- Intercept y Except 

SELECT * FROM tblTransaction
EXCEPT -- Me va a devolver todas las filas que sean distintas a aquellas reflejadas en la segunda consulta 
SELECT * FROM tblTransaction


BEGIN TRAN 
	DELETE	FROM tblTransaction WHERE tblTransaction.EmployeeNumber = (SELECT * FROM tblTransaction
			EXCEPT
			SELECT * FROM tblTransaction) 
	SELECT * FROM tblTransaction
ROLLBACK TRAN 

-- Uso del CASE 

DECLARE @myOption AS VARCHAR(45) = 'Option B'

SELECT
	CASE 
		WHEN @myOption = 'Option A' THEN 'First Option'
		WHEN @myOption = 'Option B' THEN 'Second Option' 
		ELSE 'No Option'
	END AS MyOptions

SELECT 
	CASE @myOption -- Segunda forma de poder crear un CASE, donde damos la variable y comprobamos los contenidos 
		WHEN 'Option A' THEN 'First Option' 
		WHEN 'Option B' THEN 'Second Option' 
		ELSE 'No Option' END AS MyOptions 


SELECT TOP 1000 
		e.DateOfBirth,
		e.Department,
		e.EmployeeFirstName, 
		e.EmployeeGovernmentID, 
		e.EmployeeLastName, 
		e.EmployeeMiddleName, 
		e.EmployeeNumber, 
		CASE 
			WHEN LEFT(e.EmployeeGovernmentID, 1) = 'A' THEN 'Letter A' 
			WHEN LEFT(e.EmployeeGovernmentID, 1) = 'B' THEN 'Letter B' 
			else 'Nothing is there' 
		END + '.png' AS 'Columna del CASE' 
FROM tblEmployee e
