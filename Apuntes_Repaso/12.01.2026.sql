
/*En el caso de que el Amount llegue a cierta cantidad saltará un error*/
ALTER TABLE tblTransaction ADD CONSTRAINT chkAmount CHECK (Amount>-1000 AND Amount < 1000)

SELECT * FROM tblTransaction

BEGIN TRAN 
	INSERT INTO tblTransaction VALUES(100 , '2015-05-20', 1)
ROLLBACK

ALTER TABLE tblEmployee WITH NOCHECK 
ADD CONSTRAINT chkMiddleName CHECK 
(REPLACE(EmployeeMiddleName, '.', '') = EmployeeMiddleName or EmployeeMiddleName IS NULL)


BEGIN TRAN  
	INSERT INTO tblEmployee
	VALUES (2003, 'A', 'B.', 'C', 'D' , '2014-01-01', 'Accounts') 
	SELECT * from tblEmployee WHERE EmployeeNumber = 2003
ROLLBACK TRAN 