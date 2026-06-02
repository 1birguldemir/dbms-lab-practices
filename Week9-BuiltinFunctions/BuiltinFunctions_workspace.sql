-- ========================================================================================
-- Database Management Systems (DBMS)
-- Week 9: Built-in Functions
-- Database: db_Employee
-- ========================================================================================

USE db_Employee;
GO

-- ========================================================================================
-- 1. STRING FUNCTIONS
-- ========================================================================================

-- CHAR()
-- Task: Show the character equivalent of the numbers 100 and 71 according to their ascii code.
	SELECT CHAR(100) AS NumberCodeToCharacter;
	SELECT CHAR(71) AS NumberCodeToCharacter;

-- CHARINDEX()
-- Task 1: Write the query that checks whether your name contains the character 'o'.
-- Task 2: Write a query that searches for the index of the first two characters of your last name in a string containing the first and last name parts ('John Doe', starting from 2).
	SELECT CHARINDEX('o','birgül',1);
	SELECT CHARINDEX('de','birgül demir',2);

-- Slide 4-6: CONCAT() and + Operator
-- Task 1: You have three different strings such as name, surname and student number. Write the query that combines these three strings with a space between them.
-- Task 2: Concatenate employees' first and last names with a space in between (from employees table).
-- Task 3: Combine name, surname and student number strings with a space between them using the + operator.
	SELECT CONCAT('BÝRGÜL',' DEMÝR',' 220602002');
	SELECT CONCAT(employees.FirstName,' ', employees.LastName) AS FullName FROM employees;
	SELECT 'BÝRGÜL'+' '+'DEMÝR'+' '+'220602002';

-- Slide 7-8: CONCAT_WS()
-- Task 1: Write the query that combines first name, last name and student number strings with an underscore between them.
-- Task 2: Concatenate ProductID and ProductName with a dot separator (from products table).
	SELECT CONCAT_WS('_', 'Birgül', 'Demir','220602002');
	SELECT ProductID,ProductName,
	CONCAT_WS('.', ProductID, ProductName) AS ProductInfo
	FROM products;


-- Slide 9: LOWER() and UPPER()
-- Task 1: Type the query that converts the course name 'DATAbASe MAnAgemenT SYsTeMs' to uppercase letters.
-- Task 2: Convert customers country names to lowercase name (from Customers table).
	SELECT UPPER('DATAbASe MAnAgemenT SYsTeMs');
	SELECT Country, LOWER(Country) AS LowercaseCountry
	FROM Customers;


-- Slide 10-11: TRIM() - LTRIM() - RTRIM()
-- Task 1: Remove spaces from the string '     John       Doe* '.
-- Task 2: Remove spaces, # and ! characters from the string '    #Database   MS*!    '.
-- Task 3: Remove leading spaces from ProductName using LTRIM (from products table).
	SELECT TRIM(' John Doe* ') AS TrimmedString;
	SELECT TRIM('#! ' FROM ' #Database MS*! ');
	SELECT ProductID,
	LTRIM(ProductName) AS TrimmedProductName
	FROM products;

-- Slide 12: LEN() and DATALENGTH()
-- Task 1: Write the query that finds the total length of the string '   DBMS   '.
-- Task 2: Show LEN and DATALENGTH of Notes for each employee, ordered by byte length descending.
	SELECT LEN(' DBMS ');
	SELECT FirstName, LastName,
	LEN(CAST(Notes AS VARCHAR(MAX))) AS NotesCharLength,
	DATALENGTH(Notes) AS NotesByteLength
	FROM Employees
	ORDER BY NotesByteLength DESC;


-- Slide 13: REPLACE()
-- Task 1: Make sure the name of the course is spelled correctly by changing 'Structure' to 'Systems' in 'Database Management Structure'.
-- Task 2: Make sure the course name is spelled correctly by replacing 'n' with 'M' in 'DBNS'.
	SELECT REPLACE('Database Management Structure', 'Structure','Systems');
	SELECT REPLACE('DBNS', 'n', 'M');


-- Slide 14: REPLICATE()
-- Task 1: Write the query that repeats the course code ('SEN-222 ') 3 times.
-- Task 2: Write the query that displays the supplier country name repeated twice (from Suppliers table).
	SELECT REPLICATE('SEN-222 ', 3);
	SELECT Country, REPLICATE(Country, 2) AS ReplicatedCountry
	FROM Suppliers;


-- Slide 15: REVERSE()
-- Task 1: Reverse the long form of the course name: 'Database Management Systems'.
-- Task 2: Reverse the category names and show the original and reversed category names as two different columns (from Categories table).
	SELECT REVERSE('Database Management Systems');
	SELECT CategoryName, REVERSE(CategoryName) AS ReversedCategoryName
	FROM Categories;


-- Slide 16-17: SUBSTRING()
-- Task 1: Take only the second word from the string 'Database Management Systems' (Starts at 10, length 10).
-- Task 2: Write the query that takes the first 70 characters of the workers notes section (from Employees table).
-- Task 3: Extract the first word of the Address column using SUBSTRING and the first space (from customers table).
	SELECT SUBSTRING('Database Management Systems', 10, 10);
	SELECT SUBSTRING(Notes, 1, 70) AS ExtractString
	FROM Employees;
	SELECT CustomerID, Address,
	SUBSTRING(Address, 1, CHARINDEX(' ', Address+ ' ') - 1) AS FirstWordOfAddress
	FROM customers;

-- ========================================================================================
-- 2. MATHEMATICAL FUNCTIONS
-- ========================================================================================

-- Slide 18-19: ABS()
-- Task 1: Write the query that takes the absolute value of -310.47.
-- Task 2: Subtract 20 from each product's price and return the absolute value (from products table).
	SELECT Abs(-310.47) AS AbsNum;
	SELECT ProductID,ProductName,Price,
	ABS(Price - 20) AS AdjustedPrice
	FROM products;


-- Slide 20: CEILING() and FLOOR()
-- Task 1: Round the number 12.4 to the smallest integer greater than itself using CEILING.
-- Task 2: Round the number -29.65 to the largest integer smaller than itself using FLOOR.
	SELECT CEILING(12.4);
	SELECT FLOOR(-29.65)


-- Slide 21-22: ROUND()
-- Task 1: Round the decimal part of 18.7565 to 2 decimal places.
-- Task 2: Divide the product price by 4 and round the result to the nearest whole number (from products table).
	SELECT ROUND(18.7565, 2,-3) AS RoundedValue;
	SELECT ProductID,ProductName,Price,
	ROUND(Price / 4.0, 0) AS RoundedQuarterPrice
	FROM products;


-- Slide 23-27: EXP(), LOG(), POWER(), RAND(), SIGN(), RADIANS()
-- Task 1: Show the 4th power of e using EXP.
-- Task 2: Find the logarithm of 8 to base 8 using LOG.
-- Task 3: Show 3 to the power of 5 using POWER.
-- Task 4: Generate a random integer number between 3 and 12 using RAND and FLOOR.
-- Task 5: Test the values produced by the SIGN function for the values 33, -18 and 0.
-- Task 6: Find the equivalent of 90 degrees in radians using RADIANS.
	SELECT EXP(4);
	SELECT LOG(8,8);
	SELECT POWER(3,5);
	SELECT FLOOR(RAND()*(12-3+1)+3);
	SELECT SIGN(33);	
	SELECT SIGN(-18);
	SELECT SIGN(0);
	SELECT RADIANS(90.0);

-- ========================================================================================
-- 3. DATE AND TIME FUNCTIONS
-- ========================================================================================

-- Slide 28: CURRENT_TIMESTAMP and GETDATE()
-- Task: Get the current date and time with both functions.
	SELECT CURRENT_TIMESTAMP;
	SELECT GETDATE();



-- Slide 29: DATEADD()
-- Task: Add 3 months to '2024/05/02'.
	SELECT DATEADD(month, 3, '2024/05/02') AS newDate;



-- Slide 30-31: DATEDIFF()
-- Task 1: Find the year difference between '2024/05/02' and '2022/04/25'.
-- Task 2: Calculate the age of each employee using DATEDIFF on BirthDate and GETDATE() (from employees table).
	SELECT DATEDIFF(year, '2024/05/02','2022/04/25') AS DateDiff;
	SELECT EmployeeID,FirstName,LastName,BirthDate,
	DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age
	FROM employees;


-- Slide 32: ISDATE()
-- Task 1: Test if the string '2020-02-30' can be a date.
-- Task 2: Test if the string '2020-02-28' can be a date.
	SELECT ISDATE('2020-02-30');
	SELECT ISDATE('2020-02-28');

-- ========================================================================================
-- 4. CONVERSION AND LOGICAL FUNCTIONS
-- ========================================================================================

-- Slide 33: CAST()
-- Task: Convert the string '12.34' to float type.
	SELECT CAST('12.34' AS float);



-- Slide 34: COALESCE()
-- Task 1: Test the value that will be returned from the list 'Lab', NULL, 'Example'.
-- Task 2: Test the value that will be returned from the list NULL, 11, 12, 'Weeks', NULL.
	SELECT COALESCE('Lab', NULL, 'Example');
	SELECT COALESCE( NULL, 11, 12, 'Weeks', NULL );


-- Slide 35-36: CONVERT()
-- Task 1: Convert the string '2020-01-20' to datetime type.
-- Task 2: Convert the BirthDate column to British date format using CONVERT with style code 103 (from employees table).
	SELECT CONVERT(datetime, '2020-01-20');
	SELECT EmployeeID, FirstName,LastName,BirthDate,
	CONVERT(varchar, BirthDate, 103) AS FormattedBirthDate
	FROM employees;


-- Slide 37: IIF()
-- Task: From the Order_Details table, select OrderID, Quantity, and print 'MORE' for those with quantity greater than 20 and 'LESS' for the others.
	SELECT OrderID, Quantity, IIF(Quantity>20, 'MORE', 'LESS')
	FROM Order_Details;



-- Slide 38-39: ISNULL()
-- Task 1: Test which ISNULL function returns from the strings 'Hello' and 'Hi' respectively.
-- Task 2: Test which ISNULL function returns from NULL and 'Hi' respectively.
-- Task 3: Use ISNULL to replace NULL values in the PostalCode column with a default text like 'No Code' (from customers table).
	SELECT ISNULL('Hello', 'Hi');
	SELECT ISNULL(NULL, 'Hi');
	SELECT CustomerID,CustomerName,
	ISNULL(PostalCode, 'No Code') AS PostalCodeDisplay
	FROM customers;

-- Slide 40: NULLIF()
-- Task: See what the NULLIF function returns for values 5 and 10.
	SELECT NULLIF(5, 10);



-- Slide 41: ISNUMERIC()
-- Task 1: Test what the ISNUMERIC() function returns for 3*4.
-- Task 2: Test what the ISNUMERIC() function returns for '24a'.
	SELECT ISNUMERIC(3*4);
	SELECT ISNUMERIC('24a');


-- Slide 42: TRY_PARSE()
-- Task: Try to convert '2025-05-14' and 'not-a-date' to a date using TRY_PARSE and 'en-US' culture.
	SELECT '2025-05-14' AS InputString,
	TRY_PARSE('2025-05-14' AS date USING 'en-US') AS ParsedString
	UNION
	SELECT 'not-a-date',
	TRY_PARSE('not-a-date' AS date USING 'en-US');


-- ========================================================================================
-- 5. RANKING FUNCTIONS & COMBINED USAGE
-- ========================================================================================

-- Slide 43: ROWNUMBER()
-- Task: Rank products based on their price in descending order using ROW_NUMBER (from products table).
	SELECT ProductID, ProductName,Price, ROW_NUMBER() OVER (ORDER BY price DESC) FROM products ;



-- Slide 44: RANK()
-- Task: Rank products based on their price in descending order using RANK (from products table).
	SELECT ProductID, ProductName,Price, RANK() OVER (ORDER BY price DESC) FROM products ;



-- Slide 45: REPLICATE(), CAST(), and CONCAT()
-- Task: Add leading zeros to CustomerID to make it 10 characters long using REPLICATE, CAST, and CONCAT (from customers table).
	