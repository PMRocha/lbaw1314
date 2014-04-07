SELECT * from Person WHERE idPerson=:idPerson;
SELECT * from Person WHERE name=:name;
SELECT * from Client INNER JOIN Person ON (Client.idPerson = Person.idPerson) WHERE Client.idPerson=:idPerson;
SELECT * from Client INNER JOIN Person ON (Client.idPerson = Person.idPerson) WHERE Person.name=:name;
SELECT * from Supplier INNER JOIN Person ON (Supplier.idPerson = Person.idPerson) WHERE Supplier.idPerson=:idPerson;
SELECT * from Supplier INNER JOIN Person ON (Supplier.idPerson = Person.idPerson) WHERE Person.name=:name;
SELECT * from Userino INNER JOIN Person ON (Userino .idPerson = Person.idPerson) WHERE Userino.idPerson=:idPerson;
SELECT * from Userino INNER JOIN Person ON (Userino.idPerson = Person.idPerson) WHERE Person.name=:name;
SELECT * from Manager INNER JOIN Person ON (Manager.idPerson = Person.idPerson);
SELECT * from PoSOperator  INNER JOIN Userino ON (PoSOperator.idPerson = Userino.idPerson) INNER JOIN Person ON (Userino.idPerson = Person.idPerson) WHERE PoSOperator.idPerson=:idPerson;
SELECT * from PoSOperator  INNER JOIN Userino ON (PoSOperator.idPerson = Userino.idPerson) INNER JOIN Person ON (Userino.idPerson = Person.idPerson) WHERE Userino.userName=:userName;
SELECT * from ShopKeeper  INNER JOIN Userino ON (ShopKeeper.idPerson = Userino.idPerson) INNER JOIN Person ON (Userino.idPerson = Person.idPerson) WHERE ShopKeeper.idPerson=:idPerson;
SELECT * from ShopKeeper  INNER JOIN Userino ON (ShopKeeper.idPerson = Userino.idPerson) INNER JOIN Person ON (Userino.idPerson = Person.idPerson) WHERE Userino.userName=:userName;
SELECT * from Report WHERE idReport=:idReport;
SELECT * from Building WHERE idBuilding=:idBuilding;
SELECT * from Storage INNER JOIN Building ON (Storage.idBuilding= Building.idBuilding) WHERE Building.idBuilding=:idBuilding;
SELECT * from PointOfSale INNER JOIN Building ON (PointOfSale.idBuilding= Building.idBuilding) WHERE Building.idBuilding=:idBuilding;
SELECT * from Product WHERE name=:name;
SELECT * from Product WHERE price=:price;
SELECT * from Product WHERE expirationDate=:expirationDate;
SELECT * from Product WHERE idProduct=:idProduct;
SELECT * from Transaction;
SELECT * from SupplierCompany;
SELECT * from Orderino WHERE orderDate=:orderDate;
SELECT * from Orderino WHERE paymentDate=:paymentDate;
SELECT * from Orderino WHERE deliveryDate=:deliveryDate;
SELECT * from ProductOrder LEFT JOIN Orderino ON (ProductOrder.idOrder= Orderino.idOrder)LEFT JOIN Product ON (ProductOrder.idProduct= Product.idProduct);
SELECT * from ProductBuilding LEFT JOIN Building ON (Building.idBuilding= ProductBuilding.idBuilding)LEFT JOIN Product ON (ProductBuilding.idProduct= Product.idProduct);
SELECT * from ShopkeeperPointOfSale LEFT JOIN Shopkeeper ON (Shopkeeper.idPerson= ShopkeeperPointOfSale.idPerson)INNER JOIN Userino ON (ShopKeeper.idPerson = Userino.idPerson) INNER JOIN Person ON (Userino.idPerson = Person.idPerson) LEFT JOIN PointOfSale ON (PointOfSale.idBuilding= ShopkeeperPointOfSale.idBuilding) INNER JOIN Building ON (PointOfSale.idBuilding= Building.idBuilding);
SELECT * from Quantity;

SELECT name,ban,fin,telephone from Client INNER JOIN Person ON (Client.idPerson = Person.idPerson) WHERE Person.name=:name;
SELECT name,ban,fin,telephone from Supplier INNER JOIN Person ON (Supplier.idPerson = Person.idPerson) WHERE Person.name=:name;

SELECT userName, photograph, salary from Userino WHERE userName=:userName;
SELECT userName, photograph, salary from Userino WHERE photograph=:photograph;
SELECT userName, photograph, salary from Userino WHERE salary=:salary;
SELECT userName, photograph, salary from PoSOperator WHERE userName=:userName;
SELECT userName, photograph, salary from PoSOperator WHERE photograph=:photograph;
SELECT userName, photograph, salary from PoSOperator WHERE salary=:salary;
SELECT userName, photograph, salary from ShopKeeper WHERE userName=:userName;
SELECT userName, photograph, salary from ShopKeeper WHERE photograph=:photograph;
SELECT userName, photograph, salary from ShopKeeper WHERE salary=:salary;
SELECT name, content from Report WHERE name=:name;
SELECT zipCode,address from Building WHERE address=:address;
SELECT zipCode,address from Storage WHERE address=:address;
SELECT zipCode,address from PointOfSale WHERE address=:address;
SELECT name, price from Product WHERE name=:name;
SELECT name, price from Product WHERE price=:price;
SELECT expirationDate,description from Product WHERE expirationDate=:expirationDate;
SELECT photograph,name,category,idProduct from Product WHERE idProduct=:idProduct;
SELECT orderDate,paymentDate,deliveryDate from Orderino WHERE orderDate=:orderDate;
SELECT orderDate,paymentDate,deliveryDate from Orderino WHERE paymentDate=:paymentDate;
SELECT orderDate,paymentDate,deliveryDate from Orderino WHERE deliveryDate=:deliveryDate;