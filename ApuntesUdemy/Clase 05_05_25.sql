-- Clase del 05_05_25

-- Uso de WITH 

WITH MyTable AS  -- Básicamente "WITH" sirve para crear una especie de tabla temporal sobre la que podemos trabajar
(SELECT
		D.Department, 
		EmployeeNumber, 
		EmployeeFirstName, 
		EmployeeLastName,
		rank() over(partition by D.Department order by E.EmployeeNumber) as TheRank
FROM tblDepartment D
	JOIN tblEmployee AS E ON D.Department = E.Department), 

	TransAction2014 AS 
	(SELECT * FROM tblTransaction WHERE DateOfTransaction < '2015-01-01') 

SELECT * FROM MyTable M LEFT JOIN TransAction2014 T ON M.EmployeeNumber = T.EmployeeNumber WHERE TheRank <= 5 ORDER BY M.Department, M.EmployeeNumber
GO




SELECT 
		E.EmployeeNumber
FROM tblEmployee E
	LEFT JOIN tblTransaction AS T ON E.EmployeeNumber = T.EmployeeNumber
WHERE T.EmployeeNumber IS NULL 
ORDER BY E.EmployeeNumber ASC


WITH Number AS(
SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS ROWNUMBER 
FROM tblTransaction AS U)

SELECT 
		*
FROM Number N 
	LEFT JOIN tblTransaction AS T ON N.ROWNUMBER = T.EmployeeNumber -- De esta forma si usamos el WITH como un subquery podemos usar el valor que sacamos de la misma sentencia de forma muy sencilla
WHERE T.EmployeeNumber IS NULL
GO 
	



-- PIVOT 

WITH myTable AS 
(SELECT YEAR(DateOfTransaction) AS TheYear, MONTH(DateOfTransaction) as TheMonth, Amount FROM tblTransaction) 

SELECT * FROM myTable
PIVOT (SUM(Amount) FOR TheMonth IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS myPivot -- Podemos crear tablas verticales y aquel valor que se queda fuera de ser puesto dentro del QUERY va a ser considerado la columna verical
ORDER BY TheYear
GO