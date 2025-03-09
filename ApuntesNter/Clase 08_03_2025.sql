-- Clase del 08/03/2025 

-- Seguimos los apuntes de "Apuntes SQL para análisis de datos" desde la página 27 

-- Crear una vista 
CREATE VIEW vista_de_prueba AS SELECT * FROM HumanResources.Department; 
SELECT * FROM vista_de_prueba; 



-- Subconsultas 

/*
Una subconsulta es una consulta dentro de otra consulta. Se usa cuando necesitamos obtener un dato específico
antes de ejecutar la consulta principal 

IMPORTANTE: 
		- NO USAR ALIAS. Cuando la subconsulta devuelve un solo valor. 
		- USAR IN. Si la consulta devuelve una lista de valores. 
		- USAR ALIAS. Cuando la subconsulta devuelve una tabla completa. 


Tipos de SUBCONSULTAS: 
		- Subconsulta en el SELECT. Devuelve un solo valor, se usa como si fuera un valor dentro de un SELECT 
		- Subconsulta en el FROM. Devuelve varias filas y columnas, sirve para crear una tabla intermedia que puedes
		consultar como cualquier otra tabla. 
		- Subconsulta en el WHERE. Devuelve uno o varios valores, sirve para comparar o filtrar en el WHERE. 

*Ojo con las subconsultas en los FROM que pueden ser bastante interesantes!!!.* 

*/

