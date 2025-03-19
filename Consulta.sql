USE curso; 
SELECT * FROM clientes;  


UPDATE productos SET Prod_ProvId = NULL WHERE Prod_Id = 1; 
CREATE VIEW view_productos_proveedores AS 
SELECT  Prod_Id AS id, 
		  Prod_Descripcion AS 'descripcion producto', 
		  Prod_Precio AS 'precio producto',
		  Prov_Id AS 'id proveedor',
		  Prov_Nombre AS 'nombre proveedor' 
FROM productos 
right JOIN proveedores ON Prod_ProvId = Prov_Id; 

#En el caso de no usar el "rigght join" nos va a devolver todos los valores menos los valores del producto con "id = 1" 
#ya que este no tiene ningún tipo de id de proveedor aignado. Y cuando hacemos el right join si nos va mostrar los datos 
#pero sin ningún tipo de parámetros introducidos en los campos pertenecientes a la tabla del proveedor

SELECT c.Cli_Id AS id
FROM clientes c
WHERE Cli_Id IN (SELECT sc.Cli_Id FROM clientes sc WHERE sc.Cli_RazonSocial LIKE '%Fabian%'); 

SELECT p.Prod_Id AS id, 
		 p.Prod_Descripcion AS descripcion, 
		 p.Prod_Color AS color
FROM productos p
WHERE Prod_Color  = ANY (SELECT ps.Prod_Color FROM productos ps JOIN proveedores ON Prod_ProvId = Prov_Id WHERE Prod_Id > 25); 

SELECT * from view_productos_proveedores vpp;

CALL BorroCliente('2'); 
call ActualizoProducto('2'); 

CREATE TABLE pruebaEnum(
	P_Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	P_Genero ENUM('Masculino', 'Femenino')
); 

INSERT INTO pruebaenum(P_Genero) VALUES ("masculino"); #En este caso si se encuentra dentro de las posibilidades del enum
INSERT INTO pruebaenum(P_Genero) VALUES ("tractor"); #Este caso va a dar un error SQL(1265) ya que no se encuentra dentro de las opciones del enum
SELECT * FROM pruebaenum; 

SHOW VARIABLES LIKE 'secure_file_priv'; #Comprobamos la privacidad del código 


LOAD DATA INFILE 'C:/Deskstop/generos.txt'
INTO TABLE pruebaenum
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\r\n'
(P_Id,P_Genero);  

SELECT  Prod_Id AS id,
		  Prod_Descripcion AS descr
FROM productos ; 

SELECT * 
FROM clientes 
where Cli_Id = 1 then Cli_Nombre = 'Rafa'; 


