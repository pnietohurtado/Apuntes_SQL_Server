-- Clase del 23.04.25

SELECT COUNT(DISTINCT EmployeeNumber) 
FROM tblTransaction
WHERE EmployeeNumber BETWEEN 3 AND 11; 
GO

CREATE PROCEDURE AverageBalance(@EmployeeNumberFrom INT, @EmployeeNumberTo INT, @AverageBalance INT OUTPUT) AS 
BEGIN 
	DECLARE @TotaLAmount MONEY 
	DECLARE @NumOfEmployee INT 

	SELECT @TotaLAmount = SUM(Amount) FROM tblTransaction
	WHERE EmployeeNumber BETWEEN @EmployeeNumberFrom AND @EmployeeNumberTo

	SELECT @NumOfEmployee = COUNT(DISTINCT EmployeeNumber) FROM tblEmployee
	WHERE EmployeeNumber BETWEEN @EmployeeNumberFrom AND @EmployeeNumberTo

	IF @NumOfEmployee = 0 
		SET @AverageBalance = 0
	ELSE 
		SET @AverageBalance = @TotaLAmount / @NumOfEmployee
END; 
GO 



DECLARE @AvegBalance INT, @ReturnStatus INT 
EXEC @ReturnStatus = AverageBalance 4, 5, @AvegBalance OUTPUT 
SELECT @AvegBalance AS Average_Balance, @ReturnStatus AS Return_Status 
GO






-- Aprendiendo a usar el "Try/Catch" 

IF EXISTS ( SELECT * FROM sys.procedures WHERE name = 'AverageBalance') 
DROP PROCEDURE AverageBalance
GO 

CREATE PROCEDURE AverageBalance(@EmployeeNumberFrom INT, @EmployeeNumberTo INT, @AverageBalance INT OUTPUT) AS 
BEGIN 
	DECLARE @TotaLAmount MONEY 
	DECLARE @NumOfEmployee INT 

	BEGIN TRY 

			SELECT @TotaLAmount = SUM(Amount) FROM tblTransaction
			WHERE EmployeeNumber BETWEEN @EmployeeNumberFrom AND @EmployeeNumberTo

			SELECT @NumOfEmployee = COUNT(DISTINCT EmployeeNumber) FROM tblEmployee
			WHERE EmployeeNumber BETWEEN @EmployeeNumberFrom AND @EmployeeNumberTo
			SET @AverageBalance = @TotaLAmount / @NumOfEmployee

			RETURN 0 -- Se pueden devolver valores en los "PROCEDURE" al igual que si estuviesemos en una función 
	END TRY
	BEGIN CATCH 
			
			SET @AverageBalance = 0
			SELECT ERROR_MESSAGE() -- De esta forma nos va a dar un mensaje de el error sin llegar a romper el programa
			RETURN 1

	END CATCH 
END; 
GO 

DECLARE @AvegBalance INT, @ReturnStatus INT  -- En este caso el "Return_Status" va a ser igual a 0 ya que no hay ningún problema 
EXEC @ReturnStatus = AverageBalance 223, 227, @AvegBalance OUTPUT 
SELECT @AvegBalance AS Average_Balance, @ReturnStatus AS Return_Status 
GO

DECLARE @AvegBalance INT, @ReturnStatus INT  -- En este caso el "Return_Status" va a ser igual a 1 ya que hay un problema con la división 
EXEC @ReturnStatus = AverageBalance 4, 5, @AvegBalance OUTPUT 
SELECT @AvegBalance AS Average_Balance, @ReturnStatus AS Return_Status 
GO

/*
	ERROR SEVERITY 
		
		~ 0 - 10 For informations (Not important) 
		~ 16 Default SQL Server log / Windows Application log 
		~ 20 - 25 Errores realmente importantes que paran por completo el programa 
*/


-- Uso del "THROW" 

IF EXISTS ( SELECT * FROM sys.procedures WHERE name = 'AverageBalance') 
DROP PROCEDURE AverageBalance
GO 

CREATE PROCEDURE AverageBalance(@EmployeeNumberFrom INT, @EmployeeNumberTo INT, @AverageBalance INT OUTPUT) AS 
BEGIN 
	DECLARE @TotaLAmount DECIMAL(5,2)  
	DECLARE @NumOfEmployee INT 

	BEGIN TRY 

			SELECT @TotaLAmount = SUM(Amount) FROM tblTransaction
			WHERE EmployeeNumber BETWEEN @EmployeeNumberFrom AND @EmployeeNumberTo

			SELECT @NumOfEmployee = COUNT(DISTINCT EmployeeNumber) FROM tblEmployee
			WHERE EmployeeNumber BETWEEN @EmployeeNumberFrom AND @EmployeeNumberTo
			SET @AverageBalance = @TotaLAmount / @NumOfEmployee

			RETURN 0 -- Se pueden devolver valores en los "PROCEDURE" al igual que si estuviesemos en una función 
	END TRY
	BEGIN CATCH 
			
			SET @AverageBalance = 0

			IF ERROR_NUMBER() = 8134 
				BEGIN 
					SET @AverageBalance = 0
					RETURN 8134
				END 
			ELSE 
				THROW 56789, 'Has cambiado el valor de alguna variable' , 1 -- 56789 Es el número de un error genérico al igual que "Exceptio" en programación

			SELECT ERROR_MESSAGE() -- De esta forma nos va a dar un mensaje de el error sin llegar a romper el programa
			RETURN 1

	END CATCH 
END; 
GO 

DECLARE @AvegBalance INT, @ReturnStatus INT  -- En este caso el "Return_Status" va a ser igual a 0 ya que no hay ningún problema 
EXEC @ReturnStatus = AverageBalance 223, 227, @AvegBalance OUTPUT 
SELECT @AvegBalance AS Average_Balance, @ReturnStatus AS Return_Status 
GO

DECLARE @AvegBalance INT, @ReturnStatus INT  -- En este caso el "Return_Status" va a ser igual a 1 ya que hay un problema con la división 
EXEC @ReturnStatus = AverageBalance 4, 5, @AvegBalance OUTPUT 
SELECT @AvegBalance AS Average_Balance, @ReturnStatus AS Return_Status 
GO






-- OVER() 
USE Udemy;

SELECT 
		A.EmployeeNumber, 
		A.AttendanceMonth, 
		A.NumberAttendance
FROM tblEmployee E 
	JOIN [dbo].[tblAttendance] A ON E.EmployeeNumber = A.EmployeeNumber 