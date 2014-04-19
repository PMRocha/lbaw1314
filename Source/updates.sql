UPDATE Person SET email = :email WHERE idPerson = :idPerson; 

UPDATE Person SET fax = :fax WHERE idPerson = :idPerson; 

UPDATE Person SET address = :address WHERE idPerson = :idPerson; 

UPDATE Person SET ban = :ban WHERE idPerson = :idPerson; 

UPDATE Person SET telephone = :telephone WHERE idPerson = :idPerson; 



BEGIN TRANSACTION ISOLATION LEVEL READ SERIALIZABLE;

UPDATE Person SET email = :email WHERE idPerson = :idPerson; 

UPDATE Person SET fax = :fax WHERE idPerson = :idPerson; 

UPDATE Person SET address = :address WHERE idPerson = :idPerson; 

UPDATE Person SET ban = :ban WHERE idPerson = :idPerson; 

UPDATE Person SET telephone = :telephone WHERE idPerson = :idPerson; 
COMMIT;


BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE Person SET email = :email WHERE idPerson = :idPerson; 

UPDATE Person SET fax = :fax WHERE idPerson = :idPerson; 

UPDATE Person SET address = :address WHERE idPerson = :idPerson; 

UPDATE Person SET ban = :ban WHERE idPerson = :idPerson; 

UPDATE Person SET telephone = :telephone WHERE idPerson = :idPerson; 

UPDATE Userino SET password = :password WHERE idPerson = :idPerson; 

UPDATE Userino SET photograph = :photograph WHERE idPerson = :idPerson;

UPDATE Userino SET salary = :salary WHERE idPerson = :idPerson; 

COMMIT;


UPDATE Userino SET password = :password WHERE idPerson = :idPerson; 

UPDATE Userino SET photograph = :photograph WHERE idPerson = :idPerson;

UPDATE Userino SET salary = :salary WHERE idPerson = :idPerson;



UPDATE Building SET address = :address WHERE idBuilding= :idBuilding; 

UPDATE Building SET zipCode = :zipCode WHERE idBuilding= :idBuilding; 

UPDATE Building SET idPerson = :idPerson WHERE idBuilding= :idBuilding; 


BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE Building SET address = :address WHERE idBuilding= :idBuilding; 

UPDATE Building SET zipCode = :zipCode WHERE idBuilding= :idBuilding;

UPDATE Building SET idPerson = :idPerson WHERE idBuilding= :idBuilding; 

COMMIT;


UPDATE Quantity SET quantity = :quantity WHERE idBuilding = :idBuilding AND idProduct = : Product; 

UPDATE Product SET price = :price WHERE idProduct = :idProduct; 

UPDATE Orderino SET deliveryDate = : deliveryDate WHERE idOrder = :idOrder; 



BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Person (name, email, address, ban, fin, telephone, fax) VALUES (:name, :email, :address, :ban, :fin, :telephone, :fax);
INSERT INTO Supplier SELECT idPerson FROM Person WHERE name = :name;

COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Person (name, email, address, ban, fin, telephone) VALUES (:name, :email, :address, :ban, :fin, :telephone);
INSERT INTO Supplier SELECT idPerson FROM Person WHERE name = :name;

COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Person (name, email, address, ban, fin, telephone, fax) VALUES (:name, :email, :address, :ban, :fin, :telephone, :fax);
INSERT INTO Client SELECT idPerson FROM Person WHERE name = :name;

COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Person (name, email, address, ban, fin, telephone) VALUES (:name, :email, :address, :ban, :fin, :telephone);
INSERT INTO Client SELECT idPerson FROM Person WHERE name = :name;

COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Person (name, email, address, ban, fin, telephone, fax) VALUES (:name, :email, :address, :ban, :fin, :telephone, :fax);

INSERT INTO Userino(idPerson,photograph, password, salary, userName)
SELECT  idPerson ,:photgraph, :password, :salary, :userName
FROM    Person 
WHERE   name = :name;

INSERT INTO Manager SELECT idPerson FROM Person WHERE name = :name;

COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Person (name, email, address, ban, fin, telephone) VALUES (:name, :email, :address, :ban, :fin, :telephone);

INSERT INTO Userino(idPerson,photograph, password, salary, userName)
SELECT  idPerson ,:photgraph, :password, :salary, :userName
FROM    Person 
WHERE   name = :name;

INSERT INTO Manager SELECT idPerson FROM Person WHERE name = :name;

COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Person (name, email, address, ban, fin, telephone, fax) VALUES (:name, :email, :address, :ban, :fin, :telephone, :fax);

INSERT INTO Userino(idPerson,photograph, password, salary, userName)
SELECT  idPerson ,:photgraph, :password, :salary, :userName
FROM    Person 
WHERE   name = :name;

INSERT INTO PoSOperator SELECT idPerson FROM Person WHERE name = :name;

COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Person (name, email, address, ban, fin, telephone) VALUES (:name, :email, :address, :ban, :fin, :telephone);

INSERT INTO Userino(idPerson,photograph, password, salary, userName)
SELECT  idPerson ,:photgraph, :password, :salary, :userName
FROM    Person 
WHERE   name = :name;

INSERT INTO PoSOperator SELECT idPerson FROM Person WHERE name = :name;

COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Person (name, email, address, ban, fin, telephone, fax) VALUES (:name, :email, :address, :ban, :fin, :telephone, :fax);

INSERT INTO Userino(idPerson,photograph, password, salary, userName)
SELECT  idPerson ,:photgraph, :password, :salary, :userName
FROM    Person 
WHERE   name = :name;

INSERT INTO ShopKeeer SELECT idPerson FROM Person WHERE name = :name;

COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Person (name, email, address, ban, fin, telephone) VALUES (:name, :email, :address, :ban, :fin, :telephone);

INSERT INTO Userino(idPerson,photograph, password, salary, userName)
SELECT  idPerson ,:photgraph, :password, :salary, :userName
FROM    Person 
WHERE   name = :name;

INSERT INTO ShopKeeer SELECT idPerson FROM Person WHERE name = :name;

COMMIT;

INSERT INTO Report (name,completionDate, content, idPerson, type) VALUES (:name, :completionDate, :content, :idPerson, :type);

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Building (zipCode, address, idPerson) VALUES (:zipCode, :address, :idPerson);
INSERT INTO Storage SELECT idBuilding FROM Building WHERE address = :address;

COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Building (zipCode, address, idPerson) VALUES (:zipCode, :address, :idPerson);
INSERT INTO PointOfSale SELECT idBuilding FROM Building WHERE address = :address;

COMMIT;


BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Building (zipCode, address, idPerson) VALUES (:zipCode, :address, :idPerson);
INSERT INTO PointOfSale SELECT idBuilding FROM Building WHERE address = :address;
INSERT INTO ShopKeeperPintOfSale (idPerson, idBuilding) VALUES (:idPerson, :idBuilding);

COMMIT;


BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Product (name, price, expirationDate, category, photograph, description) VALUES (:name, :price, :expirationDate, :category, :photograph, :description);
INSERT INTO ProductBuilding (idBuilding, idProduct) VALUES (:idBuilding, idProduct);
INSERT INTO Quantity (idBuilding, idProduct, quantity) VALUES (:idBuilding, :idProduct, :quantity);

COMMIT;


BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Product (name, price, expirationDate, category, photograph) VALUES (:name, :price, :expirationDate, :category, :photograph);
INSERT INTO ProductBuilding (idBuilding, idProduct) VALUES (:idBuilding, idProduct);
INSERT INTO Quantity (idBuilding, idProduct, quantity) VALUES (:idBuilding, :idProduct, :quantity);

COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO ProductBuilding (idBuilding, idProduct) VALUES (:idBuilding, idProduct);
INSERT INTO Quantity (idBuilding, idProduct, quantity) VALUES (:idBuilding, :idProduct, :quantity);

COMMIT;

INSERT INTO Transaction (value, idPointOfSale) VALUES (:values, :idPointOfSale);

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Transaction (value, idPointOfSale) VALUES (:values, :idPointOfSale);

INSERT INTO SupplierCompany(idTransaction, idPerson)
SELECT  idTransaction, :idPerson
FROM    Transaction 
ORDER BY ID DESC LIMIT 1;

COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO Orderino (orderDate, paymentDate, deliveryDate, idSupplierCompany) VALUES (:orderDate, :paymentDate, :deliveryDate, :idSupplierCompany);
INSERT INTO ProductOrder (idProduct, idOrder, quantity) VALUES (:idProduct, :idOrder, :quantity);

COMMIT;

INSERT INTO ShopKeeperPintOfSale (idPerson, idBuilding) VALUES (:idPerson, :idBuilding);