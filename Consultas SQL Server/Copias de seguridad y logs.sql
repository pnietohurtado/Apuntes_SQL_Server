BACKUP DATABASE CompanyMedac TO DISK = 'G:\Copias de Seguridad SQL\CompanyMedac.bak' WITH CHECKSUM ; 
-- Ponemos WITH CHECKSUM ya que de esta forma nos aseguramos la integridad de los datos 


RESTORE DATABASE Curso FROM DISK = 'G:\Copias de Seguridad SQL\CompanyMedac.bak'; 
-- En el caso de que el basckup no tuviera checksum, no vamos a poder hacer 
-- la restauración de las base de datos. 

USE test2; 
DROP DATABASE test;  
-- Para poder hacer eliminar la base de datos nos debemos poder asegurar 
-- De que el SQL Server tenga otra base de datos en la que quedarse después 
-- De que esta sea eliminada . 


CREATE LOGIN pablo_prueba WITH PASSWORD = '123'; 
CREATE USER pnh FOR LOGIN pablo_prueba; 
ALTER ROLE db_datareader ADD MEMBER pnh; 

USE Curso; 
-- Debemos tener muy en cuenta que cuando creamos las cosas sea el sitio donde las 
-- queremos crear. Si queremos un usuario que pueda usar la base de datos de Curso ,
-- debemos crear el usuario dentro de esa base de datos. 

CREATE LOGIN juan WITH PASSWORD = '123'; 
CREATE USER pnh2 FOR LOGIN juan; 
ALTER ROLE db_datareader ADD MEMBER pnh2; 

GRANT INSERT ON DEPARTMENT TO pnh2 WITH GRANT OPTION; 