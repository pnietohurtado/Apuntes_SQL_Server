-- Clase de Nter del 05/03/2025

/*
BIBLIOGRAFÍA DE ESTA CLASE: 
		- Uso del "ORDER BY" : 12 / 20
		- Columnas Derivadas : 29 / 39
		- Uso de "%" con LIKE , "IN" , "AND" y "BETWEEN" : 47 / 88
		- Consultas JOIN : 99 / 145
		- CROSS JOIN : 152 / 160
		- Valores NULOS (NULL) : 168 / 176
*/


USE AdventureWorks2022 
GO

-- Uso del "ORDER BY" 
SELECT  * 
FROM HumanResources.Department hd
ORDER BY hd.DepartmentID, hd.ModifiedDate DESC; 

-- Donde podemos añadir que al crear un "ORDER BY" vamos a tener el orden de "ascendente" por defecto 
-- por lo que una vez que entendemos esto podemos saber que este comando va a ordenar absolutamente todo 
-- lo que pueda, es decir, tanto los números, fechas y palabras. 








-- Columnas Derivadas (Operadores Aritméticos) 

SELECT TOP 10 * 
FROM HumanResources.Department

-- !!!!!!En el caso de "SQL Server" no existe el comando "LIMIT", por lo que la única manera de hacer un 
-- límite es usando "TOP" como he usado previamente. 

SELECT 
		(ssp.CommissionPct * ssp.SalesLastYear) AS NTP
FROM Sales.SalesPerson ssp; 






-- Uso de "%" con LIKE , "IN" , "AND" y "BETWEEN"

/*El símbolo % es un comod´´in en SQL que se utiliza para representar cero o más caracteres. 
Para que funcione correctamente, siempre debe de ir acompañado del operador LIKE*/

SELECT * 
FROM HumanResources.Employee he
WHERE he.JobTitle LIKE '%Officer%'; 

SELECT * 
FROM HumanResources.Employee he
WHERE he.JobTitle LIKE 'Engin__ring Manager'; 


SELECT * 
FROM HumanResources.Employee he 
WHERE he.JobTitle IN ('Chief Executive Officer', 'Design Engineer'); 

SELECT * 
FROM HumanResources.Employee he 
WHERE he.BusinessEntityID IN (53, 23,11); 
 
-- *********************************************************************
USE AdventureWorks2022
GO
CREATE VIEW prueba AS SELECT * FROM HumanResources.Employee; 

/*Debemos asignar primero la base de datos en la que estamos trabajando para poder ejecutar algunas 
de estas funciones especiales de nuestro programa. Pasa lo mismo con los "trigger", "procedure" y "functions" 
, este error se va a conocer como "--- should be the first thing" o algo por el estilo. */

-- *********************************************************************

SELECT * 
FROM HumanResources.Employee he
WHERE he.BusinessEntityID BETWEEN 23 AND 53;  -- NO se pueden usar los paréntesis para indicar el "AND" 

/*
BETWEEN CON LETRAS: 
	- Incluye el primer y el segundo valor en el rango
	- Funciona según el orden alfabético de las letras 
*/









-- Consultas JOIN 

/*Si tienes dos o más columnas en su SELECT que tienen el mismo nombre después del nombre de la tabla, 
como cuentas,nombre y ventas_reps.nombre, deberá asignarles un alias. De lo contrario sólo mostrará una 
de las columnas. 
Puede asignarle alias como account.name AS AcountName, sales_rep.name AS SalesRepName*/

SELECT 
		hedh.BusinessEntityID AS 'Entidad Financiera', 
		hd.GroupName AS 'Grupo Patrullero'
FROM HumanResources.EmployeeDepartmentHistory hedh 
	JOIN HumanResources.Department hd ON hedh.DepartmentID = hd.DepartmentID
WHERE hd.GroupName LIKE 'Research%'


DECLARE @id INT = 0; 

SELECT 
		DISTINCT hd.GroupName AS 'Grupo Patrullero',
		@id + 1 AS 'Entidad Financiera'
FROM HumanResources.EmployeeDepartmentHistory hedh 
	JOIN HumanResources.Department hd ON hedh.DepartmentID = hd.DepartmentID
WHERE hd.GroupName LIKE 'Research%'

/*
Imagina que trabajass en una empresa que tiene 
	- Una tabla de clientes con los clientes registrados 
	- Una tabla compras con las compras realizadas 
Sin embargo, algunos clientes aún no han comprado nada y algunas compras pueden 
haber sido realizadas por clientes que ya no están en la base de datos. 

Si haces un INNER JOIN, solo verás los clientes que han hecho compras
Si haces un LEFT JOIN, verás todos los clientes, aunque no hayan comprado nada. 
Si haces un RIGHT JOIN, verás todas las compras, aunque el cliente ya no exista en la base de datos.

Pero si haces un FULL OUTER JOIN, obtendrás una lista completa con: 
	- Los clientes con sus compras. 
	- Los clientes sin compras. 
	- Las compras sin clientes registrados. 
*/

-- *********************************************************************
/*Anotación del "SELF JOIN", donde no es como tal un comando específico ya que usamos el mismo comando
"JOIN", solo que como su propio nombre indica, vamos a llamar a una tabla con nosotros mismo, es decir, 
con la misma tabla. CON UNA CONDICIÓN, y es que estas dos tablas que unimos con el join que en esencia 
son las mismas, van a tener que llevar dos ALIAS distintos. Ya que si no puede llegar a haber cierta ambiguedad. */
-- *********************************************************************






-- CROSS JOIN 

/*El CROSS JOIN en SQL produce el producto cartesiano entre dos tablas, lo que significa que combina cada 
fila de la primera tbla con cada fila de la segunda tabla. No se necesita ninguna condición de unión, y el 
resultado es un conjunto de datos con todas las combinaciones posibles de las filas de ambas tablas. */

SELECT * 
FROM HumanResources.EmployeeDepartmentHistory he 
	CROSS JOIN HumanResources.Department;  -- Como bien se ha mencionado previamente no hace falta ningún tipo de coincidencia entre las tablas






-- Valores NULOS (NULL) 

/*Hay que tener claro que los valores NULL son diferentes a un cero: son celdas donde no existen los datos
Al identificar valores NULL en una cláusula WHERE, escribiremos IS NULL o IS NOT NULL. No usamos =, porque 
NULL no se considera un valor en SQL. En cambio es una propiedad de los datos. 

Tenga en cuenta que COUNT no tiene en cuenta las filas que tienen valores NULL, Por lo tanto, esto puede resultar 
útil para identificar rápidamente qué filas tienen datos faltantes. 
*/






-- MIN y MAX 

/*
Funcionalmente MIN y MAX son similares a COUNT en el sentido de que se pueden utilizar en columnas no numéricas.
Según el tipo de columna. MIN devolverá el número más bajo, la fecha más antigua o el valor no numérico lo más temprano 
posible en el alfabeto. Como puede sospechar, MAX hace lo contrario: devuelve el número más alto, la fecha más reciente 
o el valor no numérico más cercano alfabéticamente a "Z". 
*/








