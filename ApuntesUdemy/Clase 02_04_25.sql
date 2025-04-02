-- Clase del 02/04/2025

IF EXISTS(SELECT * FROM sys.views WHERE name = 'vista_departamentos') 
DROP VIEW vista_departamentos
go -- Para poder crear una vista antes debemos saber si esta ya existe, lo mismo en caso de que queramos borrarla 


SELECT 
		v.name, 
		s.text
FROM sys.syscomments AS s
	INNER JOIN sys.views AS v ON s.id = v.object_id
go


CREATE VIEW vista_encriptada WITH ENCRYPTION AS -- Con la función "WITH ENCRYPTION"  vamos a poder hacer inaccesible la vista
SELECT
	e.EmployeeFirstName, 
	t.Amount
FROM tblEmployee AS e
	LEFT JOIN tblTransaction AS t ON e.EmployeeNumber = t.EmployeeNumber
go

SELECT * FROM vista_encriptada -- Realmente no nos permite no ver la vista, sino que hace que no pueda ser modificada. 
go




-- Añadir una columna dentro de una vista. 

CREATE VIEW vista_original AS 
SELECT 
	e.Department, 
	e.EmployeeNumber, 
	t.DateOfTransaction,
	SUM(t.Amount) AS 'TotalAmount'
FROM tblEmployee e 
	LEFT JOIN tblDepartment d ON e.Department = d.Department
	LEFT JOIN tblTransaction t ON e.EmployeeNumber = t.EmployeeNumber
GROUP BY e.Department, e.EmployeeNumber , t.DateOfTransaction
go

BEGIN TRAN  
INSERT INTO vista_original(Department, EmployeeNumber, DateOfTransaction, TotalAmount) 
VALUES ('Customer Relations', 132, '2015-07-07', 999.99)

SELECT * FROM vista_original ORDER BY Department, EmployeeNumber

ROLLBACK TRAN
go