-- Apuntes de repaso de SQL Server 

SELECT 
	T.EmployeeNumber AS NumberEmployee, 
	E.EmployeeNumber AS NumberEmployeeTbl, 
	SUM(Amount) AS SumAmount
FROM tblTransaction T
	JOIN tblEmployee AS E ON T.EmployeeNumber = E.EmployeeNumber
GROUP BY T.EmployeeNumber, E.EmployeeNumber
ORDER BY T.EmployeeNumber



-- Seguimos con el repaso de las transacciones 
BEGIN TRAN 
	UPDATE tblEmployee SET DateOfBirth = '2101-01-01'
	WHERE EmployeeNumber = 124
	SELECT 
		E.*
	FROM tblEmployee E
	WHERE E.EmployeeNumber = 124
ROLLBACK TRAN 



-- Prueba creando una nueva tabla 
CREATE TABLE notas(

	Nombre VARCHAR(45) NOT NULL, 
	Apellido VARCHAR(45) NOT NULL, 
	Nota INT NOT NULL CONSTRAINT checkNota CHECK (Nota >= 0 AND Nota <= 10) 

); 

BEGIN TRAN 
	INSERT INTO notas VALUES ('Pablo', 'Nieto Hurtado', 10); 
	SELECT 
		N.*
	FROM notas N
ROLLBACK TRAN 


-- Otra prueba con el identity 

CREATE TABLE prueba
(

	Id INT CONSTRAINT pk_Id_tblEmployee PRIMARY KEY IDENTITY(1,1), 
	Nombre VARCHAR(45), 
	Apellido VARCHAR(45) 

); 

BEGIN TRAN 
	INSERT INTO prueba(Nombre, Apellido) VALUES ('Pablo', 'Nieto Hurtado'); 
	INSERT INTO prueba(Nombre, Apellido) VALUES ('Juan', 'Julian Hurtado'); 
	INSERT INTO prueba(Nombre, Apellido) VALUES ('Ángel', 'Gómez Hurtado'); 
	INSERT INTO prueba(Nombre, Apellido) VALUES ('Pepe', 'Hurtado Hurtado'); 
	INSERT INTO prueba(Nombre, Apellido) VALUES ('Pedro', 'Díaz Hurtado'); 
	SELECT 
		P.*
	FROM prueba P 
ROLLBACK TRAN