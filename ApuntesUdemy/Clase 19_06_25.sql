-- Clase del 19_06_25


-- set transaction isolation level read uncommited 
-- set transaction isolation level read commited 


SELECT  -- Usando "Display Estimated Execution Plan" 
		* 
FROM tblEmployee 


SELECT * FROM tblEmployee WHERE EmployeeNumber = 127 -- Debería estar usando un "Seek" en vez de un "Scan"
SELECT * FROM tblEmployee -- Este debería ser un "Scan" ya que no estamos basándonos en su "index" 
CREATE CLUSTERED INDEX idx_tblEmployee ON tblEmployee(EmployeeNumber)
DROP INDEX idx_tblEmployee ON tblEmployee -- En caso de que no haya ningún tipo de "index" va a usar un "Scan" 

ALTER TABLE tblEmployee ADD CONSTRAINT pk_EmployeeNumber PRIMARY KEY(EmployeeNumber) 
SELECT * FROM tblEmployee WHERE EmployeeNumber = 127
SELECT * FROM tblEmployee
-- Hay veces que es mejor crear solo un "index" en el caso de que LA FILA DEL PRIMARY KEY TENGA VALORES DUPLICADOS 
-- A LO LARGO DE LA TABLA POR LO QUE NO NOS DEJERÍA CREAR UN PRIMARY KEY YA QUE ESTOS DEBEN SER ÚNICOS 

