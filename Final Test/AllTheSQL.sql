-- Summary of the sql udemy course 

USE [Udemy] -- We have to execute this first because is where all the data is stored

-- Bibliografía 

	-- #1. "ALTER" command inside the tblEmployee 
	-- #2. "INSERT" command inside tblEmployee 
	-- #3. Simple "SELECT" queries (ONLY 'SELECT' queries) 
		-- #3.1. Where practice 
		-- #3.2. More complex "SELECT" queries 
		-- #3.3. "SELECT" interest functions (for functionallity) 
		-- #3.4 Use of "HAVING" command 
		-- #3.5 Use of the "JOIN" in "SELECT" queries
	-- #4. Transactions
		-- #4.1 "ROLLBACK TRAN" for a "DELETE" query
		-- #4.2 "ROLLBACK TRAN" for a "UPDATE" query 
	-- #5. Security 
	-- #6. Indexes
		-- #6.1 Creating an indexed view 
	-- #@. Exercises (With levels of difficulty '*****') 
	-- #~. Random but usefull commands 



CREATE TABLE tblEmployee(

	EmployeeNumber INT NOT NULL, 
	EmployeeFirstName VARCHAR(50) NOT NULL, 
	EmployeeMiddleName VARCHAR(50) NULL, 
	EmployeeLastName VARCHAR(50) NOT NULL, 
	EmployeeGovernmentID CHAR(10) NOT NULL, -- It will be exactly the same if we speak about the DNI
	DateOfBirth DATE NOT NULL

);

CREATE TABLE tblTransaction(

	Amount SMALLMONEY NOT NULL, 
	DateOfTransaction SMALLDATETIME NULL, 
	EmployeeNumber INT NOT  NULL 

); 




-- Alter key factors 

-- #1. "ALTER" command inside the tblEmployee 

	ALTER TABLE tblEmployee 
	ADD Department VARCHAR(50) NOT NULL 
	GO 

	ALTER TABLE tblEmployee
	ALTER COLUMN Department VARCHAR(20)
	GO 

	ALTER TABLE tblEmployee 
	ADD CONSTRAINT unqGovermentID UNIQUE (EmployeeGovernmentID) 


-- Insert key factors  

-- #2. "INSERT" command inside tblEmployee 

INSERT INTO tblEmployee VALUES (132, 'Dylan' , 'A', 'Word', 'HN513777D', '1992-01-12', 'Customer Relations')
GO 

INSERT INTO tblEmployee(EmployeeNumber, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeGovernmentID, DateOfBirth, Department)
VALUES (132, 'Dylan' , 'A', 'Word', 'HN513777D', '1992-01-12', 'Customer Relations')
GO 


-- Select key factors 

-- #3. Simple "SELECT" queries 

	SELECT  -- tblEmployee
		E.* 
	FROM tblEmployee E 

	SELECT  -- tblTransaction 
		T.* 
	FROM tblTransaction T 

	SELECT -- tblDepartment 
		D.* 
	FROM tblDepartment D 

	-- #3.1 Where practice 

		SELECT  -- Just a simple "WHERE" query 
			E.* 
		FROM tblEmployee E 
		WHERE E.EmployeeLastName = 'Word'


		SELECT  -- Just a simple "WHERE" query 
			E.* 
		FROM tblEmployee E 
		WHERE E.EmployeeLastName <> 'Word' -- Bring everything but the one matching this condition 


		SELECT  -- Using the "LIKE" key word and the all-rounder key "%" 
			E.*
		FROM tblEmployee E 
		WHERE E.EmployeeLastName LIKE 'W%' 

		SELECT  -- Using the "LIKE" key word and the all-rounder key "%" 
			E.*
		FROM tblEmployee E 
		WHERE E.EmployeeFirstName LIKE '_y%' -- Brings everything with a "y" in the second position 

		SELECT 
			E.* 
		FROM tblEmployee E 
		WHERE NOT E.EmployeeNumber > 200 -- NOT the one that fulfill the condition control 

		SELECT 
			E.* 
		FROM tblEmployee E 
		WHERE NOT (EmployeeNumber >= 200 AND EmployeeNumber <= 209) -- Using the "AND" logical operator 

		SELECT 
			E.* 
		FROM tblEmployee E 
		WHERE E.EmployeeNumber IN (200, 204, 208) 

	-- #3.2 More complex "SELECT" queries 

		SELECT -- Simple year selection query 
			YEAR(E.DateOfBirth),  
			COUNT(*) AS Number -- Counting 
		FROM tblEmployee E 
		GROUP BY YEAR(E.DateOfBirth) -- Just add every "SELECT" column that is NOT a ADDING FUNCTION 

		
		SELECT -- Simple year selection query 
			YEAR(E.DateOfBirth),  
			COUNT(*) AS Number -- Counting 
		FROM tblEmployee E 
		GROUP BY YEAR(E.DateOfBirth) -- Just add every "SELECT" column that is NOT a ADDING FUNCTION 
		ORDER BY YEAR(E.DateOfBirth) ASC -- By default it orders the result in an ascending order 


	-- #3.3 "SELECT" interest functions (for functionallity) 

		SELECT 
			LEFT(E.EmployeeNumber, 1) AS Initial, -- To only get the initial 
			COUNT(*) AS CountOfInitial
		FROM tblEmployee E
		GROUP BY LEFT(E.EmployeeLastName, 1) 
		ORDER BY LEFT(E.EmployeeLastName, 1) 

		
		SELECT 
			TOP(5) -- Return the first five results 
			LEFT(EmployeeNumber, 1) AS Initial, -- To only get the initial 
			COUNT(*) AS CountOfInitial
		FROM tblEmployee 
		GROUP BY LEFT(EmployeeLastName, 1) 
		ORDER BY LEFT(EmployeeLastName, 1) 

	-- #3.4 Use of "HAVING" command 

		SELECT 
			LEFT(E.EmployeeLastName, 1) AS Initial, 
			COUNT(*) AS CountOfInitial
		FROM tblEmployee E 
		GROUP BY LEFT(E.EmployeeLastName, 1) 
		HAVING COUNT(*) >= 50 -- It can act in later execution than the "SELECT" command 
		ORDER BY COUNT(*) DESC 

	-- #3.5 Use of the "JOIN" in "SELECT" queries
		SELECT 
			E.EmployeeFirstName AS First_Name, 
			E.EmployeeLastName AS Last_Name, 
			SUM(T.Amount) AS Transaction_Amount
		FROM tblEmployee E
			JOIN tblTransaction T ON E.EmployeeNumber = T.EmployeeNumber
		GROUP BY E.EmployeeFirstName, E.EmployeeLastName
		ORDER BY SUM(T.Amount) DESC 
		

		SELECT 
			E.EmployeeFirstName AS First_Name, 
			E.EmployeeLastName AS Last_Name, 
			SUM(T.Amount) AS Transaction_Amount
		FROM tblEmployee E
			JOIN tblTransaction T ON E.EmployeeNumber = T.EmployeeNumber
		WHERE E.EmployeeNumber = 1046
		GROUP BY E.EmployeeFirstName, E.EmployeeLastName
		ORDER BY SUM(T.Amount) DESC 


		SELECT 
			E.EmployeeFirstName AS First_Name, 
			E.EmployeeLastName AS Last_Name, 
			SUM(T.Amount) AS Transaction_Amount
		FROM tblEmployee E
			LEFT JOIN tblTransaction T ON E.EmployeeNumber = T.EmployeeNumber -- Theres an employee with the EmployeeNumber 1046 but haven't made a 
		WHERE E.EmployeeNumber = 1046 -- transaction yet
		GROUP BY E.EmployeeFirstName, E.EmployeeLastName
		ORDER BY SUM(T.Amount) DESC 


		SELECT 
			E.EmployeeFirstName AS First_Name, 
			E.EmployeeLastName AS Last_Name, 
			D.Department AS Department, 
			SUM(T.Amount) AS Amount 
		FROM tblDepartment D 
			LEFT JOIN tblEmployee E ON D.Department = E.Department
			LEFT JOIN tblTransaction T ON E.EmployeeNumber = T.EmployeeNumber
		WHERE T.EmployeeNumber IS NULL 
		GROUP BY E.EmployeeFirstName, E.EmployeeLastName, D.Department


		SELECT 
			SY.text AS CODE
		FROM sys.syscomments SY
			JOIN sys.views SS ON SY.id = SS.object_id
			


	-- #3.6 Using the "SUB-SELECT" 
		SELECT 
			D.Department 
		FROM (SELECT Department, COUNT(*) AS NumberOfDepartment FROM tblEmployee GROUP BY Department) D 

		SELECT 
			* 
		FROM(
		SELECT 
			E.EmployeeFirstName AS First_Name, 
			E.EmployeeLastName AS Last_Name, 
			D.Department AS Department, 
			T.EmployeeNumber AS TNumber,
			SUM(T.Amount) AS Amount 
		FROM tblDepartment D 
			LEFT JOIN tblEmployee E ON D.Department = E.Department
			LEFT JOIN tblTransaction T ON E.EmployeeNumber = T.EmployeeNumber
		GROUP BY E.EmployeeFirstName, E.EmployeeLastName, D.Department, T.EmployeeNumber) 
		AS newTable
		WHERE TNumber IS NULL 
		ORDER BY Amount 




-- #4. Transactions

	-- #4.1 "ROLLBACK TRAN" for a "DELETE" query

		BEGIN TRAN 
			
			SELECT COUNT(*) FROM tblTransaction

			DELETE 
				tblTransaction
			FROM tblEmployee E 
				RIGHT JOIN tblTransaction T ON E.EmployeeNumber = T.EmployeeNumber
			WHERE E.EmployeeNumber IS NULL 

			SELECT COUNT(*) FROM tblTransaction

		ROLLBACK TRAN 

	-- #4.2 "ROLLBACK TRAN" for a "UPDATE" query 

		BEGIN TRAN 
			
			SELECT * FROM tblTransaction WHERE EmployeeNumber = 194

			UPDATE tblTransaction
			SET EmployeeNumber = 194 
			OUTPUT inserted.* 
			-- FROM tblTransaction
			WHERE EmployeeNumber = 3 

			SELECT * FROM tblTransaction WHERE EmployeeNumber = 194

		ROLLBACK TRAN 
		GO

-- #5. Security 



-- #6. Indexes

		-- #6.1 Creating an indexed view 

			DROP VIEW ViewByDepartment2
			GO

			CREATE view ViewByDepartment2 WITH SCHEMABINDING AS 
			SELECT 
				D.Department, 
				T.EmployeeNumber, 
				T.DateOfTransaction, 
				T.Amount AS TotalAmount 
			FROM dbo.tblDepartment as D -- Adding dbo. is like adding a schema of the database just for the index 
				INNER JOIN dbo.tblEmployee AS E ON D.Department = E.Department
				INNER JOIN dbo.tblTransaction AS T ON E.EmployeeNumber = T.EmployeeNumber
			WHERE T.EmployeeNumber BETWEEN 120 AND 139
			GO

			CREATE UNIQUE CLUSTERED INDEX indx_ViewByDepartment on dbo.ViewByDepartment2(EmployeeNumber, Department, DateOfTransaction, TotalAmount)  -- It gives a duplicates key
			-- when adding only the department and the employeeNumber because they are duplicated values compare to the date and the totalAmount that's why we have to add that data too 
			-- in the index 


-- #7. Triggers 

	



-- #@. Exercises 

	-- #@1. (*)
		SELECT 
			MONTH(E.DateOfBirth) AS Mes, -- If you want the name you can use "DATENAME(MONTH, COLUMN)" 
			COUNT(*) 
		FROM tblEmployee E 
		GROUP BY MONTH(E.DateOfBirth)
		ORDER BY MONTH(E.DateOfBirth) ASC 

	-- #@2. (*) 
		SELECT 
			E.EmployeeMiddleName AS MiddleName, 
			COUNT(E.EmployeeMiddleName) AS Cuantity
		FROM tblEmployee E 
		GROUP BY E.EmployeeMiddleName

	-- #@3. 
		BEGIN TRAN 
			SELECT
				E.EmployeeNumber AS NumberOfEmployee, 
				T.DateOfEntry AS DateEntry, 
				E.EmployeeFirstName AS FirstName, 
				E.EmployeeLastName AS LastName 
			FROM tblEmployee E 
				JOIN tblTransaction T ON E.EmployeeNumber = T.EmployeeNumber

		ROLLBACK TRAN


		SELECT 
			E.EmployeeFirstName AS FirstName, 
			E.EmployeeLastName AS LastName, 
			D.DepartmentHead AS Head,
			SUM(T.Amount) AS Total

		FROM tblEmployee E 
			JOIN tblTransaction T ON E.EmployeeNumber = T.EmployeeNumber
			JOIN tblDepartment D ON E.Department = D.Department
			JOIN tblAttendance A ON E.EmployeeNumber = A.EmployeeNumber
		WHERE E.EmployeeNumber > 150
		GROUP BY E.EmployeeFirstName, E.EmployeeLastName, D.DepartmentHead
		


-- #~. Random but usefull commands 

	-- # Use of the "GETDATE()" 

		BEGIN TRAN 
			
			ALTER TABLE tblTransaction ADD DateOfEntry DATETIME NULL 
			
			ALTER TABLE tblTransaction ADD CONSTRAINT defDateOfEntry DEFAULT GETDATE() for DateOfEntry 

			INSERT INTO tblTransaction(Amount, EmployeeNumber) VALUES (105.33, 400) 

			SELECT 
				T.* 
			FROM tblTransaction T 
			WHERE T.DateOfEntry IS NOT NULL 

		ROLLBACK TRAN 

	-- # Use of the "CHECK" command 

		ALTER TABLE tblTransaction 
		ADD CONSTRAINT chckAmount2 CHECK (Amount > -1000 AND Amount < 1000) 

		INSERT INTO tblTransaction(Amount, EmployeeNumber)  VALUES (1000, 402) 

	-- # Adding a "PRIMARY KEY" for a table 

		ALTER TABLE tblEmployee 
		ADD CONSTRAINT PK_EmployeeNumber PRIMARY KEY (EmployeeNumber) 
		GO

	-- # Creation of "VIEW" 
		
		CREATE VIEW ViewByDepartment AS 
			SELECT
				E.EmployeeNumber AS NumberOfEmployee,
				E.EmployeeFirstName AS FirstName, 
				E.EmployeeLastName As LastName, 
				E.Department AS Department, 
				D.DepartmentHead AS HeadOfDepartment, 
				SUM(T.Amount) AS Total 
			FROM tblDepartment D
				LEFT JOIN tblEmployee E ON D.Department = E.Department
				LEFT JOIN tblTransaction T ON E.EmployeeNumber = T.EmployeeNumber
			WHERE E.EmployeeNumber > 10
			GROUP BY E.EmployeeFirstName, E.EmployeeLastName, E.Department, D.DepartmentHead, E.EmployeeNumber
			-- ORDER BY E.EmployeeNumber -- Cannot use the order by in de VIEW queries, such as in the sub-select ones 
		GO

		SELECT * FROM ViewByDepartment -- The propper form to call a view 
		GO 

		-- Altering and Dropping a VIEW 

			ALTER VIEW ViewByDepartment AS  -- ALTER 
				SELECT
					E.* 
				FROM tblEmployee E 
			GO 

			DROP VIEW ViewByDepartment -- DROP 

		-- Adding extra rows through the views 

			BEGIN TRAN 

				INSERT INTO ViewByDepartment(NumberOfEmployee, Department, Total) 
				VALUES (199, 'HR', 999.99)

				SELECT 
					* 
				FROM ViewByDepartment
				ORDER BY Department, NumberOfEmployee

			ROLLBACK TRAN 