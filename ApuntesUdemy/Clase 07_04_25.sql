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
	-- SELECT * FROM vista_departamentos  vd WHERE vd.EmployeeNumber = 132 
	DELETE FROM vista_departamentos
	WHERE EmployeeNumber = 132 
	-- SELECT * FROM vista_departamentos WHERE EmployeeNumber = 132 
ROLLBACK TRAN 
GO



-- TRIGGERS (NESTED TRIGGERS) 
DROP TRIGGER NameTrigger
GO

ALTER TRIGGER NameTrigger 
	ON tblTransaction 
	AFTER DELETE, INSERT, UPDATE 
	AS 
	BEGIN 
		IF  @@NESTLEVEL = 1  -- En el caso de que el NEST LEVEL sea igual a 1 veremos los dos SELECT 
		BEGIN 
			SELECT *, 'Inserted - tblTransaction' FROM inserted
			SELECT *, 'Deleted - tblTransaction' FROM deleted
		END 
	END 
GO 


BEGIN TRAN 
	INSERT INTO tblTransaction(Amount, DateOfTransaction, EmployeeNumber) VALUES 
	(123, '2015-07-10', 123), (132, '2015-07-10', 132) 
ROLLBACK TRAN
GO


ALTER TRIGGER row_count 
	ON dbo.tblTransaction 
	AFTER DELETE, INSERT, UPDATE 
	AS 
	BEGIN 
		-- SET NOCOUNT ON -- Para que no aparezca cuantas filas han sido afectadas 
		BEGIN 
			IF @@ROWCOUNT > 0 -- Si se añaden cierta cantidad de filas, vamos a desencadenar una acción de lo contrario no dirá nada 
			BEGIN 
				SELECT *, 'Inserted - tblTransaction' AS tabla_transacciones FROM inserted
				SELECT *, 'Deleted - tblTransaction' AS tabla_transacciones FROM deleted
			END 
		END
	END 
GO

BEGIN TRAN 
	INSERT INTO tblTransaction(Amount, DateOfTransaction, EmployeeNumber) VALUES 
	(123, '2015-07-10', 123)
ROLLBACK TRAN 
GO

BEGIN TRAN -- Cuando hacemos un UPDATE, vamos a obtener tanto el mensaje de insertar como el de eliminar, donde vamos a poder ver el parámetro cambiado y el parámetro nuevo
	UPDATE tblTransaction SET DateOfTransaction = '2015-07-12' WHERE DateOfTransaction = '2015-07-11' AND Amount = -770.86
ROLLBACK TRAN 
GO

ALTER TRIGGER row_count 
	ON tblTransaction 
	AFTER DELETE, INSERT, UPDATE 
	AS 
	BEGIN 
		BEGIN 
			-- IF UPDATE(DateOfTransaction) 
			IF COLUMNS_UPDATED() & 2 = 2 -- Básicamente nos va a mostrar las filas actualizadas las cuales sean iguales a 2 ( Es decir, que se trate de la fila 2 de la tabla ) 
			BEGIN 
				SELECT *, 'Inserted - tblTransaction' AS tabla_transacciones FROM inserted
				SELECT *, 'Deleted - tblTransaction' AS tabla_transacciones FROM deleted
			END 
		END 
	END 
GO

BEGIN TRAN -- Cuando hacemos un UPDATE, vamos a obtener tanto el mensaje de insertar como el de eliminar, donde vamos a poder ver el parámetro cambiado y el parámetro nuevo
	UPDATE tblTransaction SET DateOfTransaction = '2015-07-12' WHERE DateOfTransaction = '2015-07-11' AND Amount = -770.86
ROLLBACK TRAN 
GO