USE prueba; 

Delimiter $$ 
DROP TRIGGER if EXISTS dice; 
CREATE TRIGGER dice
AFTER INSERT on producto
FOR EACH ROW
	BEGIN 
		DELETE FROM proveedor WHERE Prov_Id = NEW.Prod_Id;  
	END
	$$ 
Delimiter ;

INSERT INTO producto(Prod_Nombre, Prod_IdProv) VALUES("Pepe", 2);
SELECT LAST_INSERT_ID() INTO @Prod_Id; 		#Lo que hacemos poniendo el "@" estamos generando una variable con ese nombre lo cual luego es muy útil
															#Para poder añadirlo a otra tabla
SELECT @Prod_Id; 

SHOW GRANTS FOR 'root';

INSERT INTO producto(Prod_Id,Prod_Nombre, Prod_IdProv) VALUES (1, "Manolin", 2) 
ON DUPLICATE KEY UPDATE Prod_Nombre = VALUES(Prod_Nombre), Prod_IdProv = VALUES(Prod_IdProv); 
SELECT * FROM producto WHERE Prod_Nombre LIKE 'Manolin';

INSERT INTO producto(Prod_Id, Prod_Nombre, Prod_IdProv) VALUES (1, "Santiago", 3) 
ON DUPLICATE KEY UPDATE Prod_Nombre = VALUES(Prod_Nombre), Prod_IdProv = VALUES(Prod_IdProv);
SELECT * FROM producto WHERE Prod_Id = 1;

INSERT INTO producto(Prod_Id, Prod_Nombre, Prod_IdProv) VALUES (1, "Ricardo", 3) 
ON DUPLICATE KEY UPDATE Prod_Id = 110, Prod_Nombre = VALUES(Prod_Nombre), Prod_IdProv = VALUES(Prod_IdProv); 
SELECT * FROM producto WHERE Prod_Id = 110; 

#Tabla de prueba donde vamos a añadir un parámetro que va a ser el nombre el cual tenga un "unique key";

CREATE TABLE nombre
(
	N_Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	N_Name VARCHAR(20), 
	N_Num INT, 
	UNIQUE(N_Name)
);

INSERT INTO nombre(N_Name, N_Num) VALUES ("Manolo", 2332), ("Pepe",2321); 
INSERT INTO nombre(N_Name, N_Num) VALUES("Manolo", 232)
ON DUPLICATE KEY UPDATE N_Id = LAST_INSERT_ID(N_Id), N_Num = VALUES(N_Num);
SELECT LAST_INSERT_ID(); #Se van a encontrar un error de duplicate en el caso de "Manolo" y el "last_insert_id()" nos va a mostrar 1 en vez de 2

TRUNCATE nombre; 	#El truncate es mucho mejor que la función "delete" ya que este no quema las id eliminadas es decir que el id "1" y "2" pueden seguir siendo usados
DELETE FROM nombre; #En cambio con el delete no pueden volver a usarse "1 y 2" y pasaría a usarse "3 y 4"
