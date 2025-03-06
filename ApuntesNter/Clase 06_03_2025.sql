-- Clase de SQL Server del 06.03.2025 

/*
	Bibliografía: 
		
*/


-- GROUP BY, LIMIT(En SQL Recordemos que no existe y se sustituye por TOP) y OFFSET 

/*GROUP BY se puede utilizar para agregar datos dentro de subconjuntos de datos. Por ejemplo, agrupar 
por diferentes cuentas, diferentes regiones o diferentes representantes de ventas. 
Cualquier columna en la instrucción SELECT que no esté dentro de un agregador (SUM,COUNT y AVG) debe estar
en la cláusula GROUP BY. 
EL GROUP BY siempre va dentro de WHERE y ORDER BY. 

Norma muy importante!!!
LAS COLUMNAS DENTRO DE FUNCIONES DE AGREGACIÓN (SUM(), COUNT(), AVG(), etc) NO SE PONEN DENTRO DE GROUP BY.
AQUELLAS QUE NO ESTÁN DENTRO DE ESTAS FUNCIONES DE AGREGACIÓN DENBEM IR EN EL GROUP BY.

*/

SELECT 
		TOP 2 hd.DepartmentID,
		hd.GroupName as nombrecito
FROM HumanResources.Department hd 
GROUP BY hd.DepartmentID, hd.GroupName
HAVING hd.GroupName LIKE 'Research and Development'; 

/*
El OFFSET se usa para omitir un número específico de filas antes de mostrar los resultados. Se usa junto al limit 
para la paginación de datos. 
*/






-- DISTINCT 

/*
Solo se utiliza DISTINCT una vez en cada instrucción SELECT en particulas. 
*/




-- HAVING 

/*
La clave está en entender la diferencia entre WHERE y HAVING: 

	- WHERE se usa para filtrar antes de que se realicen las agregaciones 
	- HAVING se usa para filtrar después de que se haya aplicaco el GROUP BY 
Cuando usas GROUP BY, puedes seguir utilizando WHERE, pero solo para filtrar las filas 
de agruparlas. Si intentas filtrar un resultado que depende de una función de agregación
entonces necesitas HAVING. 
*/




-- CASE 

/*
CASE permite evaluar condiciones y devolver diferentes valores en una consulta. 
	- Se usa en SELECT, WHERE, ORDER BY, GROUP BY y UPDATE.
	- Su sintaxis es: 

		CASE 
			WHEN condición1 THEN resultado1 
			WHEN condición2 THEN resultado2 
			ELSE resultado_por_defecto
		END 
*/

SELECT * FROM HumanResources.Department

SELECT 
	hd.DepartmentID, 
	CASE 
		WHEN hd.Name LIKE 'Engineering' THEN 'Me cago'
		Else 'Me meo' 
	END AS categoria_salarial
FROM HumanResources.Department hd; 