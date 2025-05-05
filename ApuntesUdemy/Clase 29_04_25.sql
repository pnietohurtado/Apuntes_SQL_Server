-- Clase del 29.04.2025

-- Use of partition 

SELECT 
		A.EmployeeNumber, 
		A.AttendanceMonth, 
		A.NumberAttendance,
		SUM(A.NumberAttendance) OVER(PARTITION BY A.EmployeeNumber ORDER BY A.AttendanceMonth) AS TotalAttendance -- Coge para cada fila los datos de la columna asignada 
		, CONVERT(DECIMAL(18,7), A.NumberAttendance) / SUM(A.NumberAttendance) OVER(PARTITION BY A.EmployeeNumber ORDER BY A.AttendanceMonth) * 100.0000 AS PorcentajeAsistencia
FROM tblEmployee E 
	JOIN tblAttendance A ON E.EmployeeNumber = A.EmployeeNumber
WHERE A.AttendanceMonth < '20150101'
GO -- De esta forma la última columna de la consulta nos va a informar de el porcentaje de asistencia de cada uno de los empleado 
-- gracias a el uso de "PARTITION BY A.EmployeeNumber" lo cual nos revisa el porcentaje de falta para cada número de empleado . 


-- De forma que si introducimos los "ORDER BY" dentro de los "PARTITION BY" vamos a conseguir los porcentajes de asistencia de todos los empleados 
-- de forma incrementada según avanza el mes .


CREATE VIEW vista_particiones AS 
SELECT 
		A.EmployeeNumber, 
		A.AttendanceMonth, 
		A.NumberAttendance,
		SUM(A.NumberAttendance) OVER(PARTITION BY A.EmployeeNumber ORDER BY A.AttendanceMonth) AS TotalAttendance -- Coge para cada fila los datos de la columna asignada 
		, CONVERT(DECIMAL(18,7), A.NumberAttendance) / SUM(A.NumberAttendance) OVER(PARTITION BY A.EmployeeNumber ORDER BY A.AttendanceMonth) * 100.0000 AS PorcentajeAsistencia
FROM tblEmployee E 
	JOIN tblAttendance A ON E.EmployeeNumber = A.EmployeeNumber
WHERE A.AttendanceMonth < '20150101'
GO

SELECT * FROM vista_particiones WHERE PorcentajeAsistencia = 100.0000; -- Sólamente hay 77 empleados con un 100% de asistencia en distintos meses




-- Ranking Functions

SELECT 
		A.EmployeeNumber, 
		A.AttendanceMonth, 
		A.NumberAttendance, 
		ROW_NUMBER() OVER(PARTITION BY A.EmployeeNumber ORDER BY A.EmployeeNumber, A.AttendanceMonth) AS TheRowNumber
FROM tblEmployee AS E 
	JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber
GO 




