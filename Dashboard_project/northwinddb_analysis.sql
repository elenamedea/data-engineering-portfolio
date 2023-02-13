-- Throughout the week write SQL queries to answer the questions below

\c northwind

--1. Get the names and the quantities in stock for each product.

SELECT productName, unitsInStock
FROM products
ORDER BY unitsInStock;

--2. Get a list of current products (Product ID and name).

SELECT productID, productName, unitsInStock
FROM products
WHERE discontinued = 0 AND unitsInStock != 0
ORDER BY unitsInStock;

--3. Get a list of the most and least expensive products (name and unit price).

SELECT productName, unitPrice
FROM products
ORDER BY unitPrice DESC
LIMIT 10;

SELECT productName, unitPrice
FROM products
ORDER BY unitPrice
LIMIT 10;

--4. Get products that cost less than $20.

SELECT productID, productName, unitPrice
FROM products
WHERE unitPrice < 20.0
ORDER BY unitPrice;

--5. Get products that cost between $15 and $25.

SELECT productID, productName, unitPrice
FROM products
WHERE unitPrice BETWEEN 15.0 AND 25.0
ORDER BY unitPrice;

--6. Get products above average price.

SELECT productName, unitPrice
FROM products
WHERE unitPrice > (SELECT AVG(unitPrice) FROM products)
ORDER BY unitPrice;

--7. Find the ten most expensive products.

SELECT productID, productName, unitPrice
FROM products
ORDER BY unitPrice DESC 
LIMIT 10;

--8. Get a list of discontinued products (Product ID and name).

SELECT productID, productName
FROM products
WHERE discontinued = 1;

--9. Count current and discontinued products.

SELECT COUNT(productID)
FROM products
GROUP BY discontinued;

--10. Find products with less units in stock than the quantity on order.

SELECT productID, productName, unitsInStock, unitsOnOrder
FROM products
WHERE unitsInStock < unitsOnOrder
ORDER BY (unitsOnOrder - unitsInStock);

--11. Find the customer who had the highest order amount.

SELECT customers.customerID, customers.companyName, 
SUM(order_details.unitPrice * order_details.quantity) AS order_amount
FROM customers 
JOIN orders ON customers.customerID = orders.customerID 
JOIN order_details ON orders.orderID = order_details.orderID 
GROUP BY customers.customerID 
ORDER BY order_amount DESC
LIMIT 1;

--12. Get orders for a given employee and the according customer.

SELECT employees.employeeID, employees.lastName, 
employees.firstName,
customers.companyName,
COUNT(order_details.orderID) AS total_orders
FROM orders
JOIN order_details ON orders.orderID = order_details.orderID
JOIN employees ON orders.employeeID = employees.employeeID
JOIN customers ON orders.customerID = customers.customerID
GROUP BY employees.employeeID, customers.companyName
ORDER BY total_orders DESC;

--13. Find the hiring age of each employee.

SELECT employeeID, firstName, lastName, 
hireDate, birthDate, 
date_part('year', hireDate) - date_part('year', birthDate) AS hiring_age
FROM employees
ORDER BY hiring_age;

--14. Create views and/or named queries for some of these queries.

-- Find the order amount delivered to each country (VIEW).

DROP VIEW if exists order_amount_by_country_view;

CREATE VIEW order_amount_by_country_view AS
SELECT customers.country,
SUM(order_details.unitPrice * order_details.quantity) AS order_amount
FROM order_details 
INNER JOIN orders ON order_details.orderID = orders.orderID
INNER JOIN customers ON orders.customerID = customers.customerID
GROUP BY customers.country 
ORDER BY order_amount DESC;

SELECT * FROM order_amount_by_country_view;

-- Find the N_orders for each product by country (VIEW).

DROP VIEW if exists product_orders_by_country_view;

CREATE VIEW product_orders_by_country_view AS
SELECT COUNT(order_details.orderID) AS N_orders, 
products.productName, orders.shipCountry
FROM order_details
JOIN orders ON order_details.orderID = orders.orderID
JOIN products ON order_details.productID = products.productID
GROUP BY products.productName, orders.shipCountry
ORDER BY N_orders;

SELECT * FROM product_orders_by_country_view;

-- Find the hiring age of each employee (VIEW).

DROP VIEW if exists hiring_age_view;

CREATE VIEW hiring_age_view AS
SELECT employeeID, firstName, lastName, 
hireDate, birthDate, 
date_part('year', hireDate) - date_part('year', birthDate) AS hiring_age
FROM employees
ORDER BY hiring_age;

SELECT * FROM hiring_age_view;

