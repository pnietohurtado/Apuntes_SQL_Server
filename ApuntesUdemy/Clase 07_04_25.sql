-- Clase del 07_04_2025

SELECT * FROM dbo.vista_departamentos; 

-- Indexes ("Seek") son más eficientes que los "Scan" los cuales consumen muchos más recursos, haciendo 
-- la consulta mucho más pesada de lo que debería

DROP VIEW dbo.vista_departamentos
GO 

CREATE VIEW vista_departamentos WITH SCHEMABINDING AS 
SELECT E.DateOfBirth, E.Department, E.EmployeeFirstName, E.EmployeeGovernmentID, E.EmployeeLastName, EmployeeMiddleName, EmployeeNumber
FROM dbo.tblEmployee E; 
GO

CREATE UNIQUE CLUSTERED INDEX index_ViewByDepartment ON dbo.vista_departamentos(EmployeeNumber, Department) ; 

BEGIN TRAN  -- No vamos poder eliminar la tabla ya que hace referencia a la vista que tenemos relacionada con los "indexes" 
DROP TABLE dbo.tblEmployee
ROLLBACK TRAN 

BEGIN TRAN  -- En cambio esta tabla si que la podemos eliminar ya que no tiene ninguna relación con los parámetros indexados
DROP TABLE dbo.notas
ROLLBACK TRAN 
GO





-- Triggers  (AFTER TRIGGER) 

CREATE TRIGGER triggerafter_prueba 
    ON dbo.tblDepartment 
    AFTER DELETE, INSERT, UPDATE
    AS
    BEGIN
		
		SET NOCOUNT ON -- Sirve para que no salga el mensaje de 5(or ...) rows Affected 

    END
GO

CREATE TRIGGER trigger_tblTransaction 
	ON dbo.tblTransaction 
	AFTER DELETE, INSERT, UPDATE 
	AS 
		BEGIN 
				SELECT * FROM inserted -- Me va mostrar todas las filas (rows) que hayamos insertado en la base de datos 
				SELECT * FROM deleted -- Me va a mostrar todas las filas (rows) que hayamos borrado en la base de datos 
		END 
	GO

BEGIN TRAN 
	INSERT INTO tblTransaction(Amount, DateOfTransaction, EmployeeNumber) VALUES 
	(123, '2015-07-10', 123) 
ROLLBACK TRAN 
GO 

BEGIN TRAN 
	DELETE FROM tblTransaction WHERE EmployeeNumber >120; 
ROLLBACK TRAN 
GO 




-- TRIGGERS (INSTEAD OF) 

CREATE TRIGGER NameOfTrigger 
	ON dbo.vista_departamentos
	INSTEAD OF DELETE -- Sólamente puedes elegir una de las tres opciones  
	AS 
		BEGIN 
			
			SELECT *, 'vista_departamentos' FROM deleted

		END 
GO

BEGIN TRAN 
	SELECT * FROM vista_departamentos  vd WHERE vd.EmployeeNumber = 132 
	DELETE FROM vista_departamentos
	WHERE EmployeeNumber = 132 
	SELECT * FROM vista_departamentos WHERE EmployeeNumber = 132 
ROLLBACK TRAN 



