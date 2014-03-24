/* sourceforge.net/projects/spawnner */

/* CRIAR TRIGGER PASSWORD */

DROP TABLE Person IF EXISTS;
DROP TABLE Client IF EXISTS;
DROP TABLE Supplier IF EXISTS;
DROP TABLE User IF EXISTS;
DROP TABLE Manager IF EXISTS;
DROP TABLE PoSOperator IF EXISTS;
DROP TABLE ShopKeeper IF EXISTS;
DROP TABLE Report IF EXISTS;
DROP TABLE Delivery IF EXISTS;
DROP TABLE Deposit IF EXISTS;
DROP TABLE Sales IF EXISTS;
DROP TABLE Building IF EXISTS;
DROP TABLE Storage IF EXISTS;
DROP TABLE PointOfSale IF EXISTS;
DROP TABLE Product IF EXISTS;
DROP TABLE Transaction IF EXISTS;
DROP TABLE CompanyCliente IF EXISTS;
DROP TABLE SupplierCompany IF EXISTS;
DROP TABLE Order IF EXISTS;
DROP TABLE Quantity IF EXISTS;
DROP TABLE ProductOrder IF EXISTS;
DROP TABLE ShopKeeperPointOfSale IF EXISTS;
DROP TABLE ProductBuilding IF EXISTS;

CREATE TABLE Person (
	idPerson PRIMARY KEY,
	email VARCHAR(255) NOT NULL UNIQUE,
	fax VARCHAR(255),
	address VARCHAR(255) NOT NULL,
	ban BIGINT NOT NULL, /*bank account number*/
	fin BIGINT NOT NULL, /*fiscal identification number*/
	name VARCHAR(255) NOT NULL UNIQUE,
	telephone INTEGER NOT NULL UNIQUE
);

CREATE TABLE Supplier (
	idPerson PRIMARY KEY REFERENCES Person(idPerson)
);

CREATE TABLE Client (
	idPerson PRIMARY KEY REFERENCES Person(idPerson)
);

CREATE TABLE User (
	idPerson PRIMARY KEY,
	photograph BYTEA NOT NULL,
	password VARCHAR(20) NOT NULL,
	salary MONEY NOT NULL,
	userName VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Manager (
	idPerson PRIMARY KEY REFERENCES User(idPerson)
);

CREATE TABLE PoSOperator (
	idPerson PRIMARY KEY REFERENCES User(idPerson)
);

CREATE TABLE ShopKeeper (
	idPerson PRIMARY KEY REFERENCES User(idPerson)
);

CREATE TABLE Report (
	idReport SERIAL PRIMARY KEY,
	content VARCHAR(2000) NOT NULL,
	completionDate TIMESTAMPZ NOT NULL,
	name VARCHAR(20) NOT NULL UNIQUE,
	idPerson NOT NULL UNIQUE REFERENCES PoSOperator(idPerson)
);

CREATE TABLE Building (
	idBuilding SERIAL PRIMARY KEY,
	zipCode VARCHAR(255) NOT NULL,
	address VARCHAR(255) NOT NULL UNIQUE,
	idPerson NOT NULL UNIQUE REFERENCES PoSOperator(idPerson)
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
	expirationDate TIMESTAMPZ NOT NULL,
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
	idPerson SERIAL UNIQUE NOT NULL Supplier(idPerson)

);

CREATE TABLE Order (
	idOrder SERIAL PRIMARY KEY,
	orderData TIMESTAMPZ NOT NULL,
	paymentDate TIMESTAMPZ NOT NULL,
	deliveryDate TIMESTAMPZ NOT NULL,
	idSupplierCompany SERIAL NOT NULL UNIQUE REFERENCES SupplierCompany(idTransaction)
);

CREATE TABLE ProductOrder ( 
	idProduct SERIAL PRIMARY KEY REFERENCES Product(idProduct),
	idOrder SERIAL PRIMARY KEY REFERENCES Order(idOrder),
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
