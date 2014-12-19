INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('User','ei11078@fe.up.pt',225558889,'Ap #655-6575 Bibendum Road','BA798618464089064108','515626984','Pedro Rocha',225558889);
INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('User','ei12159@fe.up.pt',215666898,'P.O. Box 629, 2421 Ultricies Road','KZ602673533562147059','261356987','Joao Correia',21566689);
INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('User','ei11111@fe.up.pt',253666897,'464-8198 Donec Rd.','MK66489622376531009','154756983','Armindo Carvalho',253666897);
INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('User','ei11153@fe.up.pt',229690594,'Ap #597-6909 Faucibus Rd.','MU1030923009830851819240699424','123698598','Carlos Matias',229690594);
INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('User','ei12164@fe.up.pt',236598154,'4647 Molestie Ave','IE68YUMH45128536088366','569451236','Jose Pinto',236598154);
INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('User','ei11057@fe.up.pt',216548963,'170-2104 Integer Av.','PK3613814271727813468049','256986333','Jorge Santos',216548963);
INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('User','ei11046@fe.up.pt',226598563,'P.O. Box 278, 2552 Quis St.','AD2078682330920186492103','156897451','Jose Faria',226598563);
INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('User','ei11137@fe.up.pt',216954846,'854-9260 Sed St.','HR6009575559427330990','123654879','Joao Pedro Dias',21568689);
INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('User','ei11147@fe.up.pt',236589417,'9127 Egestas, Avenue','DE51436880151302191706','236598569','Joao Nadais',236589417);
INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('Cliente','jlopes@fe.up.pt',225698745,'671-2815 Nulla. Rd.','GB32RPWI96073574710138','266987456','Joao Correia Lopes',225698745);
INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('Cliente','arestivo@fe.up.pt',226987526,'Ap #598-1151 Nunc Road','IL523426927656039327450','236569874','André Restivo',226987526);
INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('Cliente','ssn@fe.up.pt',223254169,'2373 Facilisis Street','FO1377968374450591','265984325','Sérgio Sobral Nunes',223254169);
INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('Fornecedor','ei11117@fe.up.pt',213555698,'9552 Mauris Avenue','PL55546095125334723990088964','263589478','Joao Soares',213555698);
INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('Fornecedor','ei11051@fe.up.pt',225698595,'Ap #922-4852 Maecenas St.','LU727264973542957759','156987456','Nelson Rafael',225698595);
INSERT INTO Person (ranking,email,fax,address,ban,fin,name,telephone) VALUES ('Fornecedor','ei11086@fe.up.pt',223659874,'7112 Elit. Road','SE4418958080738578505633','659896555','Hugo freixo',223659874);

INSERT INTO Client(idPerson) VALUES (10);
INSERT INTO Client(idPerson) VALUES (11);
INSERT INTO Client(idPerson) VALUES (12);

INSERT INTO Supplier(idPerson) VALUES (13);
INSERT INTO Supplier(idPerson) VALUES (14);
INSERT INTO Supplier(idPerson) VALUES (15);

INSERT INTO Userino (idPerson,photograph,password,salary,userName, position) VALUES (1,'/opt/lbaw/lbaw1344/public_html/final/images/users/teste.png','qwertyuiop','7928.94','pmrocha','Gestor');
INSERT INTO Userino (idPerson,photograph,password,salary,userName, position) VALUES (2,'/opt/lbaw/lbaw1344/public_html/final/images/users/teste.png','qwertyuiop','0879.38','jcorreia','Gestor');
INSERT INTO Userino (idPerson,photograph,password,salary,userName, position) VALUES (3,'/opt/lbaw/lbaw1344/public_html/final/images/users/teste.png','qwertyuiop','0638.72','acarvalho','Gestor');
INSERT INTO Userino (idPerson,photograph,password,salary,userName, position) VALUES (4,'/opt/lbaw/lbaw1344/public_html/final/images/users/teste.png','qwertyuiop','8705.37','cmj','Operador de Ponto de Venda');
INSERT INTO Userino (idPerson,photograph,password,salary,userName, position) VALUES (5,'/opt/lbaw/lbaw1344/public_html/final/images/users/teste.png','qwertyuiop','1919.97','jpinto','Operador de Ponto de Venda');
INSERT INTO Userino (idPerson,photograph,password,salary,userName, position) VALUES (6,'/opt/lbaw/lbaw1344/public_html/final/images/users/teste.png','qwertyuiop','8078.89','jsantos','Administrador');
INSERT INTO Userino (idPerson,photograph,password,salary,userName, position) VALUES (7,'/opt/lbaw/lbaw1344/public_html/final/images/users/teste.png','qwertyuiop','3653.34','jfaria','Operador de Ponto de Venda');
INSERT INTO Userino (idPerson,photograph,password,salary,userName, position) VALUES (8,'/opt/lbaw/lbaw1344/public_html/final/images/users/teste.png','qwertyuiop','6621.38','jpdias','Operador de Ponto de Venda');
INSERT INTO Userino (idPerson,photograph,password,salary,userName, position) VALUES (9,'/opt/lbaw/lbaw1344/public_html/final/images/users/teste.png','qwertyuiop','0281.33','jnadais','Operador de Ponto de Venda');

INSERT INTO Manager (idPerson) VALUES (6);

INSERT INTO PoSOperator (idPerson) VALUES (1);
INSERT INTO PoSOperator (idPerson) VALUES (2);
INSERT INTO PoSOperator (idPerson) VALUES (3);

INSERT INTO ShopKeeper (idPerson) VALUES (4);
INSERT INTO ShopKeeper (idPerson) VALUES (5);
INSERT INTO ShopKeeper (idPerson) VALUES (7);
INSERT INTO ShopKeeper (idPerson) VALUES (8);
INSERT INTO ShopKeeper (idPerson) VALUES (9);

INSERT INTO Report (name, content,completionDate,idPerson,type) VALUES ('Relatório de Entregas #1','Foi recebida uma encomenda consistente em 10 caixas de pimentos, 15 paletes de batatas e 12 caixas de uvas.','2014-04-17 18:21:04',1,'Delivery');
INSERT INTO Report (name, content,completionDate,idPerson,type) VALUES ('Relatório de Depósitos #1','Foram depositados os redimentos do dia que foram contabilizados em 1500.00€','2014-07-19 03:33:05',1,'Deposit');
INSERT INTO Report (name, content,completionDate,idPerson,type) VALUES ('Relatório de Vendas #1','Ao longo do dia foram efetuadas as seguinted vendas: 150 bananas, 100 maçãs, 55 cenouras e 80 pacotes de arroz','2015-02-02 03:45:51',2,'Sales');
INSERT INTO Report (name, content,completionDate,idPerson,type) VALUES ('Relatório de Entregas #2','Foi recebida uma encomenda consistente em 12 caixas de bananas, 32 caixas de maças e 50','2014-07-25 02:27:03',2,'Delivery');
INSERT INTO Report (name, content,completionDate,idPerson,type) VALUES ('Relatório de Vendas #2','','2013-08-14 06:49:35',3,'Sales');

INSERT INTO Building (buildingFunction,zipCode,address,idPerson) VALUES ('Armazém','3050-011,Aveiro','546-1778 Aliquet Rd.',1);
INSERT INTO Building (buildingFunction,zipCode,address,idPerson) VALUES ('Ponto de Venda','4620-525,Braga','P.O. Box 412, 9850 Pharetra. St.',2);
INSERT INTO Building (buildingFunction,zipCode,address,idPerson) VALUES ('Ponto de Venda','5140-202,Braganca','Ap #511-5300 Non Avenue',3);

INSERT INTO Storage (idBuilding) VALUES (1);

INSERT INTO PointOfSale (idBuilding) VALUES (2);
INSERT INTO PointOfSale (idBuilding) VALUES (3);

INSERT INTO Product (category,expirationDate,description,photograph,name,price) VALUES ('fruta','2015-05-06 07:44:01','Côco importado pais de origem: Brasil','/opt/lbaw/lbaw1344/public_html/final/images/products/coconut.jpg','Côco Seco','80.18');
INSERT INTO Product (category,expirationDate,description,photograph,name,price) VALUES ('fruta','2015-10-11 17:13:04','Pêra Rocha nacional','/opt/lbaw/lbaw1344/public_html/final/images/products/pear.jpg','Pêra','63.91');
INSERT INTO Product (category,expirationDate,description,photograph,name,price) VALUES ('fruta','2015-08-03 22:52:32','Ananás Imporatado pais de origem: Mexico','/opt/lbaw/lbaw1344/public_html/final/images/products/pineapple.jpg','Ananás','8.76');
INSERT INTO Product (category,expirationDate,description,photograph,name,price) VALUES ('fruta','2015-12-27 15:08:49','Banana Importada pais de origem: Colombia','/opt/lbaw/lbaw1344/public_html/final/images/products/banana.jpg','Banana','10,881');
INSERT INTO Product (category,expirationDate,description,photograph,name,price) VALUES ('fruta','2015-05-06 10:45:45','Tomate cherry nacional','/opt/lbaw/lbaw1344/public_html/final/images/products/tomatecherry.jpg','Tomate Cherry','29.59');
INSERT INTO Product (category,expirationDate,description,photograph,name,price) VALUES ('fruta','2015-03-21 12:48:56','Maça importada pais de origem: Espanha','/opt/lbaw/lbaw1344/public_html/final/images/products/apple.jpg','Maça Golden','6.71');
INSERT INTO Product (category,expirationDate,description,photograph,name,price) VALUES ('vegetal','2015-09-27 12:16:31','Abobora nacional','/opt/lbaw/lbaw1344/public_html/final/images/products/pumpkin.jpg','Abobora','27.31');
INSERT INTO Product (category,expirationDate,description,photograph,name,price) VALUES ('vegetal','2015-11-30 15:26:47','Pepino nacional','/opt/lbaw/lbaw1344/public_html/final/images/products/cucumber.jpg','Pepino','10.21');
INSERT INTO Product (category,expirationDate,description,photograph,name,price) VALUES ('vegetal','2015-05-30 02:26:03','Couve galega nacional','/opt/lbaw/lbaw1344/public_html/final/images/products/cabbage.jpg','Couve Galega','15.88');
INSERT INTO Product (category,expirationDate,description,photograph,name,price) VALUES ('vegetal','2015-01-26 05:01:44','Cenouras embaladas','/opt/lbaw/lbaw1344/public_html/final/images/products/packedCarrot.jpg','Cenouras','34.01');
INSERT INTO Product (category,expirationDate,description,photograph,name,price) VALUES ('vegetal','2015-08-03 00:26:27','Alface fresca nacional','/opt/lbaw/lbaw1344/public_html/final/images/products/lettuce.jpg','Alface','7.93');
INSERT INTO Product (category,expirationDate,description,photograph,name,price) VALUES ('cereal','2015-06-06 19:00:47','Arroz integral de três grãos','/opt/lbaw/lbaw1344/public_html/final/images/products/rice.jpg','Arroz Integral','16.83');
INSERT INTO Product (category,expirationDate,description,photograph,name,price) VALUES ('cereal','2015-11-15 09:52:56','Farinha de trigo para usos colunários','/opt/lbaw/lbaw1344/public_html/final/images/products/flour.jpg','Farinha de Trigo','2.77');


INSERT INTO Transaction (value,idPointOfSale) VALUES ('342',2);
INSERT INTO Transaction (value,idPointOfSale) VALUES ('511',2);
INSERT INTO Transaction (value,idPointOfSale) VALUES ('29',2);
INSERT INTO Transaction (value,idPointOfSale) VALUES ('184',3);
INSERT INTO Transaction (value,idPointOfSale) VALUES ('93',3);
INSERT INTO Transaction (value,idPointOfSale) VALUES ('96',3);

INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (1,13);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (2,14);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (3,13);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (4,15);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (5,15);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (6,14);

INSERT INTO Orderino (orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES ('2014-01-01 00:00:00','2014-03-17 22:16:18','2014-07-19 20:35:33',1);
INSERT INTO Orderino (orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES ('2014-01-01 00:00:00','2014-03-29 07:53:15','2014-07-17 06:17:23',2);
INSERT INTO Orderino (orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES ('2014-01-01 00:00:00','2014-03-04 08:54:11','2014-07-29 09:58:43',3);
INSERT INTO Orderino (orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES ('2014-01-01 00:00:00','2014-03-11 12:57:11','2014-07-27 08:29:25',4);
INSERT INTO Orderino (orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES ('2014-01-01 00:00:00','2014-03-20 19:31:02','2014-07-03 15:31:32',5);
INSERT INTO Orderino (orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES ('2014-01-01 00:00:00','2014-03-23 22:24:13','2014-07-05 23:23:24',6);

INSERT INTO ProductOrder (idOrder, idProduct) VALUES (1,5);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (1,2);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (1,13);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (2,6);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (2,7);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (2,1);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (3,1);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (3,4);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (3,8);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (4,2);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (4,3);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (4,11);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (5,9);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (5,10);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (5,6);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (6,2);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (6,1);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (6,13);

INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (1,3);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (1,6);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (1,9);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (1,7);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (1,1);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (1,10);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (2,11);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (2,12);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (2,13);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (2,2);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (2,5);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (2,4);

INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (4,3);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (5,3);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (7,3);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (8,2);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (9,2);

INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (1,3,10);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (1,6,30);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (1,9,25);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (1,7,30);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (1,1,68);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (1,10,136);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (2,11,14);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (2,12,89);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (2,13,73);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (2,2,93);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (2,5,45);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (2,4,65);