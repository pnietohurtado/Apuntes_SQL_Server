-- Clase de Udemy del 01-04-2025

-- Foreign Key 

		/*El "FOREING KEY" se usa para referenciar un "PRIMARY KEY" con otra tabla, lo cual es conocido como "seeking" */


ALTER TABLE tblEmployee WITH NOCHECK ADD CONSTRAINT pk_EmployeeNumber PRIMARY KEY (EmployeeNumber) 

BEGIN TRAN 
ALTER TABLE tblTransaction ALTER COLUMN EmployeeNumber INT NULL
ALTER TABLE tblTransaction ADD CONSTRAINT df_tblTransaction DEFAULT 124 FOR EmployeeNumber 
ALTER TABLE tblTransaction WITH NOCHECK ADD CONSTRAINT fk_tblTransaction_EmployeeNumber FOREIGN KEY (EmployeeNumber) REFERENCES tblEmployee(EmployeeNumber)
ON UPDATE CASCADE -- ON UPDATE SET NULL / DEFAULT
ON DELETE CASCADE -- ON DELETE SET NULL / DEFAULT 
go





-- Crear Vistas 

CREATE VIEW vista_departamentos AS
SELECT 
		d.Department,
		t.EmployeeNumber, 
		t.DateOfTransaction, 
		t.Amount AS TotalAmount 
FROM tblDepartment d
	LEFT JOIN tblEmployee e ON d.Department = e.Department
	LEFT JOIN tblTransaction t ON e.EmployeeNumber = t.EmployeeNumber
WHERE t.EmployeeNumber BETWEEN 120 AND 139 
go
-- ORDER BY d.Department, t.EmployeeNumber ASC (LA CLAUSULA "ORDER BY" NO PUEDE SER IMPLEMENTADA EN LAS VISTAS) 


CREATE VIEW vista_sumaCantidad AS 
SELECT 
		d.Department, 
		t.EmployeeNumber AS 'EmpNum', 
		SUM(t.Amount) AS TotalAmount 
FROM tblDepartment d
	LEFT JOIN tblEmployee e ON d.Department = e.Department
	LEFT JOIN tblTransaction t ON e.EmployeeNumber = t.EmployeeNumber
GROUP BY d.Department, t.EmployeeNumber -- Se tienen que agrupar todos los elementos que este fuera de las funciones!!!!!
go -- Sirve para solucionar el error de "MUST BE THE ONLY ELEMENT IN THE BATCH" 
-- ORDER BY d.Department, t.EmployeeNumber ASC  (LA CLAUSULA "ORDER BY" NO PUEDE SER IMPLEMENTADA EN LAS VISTAS) 


DROP VIEW vista_sumaCantidad
go

ALTER VIEW vista_departamentos AS  -- De esta forma podemos cambiar la vista con el select que nosotros queramos. 
SELECT * FROM tblEmployee
go


SELECT * FROM sys.views -- De esta forma vamos a poder ver si la vista existe o no ya que nos muestra todas las vistas creadas

