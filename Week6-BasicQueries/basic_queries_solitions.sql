-- =========================================================================
-- Database Management Systems (DBMS)
-- Week 6: Basic Queries (T-SQL / MS SQL Server)
-- HotelDB Laboratory Exercises - Workspace Template
-- =========================================================================

USE HotelDB;
GO

-- =========================================================================
-- PART 1: BASIC SELECT AND FILTERING (WHERE CLAUSE)
-- =========================================================================

-- EX1: Retrieve all records from the Staff table. [cite: 5]
	SELECT * FROM Staff;

-- EX2: List the first and last names of staff members who work as Receptionists. [cite: 8]
	SELECT FirstName,LastName FROM Staff 
	WHERE Position = 'Receptionist';

-- EX3: Find all rooms where the price per night is between 100 and 200. [cite: 11]
	SELECT * FROM Rooms 
	WHERE PricePerNight BETWEEN 100 AND 200;

-- EX4: Show rooms that are either 'Suite' or 'Double' type. [cite: 14]
	SELECT * FROM Rooms 
	WHERE Type = 'Suite' OR Type = 'Double';

-- EX5: List the room numbers of all rooms that are not of type 'Single'. [cite: 18]
	SELECT RoomNumber 
	FROM Rooms
	WHERE NOT (TYPE = 'Single')

-- EX6: Get customers who are from either the USA or the UK. [cite: 26]
	SELECT * FROM Customers
	WHERE COUNTRY IN('USA','UK');

-- =========================================================================
-- PART 2: SORTING & PATTERN MATCHING (ORDER BY & LIKE)
-- =========================================================================

-- EX7: List available rooms, sorted by price per night in descending order. [cite: 30]
	SELECT * FROM Rooms 
	WHERE IsAvailable = 1 
	ORDER BY PricePerNight DESC;

-- EX8: List the room IDs and room numbers where the room number has '0' as the middle digit. [cite: 33]
	SELECT RoomID, RoomNumber
	FROM Rooms
	WHERE RoomNumber LIKE '_0_';

-- EX9: Show all payments where the payment method starts with the letter 'C'. [cite: 38]
	SELECT * FROM Payments 
	WHERE PaymentMethod LIKE 'C%';

-- EX10: List all unique payment methods used in payments. [cite: 41]
	SELECT DISTINCT PaymentMethod FROM Payments;  --tekrar eden verileri filtreler (uniqe)

-- =========================================================================
-- PART 3: AGGREGATE FUNCTIONS & GROUPING (GROUP BY & HAVING)
-- =========================================================================

-- EX11: How many total bookings have been made? [cite: 44]
	SELECT COUNT(*) AS TotalBookings
	FROM Bookings;


-- EX12: What is the average payment amount? [cite: 47]
	SELECT AVG(Amount) AS AvgPayment
	FROM Payments


-- EX14: Count the number of customers by country. [cite: 57]
	SELECT Country , COUNT(Country) as NumOfCountry
	FROM Customers
	GROUP BY Country;

-- EX15: Which staff positions have more than one employee? [cite: 60]
	SELECT Position, COUNT(Position) AS StaffCount From Staff GROUP BY Position
	HAVING COUNT(Position)>1;

-- =========================================================================
-- PART 4: ADVANCED TOPICS (SUBQUERIES, NULL CONTROLS & FUNCTIONS)
-- =========================================================================

-- EX13: List all payments where the amount is greater than the average payment amount. [cite: 50]
	SELECT * FROM Payments WHERE Amount > (SELECT AVG(Amount) FROM Payments) ;


-- EX16: Count the number of customers who have a non-null email address. [cite: 63]
	UPDATE Customers
	SET Email = NULL
	WHERE CustomerID = 3;

	SELECT COUNT(Email) AS EmailCount From Customers;

-- EX17: List customers whose email is not null. [cite: 69]
	SELECT * FROM Customers WHERE Email IS NOT NULL;

-- EX18: Find rooms where availability status is unknown. [cite: 72]
	SELECT * FROM Rooms
	WHERE IsAvailable IS NULL;

-- EX19: Show full names of all staff by combining first and last names. [cite: 75]
	SELECT FirstName+' '+LastName AS FullName FROM Staff ;

-- EX20: List bookings where the check-in date is after November 1, 2024. [cite: 78]
	SELECT * FROM Bookings 
	WHERE CheckInDate > '2024-11-01';

-- EX21: Show payments where the amount is greater than 300 and the method is Credit Card. [cite: 81]
	SELECT * FROM Payments 
	WHERE Amount > 300 AND PaymentMethod = 'Credit Card';

-- EX22: Show the top 3 highest-paid staff members. [cite: 84]
	SELECT TOP 3 * FROM Staff Salary 
	ORDER BY Salary DESC;

-- EX23: What are the minimum and maximum salaries among all staff members? [cite: 87]
	SELECT MIN(Salary)	AS MinSalary, MAX(Salary) AS MaxSalary
	FROM Staff ;

-- EX24: How many times has each room been booked? [cite: 90]
	SELECT RoomID, COUNT(*) AS TimesBooked  
	FROM Bookings 
	GROUP BY RoomID;

-- EX25: List the number of rooms for each room type and availability status. [cite: 93]
	SELECT  Type, IsAvailable, COUNT(*) FROM Rooms GROUP BY Type , IsAvailable;

-- EX26: Show booking IDs and amounts for all payments, ordered by amount in descending order. [cite: 98]
	SELECT BookingID, Amount 
	FROM Payments 
	WHERE Amount IS NOT NULL
	ORDER BY Amount DESC;

-- EX27: For each booking, calculate the number of nights stayed. [cite: 101]3
	SELECT BookingID, DATEDIFF(Day,CheckInDate,CheckOutDate) AS NightsStayed FROM Bookings ;