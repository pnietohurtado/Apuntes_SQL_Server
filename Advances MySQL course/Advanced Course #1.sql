-- Vamos a empezar creando distintos tipos de engine en la creación de las tablas 
-- De nuestro database 

USE prueba4; 

CREATE TABLE prueba(
	id INT NOT NULL
)ENGINE=CSV; 

CREATE TABLE prueba2(
	id INT NOT NULL PRIMARY KEY
)ENGINE=HEAP; 

SHOW TABLES; 

-- JOINS -- -------------------------------------------------------------------------------

-- Vamos a usar la tabla de "curso" para poder ver los siguientes ejemplo ya que en el video no se especifia el 
-- enlace de descarga de la base de datos empleada. 

USE curso; 

SELECT 
		v.Ventas_Id
FROM ventas v
	LEFT JOIN ventas_detalle vd ON v.Ventas_Id = vd.VD_VentasId
LIMIT 10;  



SELECT 
		v.Ventas_Id
FROM ventas v
	LEFT JOIN ventas_detalle vd ON v.Ventas_Id = vd.VD_VentasId
	RIGHT JOIN ventas_detalle vc ON v.Ventas_Id = vc.VD_VentasId; 
	

