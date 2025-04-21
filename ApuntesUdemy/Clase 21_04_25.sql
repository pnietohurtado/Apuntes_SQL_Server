-- Clase del 21/04/25

CREATE VIEW VW_Employee AS 
SELECT 
		e.EmployeeNumber,
		e.EmployeeFirstName,
		e.EmployeeLastName
FROM tblEmployee e
GO

CREATE PROC NameEmployees AS 
BEGIN 
	SELECT 
			e.EmployeeNumber, 
			e.EmployeeFirstName, 
			e.EmployeeLastName
	FROM tblEmployee e
END 
GO  -- Marks the end of a batch 

EXEC sp_rename 'tblEmployee.EmployeeLastName', 'EmployeeLastNames', 'COLUMN'; -- Para poder cambiar el nombre de una columna una vez creada la tabla 

EXECUTE NameEmployees -- En el caso de los "PROCEDURE", cuando alguna columna es cambiada de nombre, esta función sigue funcionando igual 
EXEC NameEmployees



-- Procedimientos con parámetros a introducir

IF EXISTS(SELECT  * FROM sys.procedures WHERE name = 'NameEmployees') DROP PROC NameEmployees 
GO

CREATE PROC NameEmployees(@EmployeeNumber INT) AS 
BEGIN 
	IF exists (SELECT * FROM tblEmployee WHERE EmployeeNumber = @EmployeeNumber) 
	BEGIN 
		SELECT * FROM tblEmployee WHERE tblEmployee.EmployeeNumber = @EmployeeNumber; 	
	END 
	IF NOT EXISTS (SELECT * FROM tblEmployee WHERE EmployeeNumber = @EmployeeNumber) 
		SELECT 'Ese número no existe'
END 
GO

DECLARE @EmployeeNumber INT = 123
EXECUTE NameEmployees @EmployeeNumber; -- No hay que poner el parámetro entre paréntesis como en MySQLWorkBench


-- Ejercicio de IF 
IF EXISTS(SELECT  * FROM sys.procedures WHERE name = 'NameEmployees') DROP PROC NameEmployees 
GO

CREATE PROC NameEmployees(@EmployeeNumber INT) AS 
BEGIN 
	IF exists (SELECT * FROM tblEmployee WHERE EmployeeNumber = @EmployeeNumber) 
	BEGIN 
		IF @EmployeeNumber < 300 
		BEGIN 
			SELECT EmployeeNumber, EmployeeFirstName, EmployeeLastName FROM tblEmployee WHERE tblEmployee.EmployeeNumber = @EmployeeNumber; 	
		END 
		ELSE 
		BEGIN 
			SELECT EmployeeNumber, EmployeeFirstName, EmployeeLastName, Department FROM tblEmployee WHERE tblEmployee.EmployeeNumber = @EmployeeNumber; 	
			SELECT * FROM tblTransaction WHERE EmployeeNumber = @EmployeeNumber
		END 
	END 
END 
GO

EXEC NameEmployees 300; 
GO


-- Multiple parámetros dentro de un "PROCEDURE" 
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'NameEmployees2') 
DROP PROCEDURE NameEmployees2 
GO

CREATE PROCEDURE NameEmployees2 (@EmployeeNumber INT, @EmployeeNumberTo INT) AS 
BEGIN 
	IF EXISTS (SELECT * FROM tblEmployee WHERE EmployeeNumber BETWEEN @EmployeeNumber AND @EmployeeNumberTo) 
	BEGIN
		SELECT EmployeeNumber, EmployeeFirstName, EmployeeLastName FROM tblEmployee WHERE EmployeeNumber BETWEEN @EmployeeNumber AND @EmployeeNumberTo
	END 
END 
GO

EXEC NameEmployees2 123, 124; 
EXEC NameEmployees2 @EmployeeNumber = 123, @EmployeeNumberTo = 124; 




-- Uso del WHILE 

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'NameEmployees2') 
DROP PROCEDURE NameEmployees2 
GO

CREATE PROCEDURE NameEmployees2 (@EmployeeNumber INT, @EmployeeNumberTwo INT) AS 
BEGIN 
	IF EXISTS(SELECT * FROM tblEmployee WHERE EmployeeNumber BETWEEN @EmployeeNumber AND @EmployeeNumberTwo) 
	BEGIN 
		

		WHILE @EmployeeNumber <=  @EmployeeNumberTwo 
		BEGIN
			SELECT EmployeeNumber, EmployeeFirstName, EmployeeLastName FROM tblEmployee WHERE EmployeeNumber = @EmployeeNumber
			SET @EmployeeNumber = @EmployeeNumber + 1
			-- BREAK 
			-- CONTINUE
		END
	END 
	
END 
GO

SELECT * FROM tblEmployee WHERE EmployeeNumber = 121; 
EXECUTE NameEmployees2 1, 126; 