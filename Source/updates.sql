UPDATE Person SET email = :email WHERE idPerson = :idPerson; --editar o email da pessoa

UPDATE Person SET fax = :fax WHERE idPerson = :idPerson; --editar o fax da pessoa

UPDATE Person SET address = :address WHERE idPerson = :idPerson; --editar a morada da pessoa

UPDATE Person SET ban = :ban WHERE idPerson = :idPerson; --editar o numero de conta da pessoa

UPDATE Person SET telephone = :telephone WHERE idPerson = :idPerson; --editar o telefone da pessoa

SET TRANSACTION SERIALIZABLE;
BEGIN TRANSACTION;
UPDATE Person SET email = :email WHERE idPerson = :idPerson; --editar o email da pessoa

UPDATE Person SET fax = :fax WHERE idPerson = :idPerson; --editar o fax da pessoa

UPDATE Person SET address = :address WHERE idPerson = :idPerson; --editar a morada da pessoa

UPDATE Person SET ban = :ban WHERE idPerson = :idPerson; --editar o numero de conta da pessoa

UPDATE Person SET telephone = :telephone WHERE idPerson = :idPerson; --editar o telefone da pessoa
COMMIT;

UPDATE Userino SET password = :password WHERE idPerson = :idPerson; --editar a passwod do user

UPDATE Userino SET photograph = :photograph WHERE idPerson = :idPerson; --editar a fotografia do user

UPDATE Userino SET salary = :salary WHERE idPerson = :idPerson; --editar o salario do user

SET TRANSACTION SERIALIZABLE;
BEGIN TRANSACTION;
UPDATE Userino SET password = :password WHERE idPerson = :idPerson; --editar a passwod do user

UPDATE Userino SET photograph = :photograph WHERE idPerson = :idPerson; --editar a fotografia do user

UPDATE Userino SET salary = :salary WHERE idPerson = :idPerson; --editar o salario do user
COMMIT;

UPDATE Building SET address = :address WHERE idBuilding= :idBuilding; --editar a morada do edificio

UPDATE Building SET zipCode = :zipCode WHERE idBuilding= :idBuilding; --editar o codigo postal do edificio

SET TRANSACTION SERIALIZABLE;
BEGIN TRANSACTION;
UPDATE Building SET address = :address WHERE idBuilding= :idBuilding; --editar a morada do edificio

UPDATE Building SET zipCode = :zipCode WHERE idBuilding= :idBuilding; --editar o codigo postal do edificio
COMMIT;

UPDATE Building SET idPerson = :idPerson WHERE idBuilding= :idBuilding; --editar o operador de um edificio

UPDATE Quantity SET quantity = :quantity WHERE idBuilding = :idBuilding AND idProduct = : Product; --editar a quantidade de um produto num edificio

UPDATE Product SET price = :price WHERE idProduct = :idProduct; --editar o preço de um produto

UPDATE Orderino SET deliveryDate = : deliveryDate WHERE idOrder = :idOrder; --editar a data de entrega de uma encomenda

INSERT INTO Supplier (name, email, address, ban, fin, telephone, fax) VALUES (:name, :email, :address, :ban, :fin, :telephone, :fax);

INSERT INTO Supplier (name, email, address, ban, fin, telephone) VALUES (:name, :email, :address, :ban, :fin, :telephone);

INSERT INTO Client (name, email, address, ban, fin, telephone, fax) VALUES (:name, :email, :address, :ban, :fin, :telephone, :fax);

INSERT INTO Client (name, email, address, ban, fin, telephone) VALUES (:name, :email, :address, :ban, :fin, :telephone);

INSERT INTO Manager (name, email, address, ban, fin, telephone, fax, photograph, password, salary, userName) VALUES (:name, :email, :address, :ban, :fin, :telephone, :fax, :photgraph, :password, :salary, :userName);

INSERT INTO Manager (name, email, address, ban, fin, telephone, photograph, password, salary, userName) VALUES (:name, :email, :address, :ban, :fin, :telephone, :photgraph, :password, :salary, :userName);

INSERT INTO PoSOperator (name, email, address, ban, fin, telephone, fax, photograph, password, salary, userName) VALUES (:name, :email, :address, :ban, :fin, :telephone, :fax, :photgraph, :password, :salary, :userName);

INSERT INTO PoSOperator (name, email, address, ban, fin, telephone, photograph, password, salary, userName) VALUES (:name, :email, :address, :ban, :fin, :telephone, :photgraph, :password, :salary, :userName);

INSERT INTO ShopKeeer (name, email, address, ban, fin, telephone, fax, photograph, password, salary, userName) VALUES (:name, :email, :address, :ban, :fin, :telephone, :fax, :photgraph, :password, :salary, :userName);

INSERT INTO ShopKeeer (name, email, address, ban, fin, telephone, photograph, password, salary, userName) VALUES (:name, :email, :address, :ban, :fin, :telephone, :photgraph, :password, :salary, :userName);

INSERT INTO Report (name,completionDate, content, idPerson, type) VALUES (:name, :completionDate, :content, :idPerson, :type);

INSERT INTO Storage (zipCode, address, idPerson) VALUES (:zipCode, :address, :idPerson);

INSERT INTO PointOfSale (zipCode, address, idPerson) VALUES (:zipCode, :address, :idPerson);

INSERT INTO Quantity (idBuilding, idProduct, quantity) VALUES (:idBuilding, :idProduct, :quantity);

INSERT INTO Product (name, price, expirationDate, category, photograph, description) VALUES (:name, :price, :expirationDate, :category, :photograph, :description);

INSERT INTO Product (name, price, expirationDate, category, photograph) VALUES (:name, :price, :expirationDate, :category, :photograph);

INSERT INTO Transaction (value, idPointOfSale) VALUES (:values, :idPointOfSale);

INSERT INTO SupplierCompany (idTransaction, idPerson) VALUES (:idTransaction, :idPerson);

INSERT INTO Orderino (orderDate, paymentDate, deliveryDate, idSupplierCompany) VALUES (:orderDate, :paymentDate, :deliveryDate, :idSupplierCompany);

INSERT INTO ProductOrder (idProduct, idOrder, quantity) VALUES (:idProduct, :idOrder, :quantity);

INSERT INTO ShopKeeperPintOfSale (idPerson, idBuilding) VALUES (:idPerson, :idBuilding);

INSERT INTO ProductBuilding (idBuilding, idProduct) VALUES (:idBuilding, idProduct)