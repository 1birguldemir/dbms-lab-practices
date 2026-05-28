

CREATE DATABASE HotelDB;
GO

USE HotelDB;
GO


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    Country NVARCHAR(50)
);

CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY IDENTITY(1,1),
    RoomNumber NVARCHAR(10),
    Type NVARCHAR(20),
    PricePerNight DECIMAL(10,2),
    IsAvailable BIT
);


CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    RoomID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    BookingDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);


CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    BookingID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    PaymentMethod NVARCHAR(20),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);


CREATE TABLE Staff (
    StaffID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Position NVARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10,2)
);

INSERT INTO Customers (FirstName, LastName, Email, Phone, Country) VALUES
('John', 'Doe', 'john.doe@email.com', '+123456789', 'USA'),
('Emma', 'Smith', 'emma.smith@email.com', '+987654321', 'UK'),
('Carlos', 'Martinez', 'c.martinez@email.com', '+456123789', 'Spain'),
('Li', 'Wei', 'li.wei@email.com', '+852963741', 'China'),
('Ava', 'Brown', 'ava.brown@email.com', '+1122334455', 'Australia');


INSERT INTO Rooms (RoomNumber, Type, PricePerNight, IsAvailable) VALUES
('101', 'Single', 80.00, 1),
('102', 'Double', 120.00, 1),
('201', 'Suite', 250.00, 0),
('202', 'Double', 130.00, 0),
('301', 'Single', 85.00, 1);


INSERT INTO Bookings (CustomerID, RoomID, CheckInDate, CheckOutDate, BookingDate) VALUES
(1, 1, '2024-12-01', '2024-12-05', '2024-11-20'),
(2, 2, '2024-11-15', '2024-11-20', '2024-11-01'),
(3, 3, '2024-10-10', '2024-10-12', '2024-09-25'),
(4, 4, '2024-12-20', '2024-12-25', '2024-12-01'),
(5, 5, '2024-11-01', '2024-11-04', '2024-10-20');

INSERT INTO Payments (BookingID, Amount, PaymentDate, PaymentMethod) VALUES
(1, 320.00, '2024-11-25', 'Credit Card'),
(2, 600.00, '2024-11-15', 'Cash'),
(3, 500.00, '2024-10-10', 'Online'),
(4, 650.00, '2024-12-20', 'Credit Card'),
(5, 255.00, '2024-11-01', 'Cash');


INSERT INTO Staff (FirstName, LastName, Position, HireDate, Salary) VALUES
('Alice', 'Johnson', 'Receptionist', '2020-01-10', 3200.00),
('Mark', 'Evans', 'Manager', '2018-03-15', 5500.00),
('Sophie', 'Taylor', 'Cleaner', '2021-05-22', 2700.00),
('Liam', 'Wilson', 'Receptionist', '2019-11-30', 3100.00),
('Olivia', 'Davis', 'Accountant', '2022-07-01', 4000.00);


