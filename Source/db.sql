/* sourceforge.net/projects/spawnner */

/* CRIAR TRIGGER PASSWORD */

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

CREATE DOMAIN zip_code AS TEXT
CHECK(
    VALUE ~ '^\\d{5}-\\d{3}$, '
);

CREATE DOMAIN type AS TEXT
CHECK(
    VALUE ~ 'Delivery'
    OR VALUE ~ 'Sales'
    OR VALUE ~ 'Deposit'
);

CREATE DOMAIN workday AS TEXT
CHECK(
     VALUE ~ 'Monday'
     OR VALUE ~ 'Tuesday'
     OR VALUE ~ 'Wednesday'
     OR VALUE ~ 'Thursday'
     OR VALUE ~ 'Friday'
);

CREATE DOMAIN weekday AS TEXT
CHECK(
     VALUE ~ 'Monday'
     OR VALUE ~ 'Tuesday'
     OR VALUE ~ 'Wednesday'
     OR VALUE ~ 'Thursday'
     OR VALUE ~ 'Friday'
     OR VALUE ~ 'Saturday'
);

CREATE TABLE Person (
	idPerson SERIAL PRIMARY KEY, 
	email VARCHAR(255) NOT NULL UNIQUE,
	fax VARCHAR(255),
	address VARCHAR(255) NOT NULL,
	ban BIGINT NOT NULL, /*bank account number*/
	fin BIGINT NOT NULL, /*fiscal identification number*/
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
	photograph BYTEA NOT NULL,
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
	name VARCHAR(20) NOT NULL UNIQUE,
	idPerson SERIAL NOT NULL UNIQUE REFERENCES PoSOperator(idPerson) 
);

CREATE TABLE Building (
	idBuilding SERIAL PRIMARY KEY,
	zipCode VARCHAR(255) NOT NULL,
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
	photograph BYTEA NOT NULL UNIQUE,
	name VARCHAR(20) NOT NULL,
	price MONEY NOT NULL
);

CREATE TABLE Transaction (
	idTransaction SERIAL PRIMARY KEY,
	value MONEY,
	idPointOfSale SERIAL NOT NULL UNIQUE REFERENCES PointOfSale(idBuilding) 
);

CREATE TABLE SupplierCompany (
	idTransaction SERIAL PRIMARY KEY REFERENCES Transaction(idTransaction), 
	idPerson SERIAL UNIQUE NOT NULL  REFERENCES Supplier(idPerson) 

);

CREATE TABLE Orderino (
	idOrder SERIAL PRIMARY KEY,
	orderData TIMESTAMP NOT NULL,
	paymentDate TIMESTAMP NOT NULL,
	deliveryDate TIMESTAMP NOT NULL,
	idSupplierCompany SERIAL NOT NULL UNIQUE REFERENCES SupplierCompany(idTransaction) 
);

CREATE TABLE ProductOrder ( 
	idProduct SERIAL REFERENCES Product(idProduct),
	idOrder SERIAL REFERENCES Orderino(idOrder), 
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
