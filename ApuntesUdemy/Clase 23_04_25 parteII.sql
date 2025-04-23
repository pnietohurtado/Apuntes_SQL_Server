SELECT 
	A.EmployeeNumber, 
	A.[AttendanceMonth],
	A.[NumberAttendance]
FROM tblEmployee E
	JOIN [dbo].[tblAttendance] A ON E.EmployeeNumber = A.EmployeeNumber
GO 


