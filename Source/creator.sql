DROP TABLE IF EXISTS Person CASCADE;
DROP TABLE IF EXISTS Client CASCADE;
DROP TABLE IF EXISTS Supplier CASCADE;
DROP TABLE IF EXISTS Userino CASCADE;
DROP TABLE IF EXISTS Manager CASCADE;
DROP TABLE IF EXISTS PoSOperator CASCADE;
DROP TABLE IF EXISTS ShopKeeper CASCADE;
DROP TABLE IF EXISTS Report CASCADE;
DROP TABLE IF EXISTS Delivery CASCADE;
DROP TABLE IF EXISTS Deposit CASCADE;
DROP TABLE IF EXISTS Sales CASCADE;
DROP TABLE IF EXISTS Building CASCADE;
DROP TABLE IF EXISTS Storage CASCADE;
DROP TABLE IF EXISTS PointOfSale CASCADE;
DROP TABLE IF EXISTS Product CASCADE;
DROP TABLE IF EXISTS Transaction CASCADE;
DROP TABLE IF EXISTS CompanyCliente CASCADE;
DROP TABLE IF EXISTS SupplierCompany CASCADE;
DROP TABLE IF EXISTS Orderino CASCADE;
DROP TABLE IF EXISTS Quantity CASCADE;
DROP TABLE IF EXISTS ProductOrder CASCADE;
DROP TABLE IF EXISTS ShopKeeperPointOfSale CASCADE;
DROP TABLE IF EXISTS ProductBuilding CASCADE;
DROP DOMAIN IF EXISTS zip_code;
DROP TYPE IF EXISTS reportType;
DROP TYPE IF EXISTS workday;
DROP TYPE IF EXISTS weekday;
DROP INDEX IF EXISTS price_indx;

CREATE DOMAIN zip_code AS TEXT
CHECK(
    VALUE ~ '^\d{4}-\d{3},[A-Z][a-z]*((\s[A-Z][a-z]*)|(\s[a-z]*))*'
);

CREATE TYPE reportType AS ENUM('Sales','Deposit','Delivery');

CREATE TYPE workday AS ENUM('Monday','Tuesday','Wednesday','Thursday','Friday');

CREATE TYPE weekday AS ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');

CREATE TABLE Person (
	idPerson SERIAL PRIMARY KEY, 
	email VARCHAR(255) NOT NULL UNIQUE,
	fax INTEGER,
	address VARCHAR(255) NOT NULL,
	ban VARCHAR(255) NOT NULL, /*bank account number*/
	fin VARCHAR(255) NOT NULL, /*fiscal identification number*/
	name VARCHAR(255) NOT NULL UNIQUE,
	telephone INTEGER NOT NULL UNIQUE
);

CREATE TABLE Supplier (
	idPerson SERIAL PRIMARY KEY REFERENCES Person(idPerson)
);

CREATE TABLE Client (
	idPerson SERIAL PRIMARY KEY REFERENCES Person(idPerson)
);

CREATE TABLE Userino (
	idPerson SERIAL PRIMARY KEY,
	photograph VARCHAR(255) NOT NULL,
	password VARCHAR(20) NOT NULL,
	salary MONEY NOT NULL,
	userName VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Manager (
	idPerson SERIAL PRIMARY KEY REFERENCES Userino(idPerson) 
	);

CREATE TABLE PoSOperator (
	idPerson SERIAL PRIMARY KEY REFERENCES Userino(idPerson)
);

CREATE TABLE ShopKeeper (
	idPerson SERIAL PRIMARY KEY REFERENCES Userino(idPerson) 
);

CREATE TABLE Report (
	idReport SERIAL PRIMARY KEY,
	content VARCHAR(2000) NOT NULL,
	completionDate TIMESTAMP NOT NULL,
	name VARCHAR(100) NOT NULL,
	idPerson INTEGER NOT NULL REFERENCES PoSOperator(idPerson),
	type reportType NOT NULL
);

CREATE TABLE Building (
	idBuilding SERIAL PRIMARY KEY,
	zipCode zip_code NOT NULL,
	address VARCHAR(255) NOT NULL UNIQUE,
	idPerson SERIAL NOT NULL UNIQUE REFERENCES PoSOperator(idPerson) 
);

CREATE TABLE Storage (
	idBuilding SERIAL PRIMARY KEY REFERENCES Building(idBuilding) 
);

CREATE TABLE PointOfSale (
	idBuilding SERIAL PRIMARY KEY REFERENCES Building(idBuilding) 
);

CREATE TABLE Quantity (
	idBuilding SERIAL,
	idProduct SERIAL,
	quantity INTEGER NOT NULL,
	PRIMARY KEY (idBuilding, idProduct)
);

CREATE TABLE Product (
	idProduct SERIAL PRIMARY KEY,
	category VARCHAR(20) NOT NULL,
	expirationDate TIMESTAMP NOT NULL,
	description VARCHAR(255),
	photograph VARCHAR(255) NOT NULL,
	name VARCHAR(20) NOT NULL,
	price MONEY NOT NULL
);

CREATE TABLE Transaction (
	idTransaction SERIAL PRIMARY KEY,
	value MONEY,
	idPointOfSale SERIAL NOT NULL REFERENCES PointOfSale(idBuilding) 
);

CREATE TABLE SupplierCompany (
	idTransaction SERIAL PRIMARY KEY REFERENCES Transaction(idTransaction), 
	idPerson SERIAL NOT NULL  REFERENCES Supplier(idPerson) 

);

CREATE TABLE Orderino (
	idOrder SERIAL PRIMARY KEY,
	orderDate TIMESTAMP NOT NULL,
	paymentDate TIMESTAMP NOT NULL CHECK (paymentDate>=orderDate),
	deliveryDate TIMESTAMP NOT NULL CHECK (deliveryDate>=paymentDate),
	idSupplierCompany SERIAL NOT NULL UNIQUE REFERENCES SupplierCompany(idTransaction) 
);

CREATE TABLE ProductOrder ( 
	idProduct SERIAL REFERENCES Product(idProduct),
	idOrder SERIAL REFERENCES Orderino(idOrder),
	quantity Integer, 
	PRIMARY KEY (idProduct, idOrder)
);

CREATE TABLE ShopKeeperPointOfSale (
	idPerson SERIAL REFERENCES ShopKeeper(idPerson), 
	idBuilding SERIAL REFERENCES Building(idBuilding), 
	PRIMARY KEY (idPerson, idBuilding)
);

CREATE TABLE ProductBuilding (
	idBuilding SERIAL REFERENCES Building(idBuilding),
	idProduct SERIAL REFERENCES Product(idProduct), 
	PRIMARY KEY (idBuilding, idProduct)
);

CREATE INDEX price_indx ON Product(price);


CLUSTER Product USING price_indx;