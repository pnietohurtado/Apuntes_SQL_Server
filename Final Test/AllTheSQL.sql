-- Summary of the sql udemy course 

-- Bibliografía 

	-- #1. "Alter" command inside the tblEmployee 
	-- #2. "Insert" command inside tblEmployee 
	-- #3. Simple "SELECT" queries (ONLY 'SELECT' queries) 
		-- #3.1. Where practice 
		-- #3.2. More complex "SELECT" queries 
		-- #3.3. "SELECT" interest functions (for functionallity) 
		-- #3.4 Use of "HAVING" command 



CREATE TABLE tblEmployee(

	EmployeeNumber INT NOT NULL, 
	EmployeeFirstName VARCHAR(50) NOT NULL, 
	EmployeeMiddleName VARCHAR(50) NULL, 
	EmployeeLastName VARCHAR(50) NOT NULL, 
	EmployeeGovernmentID CHAR(10) NOT NULL, -- It will be exactly the same if we speak about the DNI
	DateOfBirth DATE NOT NULL

);


-- Alter key factors 

-- #1. "Alter" command inside the tblEmployee 

ALTER TABLE tblEmployee 
ADD Department VARCHAR(50) NOT NULL 
GO 

ALTER TABLE tblEmployee
ALTER COLUMN Department VARCHAR(20)
GO 


-- Insert key factors  

-- #2. "Insert" command inside tblEmployee 

INSERT INTO tblEmployee VALUES (132, 'Dylan' , 'A', 'Word', 'HN513777D', '1992-01-12', 'Customer Relations')
GO 

INSERT INTO tblEmployee(EmployeeNumber, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeGovernmentID, DateOfBirth, Department)
VALUES (132, 'Dylan' , 'A', 'Word', 'HN513777D', '1992-01-12', 'Customer Relations')
GO 


-- Select key factors 

-- #3. Simple "SELECT" queries 

	SELECT 
		E.* 
	FROM tblEmployee E 

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



-- #@. Exercises 

	-- #@1. 
		SELECT 
			MONTH(E.DateOfBirth) AS Mes, -- If you want the name you can use "DATENAME(MONTH, COLUMN)" 
			COUNT(*) 
		FROM tblEmployee E 
		GROUP BY MONTH(E.DateOfBirth)
		ORDER BY MONTH(E.DateOfBirth) ASC 