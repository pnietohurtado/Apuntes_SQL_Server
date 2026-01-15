
-- Primary Key 

CREATE TABLE TblEmployee3(
	EmployeeNumber INT CONSTRAINT PK_tblEmployee2 PRIMARY KEY IDENTITY(1,1), 
	EmployeeName NVARCHAR(20) 
)

INSERT INTO TblEmployee3 VALUES ('Pablo Nieto')

SELECT * FROM TblEmployee3

DELETE FROM TblEmployee3

TRUNCATE table TblEmployee3

INSERT INTO TblEmployee3(EmployeeNumber, EmployeeName) 
VALUES (3, 'Name') , (4, 'Pepe')

SET IDENTITY_INSERT TblEmployee3 ON 


INSERT INTO TblEmployee3(EmployeeNumber, EmployeeName) 
VALUES (33, 'Name') , (43, 'Pepe')

SELECT @@IDENTITY
SELECT SCOPE_IDENTITY()

SELECT IDENT_CURRENT('dbo.TblEmployee3')



ALTER TABLE tblTransaction WITH NOCHECK 
ADD CONSTRAINT FK_tblTransaction_EmployeeNumber FOREIGN KEY (EmployeeNumber) 
REFERENCES tblEmployee(EmployeeNumber) 

BEGIN TRAN 

ALTER TABLE tblTransaction ALTER COLUMn EmployeeNumber INT NULL 
ALTER TABLE tblTransaction ADD CONSTRAINT DF_tblTransaction DEFAULT 124 FOR EmployeeNumber 
ALTER TABLE tblTransaction WITH NOCHECK 
ADD CONSTRAINT FK_tblTransaction_EmployeeNumber FOREIGN KEY (EmployeeNumber) 
REFERENCES tblEmployee(EmployeeNumber) 

 UPDATE tblEmployee SET EmployeeNumber = 9123 WHERE EmployeeNumber = 123
 DELETE tblEmployee WHERE EmployeeNumber = 123

SELECT 
	E.EmployeeNumber, 
	T.* 
FROM tblEmployee AS E
	RIGHT JOIN tblTransaction AS T ON E.EmployeeNumber = T.EmployeeNumber
WHERE T.Amount IN (-179.47, 786.22, -967.36, 957.03) 

ROLLBACK TRAN 