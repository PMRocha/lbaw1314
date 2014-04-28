
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

DELETE FROM PERSON WHERE Personid = Person.idPerson

DELETE FROM CLIENT WHERE Personid = Client.idPerson

COMMIT


BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

DELETE FROM PERSON WHERE Personid = Person.idPerson

DELETE FROM SUPPLIER WHERE Personid = Supplier.idPerson

COMMIT


BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

DELETE FROM PERSON WHERE Personid = Person.idPerson

DELETE FROM USERINO WHERE Personid = Userino.idPerson

DELETE FROM MANAGER WHERE Personid = Manager.idPerson

COMMIT


BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

DELETE FROM PERSON WHERE Personid = Person.idPerson

DELETE FROM USERINO WHERE Personid = Userino.idPerson

DELETE FROM PoSOperator WHERE Personid = PoSOperator.idPerson

COMMIT


BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

DELETE FROM PERSON WHERE Personid = Person.idPerson

DELETE FROM USERINO WHERE Personid = Userino.idPerson

DELETE FROM Shopkeeper WHERE Personid = Shopkeeper.idPerson

COMMIT


DELERE FROM Report WHERE ReportId = Report.idReport


BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

DELETE FROM Building WHERE Buildingid = Building.idBuilding

DELETE FROM Storage WHERE Buildingid = Storage.idBuilding

COMMIT



BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

DELETE FROM Building WHERE Buildingid = Building.idBuilding

DELETE FROM PointOfSale WHERE Buildingid = PointOfSale.idBuilding

COMMIT


BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE

DELETE FROM Product WHERE ProductId = Product.idProduct

DELETE FROM Quantity WHERE ProductId = Quantity.idProduct

DELETE FROM ProductBuilding WHERE ProductId = ProductBuilding.idProduct

COMMIT


BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE

DELETE FROM Quantity WHERE ProductId = Quantity.idProduct AND BuildingId = Quantity.idBuilding

DELETE FROM ProductBuilding WHERE ProductId = ProductBuilding.idProduct AND BuildingId = Quantity.idBuilding

COMMIT