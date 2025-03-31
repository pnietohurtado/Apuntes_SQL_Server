-- Estoy usando la base de datos "test2" 
USE test2;


SELECT 
	T.EmployeeNumber AS TEmployeeNumber, 
	E.EmployeeNumber AS EEmployeeNumber, 
	sum(Amount) AS SumAmount
FROM tblTransaction AS T
	LEFT JOIN tblEmployee E ON T.EmployeeNumber = E.EmployeeNumber 
GROUP BY T.EmployeeNumber, E.EmployeeNumber 
ORDER BY EEmployeeNumber;



-- Transacciones en SQL Server 
BEGIN TRAN 
UPDATE tblEmployee SET DateOfBirth = '2101-01-01'
WHERE EmployeeNumber = 537 
SELECT * FROM tblEmployee WHERE EmployeeNumber = 537 
ROLLBACK TRAN

-- Este tipo de dato no debería poder ser introducido dentro de nuestra tabla debido a los subrrealista que es 






-- Añadir un "Default Constraint" a nuestra tabla 

CREATE TABLE tblTransaction
(
	Amount SMALLMONEY NOT NULL, 
	DateOfTransaction SMALLDATETIME NOT NULL, 
	EmployeeNumber INT NOT NULL, 
	DateOfEntry DATETIME NULL CONSTRAINT defDateOfEntry DEFAULT GETDATE() 
); 

ALTER TABLE tblTransaction ADD DateOfEntry DATETIME  -- En esta parte añadimos una nueva columna 
ALTER TABLE tblTransaction ADD CONSTRAINT defDateOfEntry DEFAULT GETDATE() FOR DateOfEntry; -- En esta parte cambiamos el default de la columna

ALTER TABLE tblTransaction DROP CONSTRAINT defDateOfEntry; -- Primero debemos eliminar el "CONSTRAINT" para poder eliminar la columna
ALTER TABLE tblTransaction DROP COLUMN DateOfEntry; -- Ahora si podemos eliminar la columna de "DateOfEntry"

SELECT * FROM tblTransaction; 






-- "CHECK CONSTRAINTS" 

		/*Básicamente la usamos para comprobar que el valor introducido en una columna, cumple ciertos parámetros antes de ser insertado 
		en la tabla*/

CREATE TABLE notas
(
	Nombre VARCHAR(45) NOT NULL, 
	Apellido VARCHAR(45) NOT NULL, 
	Nota INT NOT NULL CONSTRAINT checkNota CHECK (Nota >= 0 AND Nota <= 10)
); 

ALTER TABLE Notas DROP CONSTRAINT checkNota;
ALTER TABLE notas ADD CONSTRAINT checkNota CHECK (Nota >= 0 AND Nota <= 10);  

INSERT INTO notas VALUES('Pablo', 'Nieto', 12); -- Este valor no se va a añadir debido a que no cumple con el "CHECK CONSTRAINT" 
SELECT * FROM notas; 

-- Ejemplo de "NO CHECK" 

		/*Debemos de tener en cuenta que el "NO CHECK" va a asignar el "CHECK" a todas aquellas filas que no tengan el "CHECK" implantado */

ALTER TABLE tblEmployee WITH NOCHECK ADD CONSTRAINT chckDateOfBirth CHECK (DateOfBirth BETWEEN '1900-01-01' AND GETDATE());
INSERT INTO tblEmployee VALUES (2003, 'A', 'B', 'C', 'D', '2026-03-31', 'Accounts'); -- Este valor no lo podríamos insertar ya que no cumple con el check
INSERT INTO tblEmployee VALUES (2003, 'A', 'B', 'C', 'D', '2025-03-31', 'Accounts');
SELECT * FROM tblEmployee;







-- PRIMARY KEYS 

		/*Es básicamente el identificador de la tabla, el cual no solamente no puede ser nulo sino que tampoco va a poder repetirse*/

CREATE TABLE prueba
(
	Id INT CONSTRAINT pk_Id_tblEmployee PRIMARY KEY IDENTITY(1,1), 
	Nombre VARCHAR(45) NOT NULL, 
	Apellido VARCHAR(45) NOT NULL 
);

INSERT INTO prueba(Nombre, Apellido) VALUES ('Pablo', 'Nieto'), ('Pepe','Hurtado'); -- No hace falta poner el "Id" ya que el programa lo pone solo con el "IDENTITY(1,1)"
SELECT * FROM prueba; 

SET IDENTITY_INSERT prueba ON  -- Con esto vamos a poder poner el valor señalado por "IDENITY(1,1)" de forma manual 
INSERT INTO prueba (Id, Nombre, Apellido) VALUES (32, 'Pablo', 'Nieto'); 


ALTER TABLE prueba DROP CONSTRAINT pk_Id_tblEmployee; 
DROP TABLE prueba; 