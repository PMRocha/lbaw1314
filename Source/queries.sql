SELECT idPerson,name FROM Person ORDER BY idPerson; 

SELECT * FROM Person WHERE name='ZE'; 

SELECT * FROM Person WHERE email='andre@ze.com'

SELECT * FROM Person WHERE telephone=23659845658;

SELECT * FROM Person WHERE idPerson=23;

SELECT idPerson,name FROM Person INNER JOIN Supplier ON (Supplier.idPerson = Person.idPerson) ORDER BY idPerson;

SELECT * FROM Person INNER JOIN Supplier ON (Supplier.idPerson = Person.idPerson) WHERE name='ZE';

SELECT * FROM Person INNER JOIN Supplier ON (Supplier.idPerson = Person.idPerson) email='andre@ze.com'

SELECT * FROM Person INNER JOIN Supplier ON (Supplier.idPerson = Person.idPerson) telephone=23659845658;

SELECT * FROM Person INNER JOIN Supplier ON (Supplier.idPerson = Person.idPerson) idPerson=23;

SELECT idPerson,name FROM Person INNER JOIN Client ON (Client.idPerson = Person.idPerson) ORDER BY idPerson;

SELECT * FROM Person INNER JOIN Client ON (Client.idPerson = Person.idPerson) WHERE name='ZE';

SELECT * FROM Person INNER JOIN Client ON (Client.idPerson = Person.idPerson) email='andre@ze.com'

SELECT * FROM Person INNER JOIN Client ON (Client.idPerson = Person.idPerson) telephone=23659845658;

SELECT * FROM Person INNER JOIN Client ON (Client.idPerson = Person.idPerson) idPerson=23;

SELECT idPerson,name,userName FROM Person,Userino INNER JOIN Userino ON (Userino.idPerson = Person.idPerson) ORDER BY idPerson;

SELECT * FROM Person,Userino INNER JOIN Userino ON (Userino.idPerson = Person.idPerson) WHERE name='ZE';

SELECT * FROM Person,Userino INNER JOIN Userino ON (Userino.idPerson = Person.idPerson) WHERE userName='ZE';

SELECT * FROM Person,Userino INNER JOIN Userino ON (Userino.idPerson = Person.idPerson) WHERE email='andre@ze.com'

SELECT * FROM Person,Userino INNER JOIN Userino ON (Userino.idPerson = Person.idPerson) WHERE telephone=23659845658;

SELECT * FROM Person,Userino INNER JOIN Userino ON (Userino.idPerson = Person.idPerson) WHERE idPerson=23;

SELECT idPerson,name,userName  FROM Person,Userino INNER JOIN Manager ON (Manager.idPerson = Person.idPerson) ORDER BY idPerson;

SELECT * FROM Person,Userino INNER JOIN Manager ON (Manager.idPerson = Person.idPerson) WHERE name='ZE';

SELECT * FROM Person,Userino INNER JOIN Manager ON (Manager.idPerson = Person.idPerson) WHERE userName='ZE';

SELECT * FROM Person,Userino INNER JOIN Manager ON (Manager.idPerson = Person.idPerson) WHERE email='andre@ze.com'

SELECT * FROM Person,Userino INNER JOIN Manager ON (Manager.idPerson = Person.idPerson) WHERE telephone=23659845658;

SELECT * FROM Person,Userino INNER JOIN Manager ON (Manager.idPerson = Person.idPerson) WHERE idPerson=23;

SELECT idPerson,name,userName  FROM Person,Userino INNER JOIN PoSManager ON (PoSManager.idPerson = Person.idPerson) ORDER BY idPerson;

SELECT * FROM Person,Userino INNER JOIN PoSManager ON (PoSManager.idPerson = Person.idPerson) WHERE name='ZE';

SELECT * FROM Person,Userino INNER JOIN PoSManager ON (PoSManager.idPerson = Person.idPerson) WHERE userName='ZE';

SELECT * FROM Person,Userino INNER JOIN PoSManager ON (PoSManager.idPerson = Person.idPerson) WHERE email='andre@ze.com'

SELECT * FROM Person,Userino INNER JOIN PoSManager ON (PoSManager.idPerson = Person.idPerson) WHERE telephone=23659845658;

SELECT * FROM Person,Userino INNER JOIN PoSManager ON (PoSManager.idPerson = Person.idPerson) WHERE idPerson=23;

SELECT idPerson,name,userName  FROM Person,Userino INNER JOIN ShopKeeper ON (Manager.idPerson = Person.idPerson) ORDER BY idPerson;

SELECT * FROM Person,Userino INNER JOIN ShopKeeper ON (ShopKeeper.idPerson = Person.idPerson) WHERE name='ZE';

SELECT * FROM Person,Userino INNER JOIN ShopKeeper ON (ShopKeeper.idPerson = Person.idPerson) WHERE userName='ZE';

SELECT * FROM Person,Userino INNER JOIN ShopKeeper ON (ShopKeeper.idPerson = Person.idPerson) WHERE email='andre@ze.com'

SELECT * FROM Person,Userino INNER JOIN ShopKeeper ON (ShopKeeper.idPerson = Person.idPerson) WHERE telephone=23659845658;

SELECT * FROM Person,Userino INNER JOIN ShopKeeper ON (ShopKeeper.idPerson = Person.idPerson) WHERE idPerson=23;

SELECT idReport,name FROM Report ORDER BY idReport;

SELECT * FROM Report WHERE idReport=3;

SELECT idBuilding, address FROM Building ORDER BY idBuilding;

SELECT * FROM Building WHERE address='hjudoffsaouhffwawouwa';

SELECT * FROM Building WHERE ibBuilding=6;

SELECT idBuilding, address FROM Building INNER JOIN PointOfSale (Building.idBuilding = PointOfSale.idBuilding) ORDER BY idBuilding;

SELECT * FROM Building INNER JOIN PointOfSale (Building.idBuilding = PointOfSale.idBuilding) WHERE address='hjudoffsaouhffwawouwa';

SELECT * FROM Building INNER JOIN PointOfSale (Building.idBuilding = PointOfSale.idBuilding) WHERE ibBuilding=6;

SELECT idBuilding, address FROM Building INNER JOIN Storage (Storage.idBuilding = Building.idBuilding) ORDER BY idBuilding;

SELECT * FROM Building INNER JOIN Storage (Storage.idBuilding = Building.idBuilding) WHERE address='hjudoffsaouhffwawouwa';

SELECT * FROM Building INNER JOIN Storage (Storage.idBuilding = Building.idBuildingg) WHERE ibBuilding=6;