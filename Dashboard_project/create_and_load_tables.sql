\c northwind

DROP TABLE if exists categories;

CREATE TABLE categories (categoryID INT PRIMARY KEY,
categoryName VARCHAR(100), 
description VARCHAR(300), 
picture TEXT);

\copy categories FROM 'data/categories.csv' DELIMITER ',' CSV HEADER NULL AS 'NULL';


DROP TABLE if exists customers;

CREATE TABLE customers (customerID VARCHAR(100) PRIMARY KEY,
companyName VARCHAR(250),
contactName VARCHAR(250),
contactTitle VARCHAR(50),
address VARCHAR(250), 
city VARCHAR(100), 
region VARCHAR(100), 
postalCode VARCHAR(50), 
country VARCHAR(100), 
phone VARCHAR(25), 
fax VARCHAR(25));

\copy customers FROM 'data/customers.csv' DELIMITER ',' CSV HEADER NULL AS 'NULL';


DROP TABLE if exists employees;

CREATE TABLE employees (employeeID INT PRIMARY KEY, 
lastName VARCHAR(100), 
firstName VARCHAR(100), 
title VARCHAR(100), 
titleOfCourtesy VARCHAR(15),
birthDate TIMESTAMP, 
hireDate TIMESTAMP, 
address VARCHAR(250), 
city VARCHAR(100), 
region VARCHAR(100), 
postalCode VARCHAR(50), 
country VARCHAR(100), 
homePhone VARCHAR(100), 
extension VARCHAR(50), 
photo VARCHAR(1500), 
notes VARCHAR(1500), 
reportsTo INT, 
photoPath VARCHAR(300),
FOREIGN KEY (reportsTo) REFERENCES employees(employeeID) ON DELETE CASCADE);

\copy employees FROM 'data/employees.csv' DELIMITER ',' CSV HEADER NULL AS 'NULL';


DROP TABLE if exists employee_territories;

CREATE TABLE employee_territories (employeeID INT, 
territoryID INT PRIMARY KEY, FOREIGN KEY (employeeID) REFERENCES employees(employeeID) ON DELETE CASCADE);

\copy employee_territories FROM 'data/employee_territories.csv' DELIMITER ',' CSV HEADER NULL AS 'NULL'; 


DROP TABLE if exists shippers;

CREATE TABLE shippers (shipperID INT PRIMARY KEY, 
companyName VARCHAR(250), 
phone VARCHAR(100));

\copy shippers FROM 'data/shippers.csv' DELIMITER ',' CSV HEADER;


DROP TABLE if exists orders;

CREATE TABLE orders (orderID INT PRIMARY KEY, 
customerID VARCHAR(50),
employeeID INT, 
orderDate TIMESTAMP, 
requierdDate TIMESTAMP, 
shippedDate TIMESTAMP,
shipVia INT, 
freight NUMERIC, 
shipName VARCHAR(250), 
shipAddress VARCHAR(250), 
shipCity VARCHAR(100), 
shipRegion VARCHAR(100), 
shipPostalCode VARCHAR(50), 
shipCountry VARCHAR(100),
FOREIGN KEY (customerID) REFERENCES customers(customerID) ON DELETE CASCADE,
FOREIGN KEY (employeeID) REFERENCES employees(employeeID) ON DELETE CASCADE,
FOREIGN KEY (shipVia) REFERENCES shippers(shipperID) ON DELETE CASCADE);

\copy orders FROM 'data/orders.csv' DELIMITER ',' CSV HEADER NULL AS 'NULL';


DROP TABLE if exists suppliers;

CREATE TABLE suppliers (supplierID INT PRIMARY KEY, 
companyName VARCHAR(250), 
contactName VARCHAR (100), 
contactTitle VARCHAR(100), 
address VARCHAR(250), 
city VARCHAR(100), 
region VARCHAR(100), 
postalCode VARCHAR(50), 
country VARCHAR(100), 
phone VARCHAR(100), 
fax VARCHAR(100), 
homePage VARCHAR(1000));

\copy suppliers FROM 'data/suppliers.csv' DELIMITER ',' CSV HEADER;


DROP TABLE if exists products;

CREATE TABLE products (productID INT PRIMARY KEY, 
productName VARCHAR(250), 
supplierID INT,
categoryID INT, 
quantityPerUnit VARCHAR(300), 
unitPrice NUMERIC, 
unitsInStock INT, 
unitsOnOrder INT, 
reorderLevel INT, 
discontinued INT, 
FOREIGN KEY (supplierID) REFERENCES suppliers(supplierID) ON DELETE CASCADE,
FOREIGN KEY (categoryID) REFERENCES categories(categoryID) ON DELETE CASCADE);

\copy products FROM 'data/products.csv' DELIMITER ',' CSV HEADER NULL AS 'NULL';


DROP TABLE if exists order_details;

CREATE TABLE order_details (orderID INT,
productID INT, 
unitPrice NUMERIC, 
quantity INT, 
discount NUMERIC, FOREIGN KEY (orderID) REFERENCES orders(orderID) ON DELETE CASCADE, 
FOREIGN KEY (productID) REFERENCES products(productID) ON DELETE CASCADE);

\copy order_details FROM 'data/order_details.csv' DELIMITER ',' CSV HEADER NULL AS 'NULL';


DROP TABLE if exists regions;

CREATE TABLE regions (regionID INT PRIMARY KEY, 
regionDescription VARCHAR(250));

\copy regions FROM 'data/regions.csv' DELIMITER ',' CSV HEADER;


DROP TABLE if exists territories;

CREATE TABLE territories (territoryID INT PRIMARY KEY, 
territoryDescription VARCHAR(100), 
regionID INT,
FOREIGN KEY (regionID) REFERENCES regions(regionID) ON DELETE CASCADE);

\copy territories FROM 'data/territories.csv' DELIMITER ',' CSV HEADER;

