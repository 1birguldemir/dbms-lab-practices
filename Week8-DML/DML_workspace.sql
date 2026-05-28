-- =========================================================================
-- Database Management Systems (DBMS)
-- Week 8: DML (INSERT, UPDATE, DELETE) & Set Operations
-- =========================================================================
	USE HotelDB;
	GO
-- EX1: Insert a new customer into the Customers table.
	INSERT INTO Customers (FirstName,LastName,Email,Phone,Country)
	VALUES ('Michael','Jordan','m.jordan@email.com','+111222333','USA');

-- EX2: Insert multiple staff members in a single query.
	INSERT INTO Staff(FirstName,LastName,Position,HireDate,Salary)
	VALUES ('Daniel','Moore','Chef','2023-02-10',3500.00),
	('Emily','Clark','Cleaner','2024-01-15',2800.00);
-- EX3: Create a new table named VIPCustomers and insert customers from USA and UK using INSERT...SELECT.
	CREATE TABLE VIPCustomers (
	CustomerID INT,
	FullName NVARCHAR(100),
	Country NVARCHAR(50));

	INSERT INTO VIPCustomers(CustomerID,FullName,Country)
	SELECT CustomerID,FirstName+' '+LastName,Country
	FROM Customers
	WHERE Country IN('USA','UK');

-- EX4: Update the price of room with RoomID = 1 to 90.00.
	UPDATE Rooms
	SET PricePerNight = 90.00
	WHERE RoomID = 1;

-- EX5: Update the position and salary of the staff member with StaffID = 1. Set the position to 'Senior Receptionist' and salary to 3600.
	UPDATE Staff
	SET Position = 'Senior Receptionist',Salary =3600.00
	WHERE StaffID = 1;

-- EX6: Update room availability to 0 (not available) for rooms that have bookings paid by 'Credit Card'. (Use JOIN)
	UPDATE Rooms
	SET IsAvailable = 0
	FROM Rooms r 
	JOIN Bookings b ON r.RoomID = b.RoomID
	JOIN Payments p ON b.BookingID = p.BookingID
	WHERE PaymentMethod = 'Credit Card';

-- EX7: Increase staff salaries based on the following rules using CASE:
-- If salary < 3000 -> increase by 500
-- If salary is between 3000 and 4000 -> increase by 300
-- Otherwise -> increase by 200
	UPDATE Staff
	SET Salary = CASE
	WHEN Salary < 3000 THEN Salary + 500
	WHEN Salary<4000 THEN Salary + 300
	ELSE Salary +200
	END;
-- EX8: Delete all payments where the payment method is 'Cash'.
	DELETE FROM Payments WHERE PaymentMethod = 'Cash';

-- EX9: Delete all staff members whose salary is less than 3000.
	DELETE FROM Staff WHERE Salary < 3000;

-- EX10 (Part 1): Delete all records from the Payments table that are linked to bookings with a check-out date earlier than '2024-11-01'.
	DELETE p FROM Payments p 
	JOIN Bookings b ON p.BookingID = b.BookingID
	WHERE b.CheckOutDate < '2024-11-01';

-- EX10 (Part 2): Delete all records from the Bookings table with a check-out date earlier than '2024-11-01'.
	DELETE FROM Bookings WHERE CheckOutDate < '2024-11-01';

-- =========================================================================
-- PART 2: SET OPERATIONS (UNION, INTERSECT, EXCEPT)
-- =========================================================================

-- EX11: Retrieve a list of all unique first and last names from both Customers and Staff tables. (Use UNION)
	SELECT FirstName, LastName
	FROM Customers
	UNION 
	SELECT FirstName, LastName
	FROM Staff;

-- EX12: Retrieve room numbers that are either available OR of type 'Single', including duplicates. (Use UNION ALL)
	SELECT RoomNumber 
	FROM Rooms 
	WHERE IsAvailable = 1
	UNION ALL 
	SELECT RoomNumber 
	FROM Rooms 
	WHERE Type = 'Single';

-- EX13: Retrieve room numbers that are both available AND of type 'Single'. (Use INTERSECT)
	SELECT RoomNumber 
	FROM Rooms 
	WHERE IsAvailable = 1
	INTERSECT 
	SELECT RoomNumber 
	FROM Rooms 
	WHERE Type = 'Single';

-- EX14: Retrieve customers who have bookings but have NOT made any payments. (Use EXCEPT)
	SELECT CustomerID
	FROM Bookings 
	EXCEPT 
	SELECT b.CustomerID
	FROM Bookings b JOIN Payments p
	ON b.BookingID = p.BookingID;

-- EX15: Retrieve customers who have at least one booking AND at least one payment. (Use INTERSECT)
	SELECT CustomerID
	FROM Bookings
	INTERSECT
	SELECT b.CustomerID
	FROM Bookings b JOIN Payments p
	ON b.BookingID = p.BookingID;

-- EX16: Retrieve customer IDs who have bookings but whose bookings do NOT have any payment records. (Use EXCEPT)
	SELECT c.CustomerID , c.FirstName
	FROM Customers c
	WHERE c.CustomerID IN (SELECT CustomerID FROM Bookings)
	EXCEPT
	SELECT c.CustomerID , c.FirstName
	FROM Customers c
	WHERE c.CustomerID IN (SELECT b.CustomerID FROM Bookings b JOIN Payments p 
	ON b.BookingID = p.BookingID);

-- EX17: Retrieve a combined list of customers who have bookings and staff members with salary > 4000. Include ID, Name, and Type (Customer/Staff). (Use UNION)
	SELECT c.CustomerID AS ID,
	c.FirstName,
	'Customer' AS Type
	FROM Customers c
	WHERE CustomerID IN ( SELECT CustomerID FROM Bookings)
	UNION
	SELECT s.StaffID AS ID,
	s.FirstName,
	'Staff' AS Type
	FROM Staff s
	WHERE Salary > 4000;