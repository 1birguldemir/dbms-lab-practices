-- =========================================================================
-- Database Management Systems (DBMS)
-- Week 7: Relational Algebra, JOINs, and Subqueries
-- =========================================================================

-- =========================================================================
-- PART 1: AGGREGATIONS (Relational Algebra Converted to SQL)
-- Note: Execute these queries using the MoviesDB
-- =========================================================================
USE MoviesDB;
GO

-- EX1: Find the total number of movies in the database.
	SELECT COUNT(*) FROM Movies;

-- EX2: Calculate the average movie duration.
	SELECT AVG(Duration) AS AvgDuration FROM Movies ;

-- EX3: Find the maximum movie duration per director.
	SELECT DirectorID, MAX(Duration) AS MaxDuration FROM Movies GROUP BY DirectorID;

-- EX4: Find the number of unique actors that worked with each director.
	SELECT DirectorID, COUNT(DISTINCT ActorID) AS UniqeActorCount
	FROM Movies JOIN MovieActors ON Movies.MovieID = MovieActors.MovieID 
	GROUP BY DirectorID;

-- EX5: For movies released in 2024, list the number of movies directed by each director.
	SELECT DirectorName , COUNT(MovieID) 
	FROM Movies JOIN Directors
	ON Movies.DirectorID = Directors.DirectorID
	WHERE ReleaseYear = 2024 
	GROUP BY DirectorName;

-- EX6: For each movie released in 2023, calculate the average age of actors who acted in it.
	SELECT MovieName, AVG(Age)
	FROM Movies 
	JOIN MovieActors ON Movies.MovieID = MovieActors.MovieID
	JOIN Actors ON MovieActors.ActorID = Actors.ActorID
	WHERE ReleaseYear = 2023
	GROUP BY MovieName

-- EX7: For award-winning movies in 2024, find the average duration per award category.
	SELECT AwardName , AVG(Duration)
	FROM Movies m
	JOIN Awards a ON m.MovieID = a.MovieID
	WHERE a.Year = 2024
	GROUP BY a.AwardName;

-- EX8: For each director, find the average duration of the movies they directed that won an award.
	SELECT d.DirectorName , AVG(m.Duration) AS AvgDuration
	FROM Movies m
	JOIN Directors d ON m.DirectorID= d.DirectorID
	JOIN Awards a ON m.MovieID = a.MovieID
	GROUP BY d.DirectorName;


-- =========================================================================
-- PART 2: JOIN OPERATIONS & ADVANCED SUBQUERIES
-- Note: Execute these queries using the db_Employee
-- =========================================================================
USE db_Employee;
GO

-- JOIN_01: Select the product id, product name, and category name (Using INNER JOIN).
	SELECT ProductID, ProductName, CategoryName 
	FROM products INNER JOIN categories
	ON products.CategoryID = categories.CategoryID;

-- JOIN_02: Select the product id, product name, and category name (Without using the JOIN keyword / Implicit Join).
	SELECT p.ProductID, p.ProductName, c.CategoryName 
	FROM products p, categories c
	WHERE P.CategoryID = C.CategoryID;

-- JOIN_03: Select customer name and order id (Pair every customer with every order using CROSS JOIN).
	SELECT CustomerName, OrderID 
	FROM customers CROSS JOIN orders;

-- JOIN_04: Select all customers and any orders they may have, sorted ascending by customer name (Using LEFT OUTER JOIN).
	SELECT c.CustomerName,o.OrderID 
	FROM customers c LEFT OUTER JOIN orders o 
	ON c.CustomerID = o.CustomerID 
	ORDER BY c.CustomerName ASC;

-- JOIN_05: Combine all employees and the orders, in ascending order according to order id (Using RIGHT OUTER JOIN).
	SELECT o.OrderID ,e.FirstName, e.LastName 
	FROM orders o RIGHT OUTER JOIN employees e
	on o.EmployeeID= e.EmployeeID
	ORDER BY OrderID ASC;

-- JOIN_06: Select customer name and order id, in ascending order by customer name (Using FULL OUTER JOIN).
	SELECT CustomerName, OrderID 
	FROM customers FULL OUTER JOIN orders
	ON customers.CustomerID = orders.CustomerID
	ORDER BY CustomerName ASC;

-- JOIN_07: List customer names along with their order IDs and order dates (INNER JOIN).
	SELECT c.CustomerName,o.OrderID, o.OrderDate
	FROM customers c INNER JOIN orders o
	ON c.CustomerID = o.CustomerID;

-- JOIN_08: Display each order with the employee who handled it.
	SELECT o.OrderID ,e.FirstName, e.LastName 
	FROM orders o JOIN employees e
	on o.EmployeeID= e.EmployeeID;

-- JOIN_09: Show order details (OrderID) including product names and quantities.
	SELECT od.OrderID, p.ProductName, od.Quantity
	FROM order_details od JOIN products p
	ON od.ProductID = p.ProductID;

-- JOIN_10: List customer names, their orders (OrderID), and the employee names responsible for those orders (Multiple JOINs).
	SELECT c.CustomerName, o.OrderID, e.FirstName, e.LastName 
	FROM customers c JOIN orders o 
	ON c.CustomerID = o.CustomerID
	JOIN employees e 
	ON o.EmployeeID = e.EmployeeID;

-- =========================================================================
-- PART 3: ADVANCED SUBQUERIES (EXISTS, ANY, ALL)
-- =========================================================================

-- SUB_01: List employees who have more than 10 orders (Using EXISTS).
	SELECT e.FirstName, e.LastName 
	FROM employees e
	WHERE EXISTS(SELECT 1 FROM orders o 
	WHERE e.EmployeeID = o.EmployeeID
	GROUP BY o.EmployeeID 
	HAVING COUNT(*)>10);

-- SUB_02: List products that are more expensive than at least one product in Category 1 (Using ANY).
	SELECT p.ProductName, p.Price FROM products p 
	WHERE Price > ANY (SELECT Price From products WHERE CategoryID =1);

-- SUB_03: List products that are more expensive than all products in Category 3 (Using ALL).
	SELECT p.ProductName, p.Price FROM products p
	WHERE Price > ALL (SELECT Price FROM products WHERE CategoryID = 3);

-- SUB_04: List the customers who have never placed any orders (Using NOT EXISTS).
	SELECT c.CustomerName 
	FROM customers c 
	WHERE NOT EXISTS
	(SELECT 1 FROM orders o WHERE c.CustomerID= o.CustomerID);

-- SUB_05: Alternative to SUB_04 - List the customers who have never placed any orders (Using LEFT JOIN & IS NULL).
	SELECT c.CustomerName FROM customers c LEFT JOIN orders o ON c.CustomerID = o.CustomerID WHERE o.CustomerID IS NULL;