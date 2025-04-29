-- Clase del 29_04_25 Parte II 

-- Subqueries 

SELECT 
		* 
FROM tblTransaction T 
	INNER JOIN tblEmployee E ON T.EmployeeNumber = E.EmployeeNumber
WHERE EmployeeLastName LIKE 'y%'
ORDER BY T.EmployeeNumber
GO  -- En esta forma de hacer esta consulta, requerimos del "INNER JOIN", pero podemos llevarlo a cabo mediante una subconsulta 


SELECT
		* 
FROM tblTransaction T 
WHERE T.EmployeeNumber IN (SELECT EmployeeNumber FROM tblEmployee WHERE EmployeeLastName LIKE 'y%') -- Esta subconsulta hace que la consulta se convierta en una dinámica 
ORDER BY T.EmployeeNumber
GO 



-- WHERE AND NOT 

SELECT 
		* 
FROM tblTransaction T 
WHERE T.EmployeeNumber NOT IN (SELECT EmployeeNumber FROM tblEmployee WHERE EmployeeLastName NOT LIKE 'y%')  
ORDER BY T.EmployeeNumber
GO 


-- Uso del "ANY" 

SELECT 
		* 
FROM tblTransaction T 
WHERE T.EmployeeNumber = ANY (SELECT EmployeeNumber FROM tblEmployee WHERE EmployeeLastName LIKE 'y%')
ORDER BY T.EmployeeNumber
GO -- "ANY" y "SOME" funcionan exactamente de la misma forma, por lo que no hay diferencia entre ellos

SELECT 
		* 
FROM tblTransaction T 
WHERE T.EmployeeNumber <> ANY -- Esto no funciona 
	(SELECT EmployeeNumber FROM tblEmployee WHERE EmployeeLastName LIKE 'y%') 
ORDER BY T.EmployeeNumber
GO 


SELECT 
		* 
FROM tblTransaction T 
WHERE T.EmployeeNumber <> ALL -- Esta es la versión correcta de lo anterior  
	(SELECT EmployeeNumber FROM tblEmployee WHERE EmployeeLastName LIKE 'y%') 
ORDER BY T.EmployeeNumber
GO 




-- Subconsultas desde "FROM" 

SELECT 
		* 
FROM tblTransaction T 
	INNER JOIN (SELECT EmployeeNumber FROM tblEmployee WHERE EmployeeLastName LIKE 'y%') E ON T.EmployeeNumber = E.EmployeeNumber
ORDER BY T.EmployeeNumber
GO -- Basicamente la subconsulta retorna un parámetro "EmployeeNumber" que lo vamos a usar para poder compararlo con la tabla principal dentro del "INNER JOIN" 
-- Por eso si usamos el alias solo nos permite usar la columna "E.EmployeeNumber"

SELECT 
		T.EmployeeNumber
FROM (SELECT EmployeeNumber FROM tblTransaction) T
GO 



-- SubConsultas en "SELECT" 

SELECT 
		*, 
		(SELECT COUNT(EmployeeNumber) FROM tblTransaction T WHERE T.EmployeeNumber = E.EmployeeNumber ) 	
FROM tblEmployee E 
WHERE E.EmployeeLastName LIKE 'y%'
GO -- El nombre de esta consulta es "correlated-query", lo cual significa que ya no podemos ejecutar por separado la subconsulta ya que ahora depende de la consulta principal 

