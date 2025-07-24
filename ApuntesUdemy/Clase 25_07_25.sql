-- Clase de repaso del 25/07/2025 

/*
*
*	Dentro de esta clase de query, voy a probar de nuevo todos los comandos y funciones 
*	más empleados durante mis meses de estudio de SQL, para volver a ponerme en forma con 
*	el lenguaje
*
*/ 

SELECT
			* 
FROM dbo.tblAttendance
GO 

-- SELECT * FROM dbo.tblEmployee

SELECT 
	att.AttendanceMonth AS 'Mes de atención', 
	att.NumberAttendance AS 'Número de atención'
FROM dbo.tblAttendance att 
WHERE att.EmployeeNumber IN (SELECT ee.EmployeeNumber FROM dbo.tblEmployee ee) 
GO


SELECT 
	TOP 10
	att.AttendanceMonth 'Mes de atención', 
	att.NumberAttendance 'Numero de atención' 
FROM dbo.tblAttendance att 
WHERE att.EmployeeNumber IN (SELECT ee.EmployeeNumber FROM dbo.tblEmployee ee) 
ORDER BY att.EmployeeNumber DESC 



SELECT 
		TOP 10 
		MONTH(att.AttendanceMonth) AS 'Mes de atencion' 
FROM dbo.tblAttendance att 
WHERE att.EmployeeNumber IN (SELECT ee.EmployeeNumber FROM dbo.tblEmployee ee) 
ORDER BY att.EmployeeNumber DESC 



SELECT * FROM tblEmployee WHERE EmployeeFirstName LIKE 'Jane'


SELECT 
		ee.EmployeeFirstName 'Nombre', 
		ee.EmployeeLastName 'Apellido', 
		ee.EmployeeGovernmentID 'DNI' 
FROM dbo.tblEmployee ee 
WHERE ee.EmployeeFirstName LIKE 'Jan%'
GO 


SELECT 
		ee.EmployeeFirstName 'Nombre', 
		ee.EmployeeLastName 'Apellido', 
		ee.EmployeeGovernmentID 'DNI'
FROM dbo.tblEmployee ee 
WHERE ee.Department IN ('HR', 'Commercial')
GO



SELECT 
		* 
FROM dbo.tblAttendance att 
	JOIN dbo.tblEmployee ee ON att.EmployeeNumber = ee.EmployeeNumber -- Full join 
GO 
	