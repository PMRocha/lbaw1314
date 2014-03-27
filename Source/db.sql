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
DROP DOMAIN IF EXISTS zip_code;
DROP TYPE IF EXISTS reportType;
DROP TYPE IF EXISTS workday;
DROP TYPE IF EXISTS weekday;

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

INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (1,'adipiscing@Utsemperpretium.net',84106041,'Ap #655-6575 Bibendum Road','BA798618464089064108','2CF72B97-1DB0-FDFB-A82A-E31B03F1BF69','Emily Q. Kane',868957840);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (2,'nec@arcu.net',70122284,'P.O. Box 629, 2421 Ultricies Road','KZ602673533562147059','B30994A4-926C-6D3F-83DF-71FC82171E81','Cain N. Williams',409964262);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (3,'eleifend.Cras@Sedetlibero.com',56122087,'464-8198 Donec Rd.','MK66489622376531009','8E27A8DD-6D37-89E4-F639-6C9942E2C94B','Noah Q. Rivera',763570943);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (4,'aliquet@quamelementumat.org',58505566,'Ap #597-6909 Faucibus Rd.','RO71CIPW8146625001943345','07721C10-1500-B170-F8CE-21FDC0F6F2C2','Avram N. Mccarthy',873460212);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (5,'leo@arcu.org',41771115,'P.O. Box 936, 9100 Quam, St.','ES6395040685633713992831','720F597D-1929-16E1-9D14-259A28C571DF','Michael F. Atkins',102100699);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (6,'pellentesque.tellus.sem@vitae.net',80613178,'982-2705 Sem. Road','LT875330143347663256','A6FAA5F7-8237-9D51-2AE6-CCD0128C3342','Jerome J. Bishop',543254859);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (7,'Phasellus.fermentum@elementumpurusaccumsan.org',31672017,'354-1986 Eu, Av.','IE95LXIU68784207708221','4086AFE7-A814-B452-A92E-1BB7E99FCEF2','Delilah S. Kaufman',546475825);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (8,'Nunc@vulputate.co.uk',74836301,'329-6902 Id, St.','MR8109786305399849730177076','610EB915-6151-197D-C1D0-8E996159586C','Evelyn N. Kirk',176726896);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (9,'luctus@lacuspede.org',48286869,'5330 Congue Rd.','MU1030923009830851819240699424','E690321A-F1AC-8159-9726-264B2C0EB887','Chandler X. Macias',419700737);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (10,'tellus.faucibus.leo@nasceturridiculus.com',14420162,'P.O. Box 678, 842 At, Rd.','MC1196566744226312413712170','4D3099F4-FD4C-4B9B-0B25-9F38D12761E7','Nero L. Davidson',491061654);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (11,'arcu.Morbi.sit@etmagnis.edu',68449193,'7294 Nibh. Rd.','FO8416318845232050','78FB2E00-AA01-597D-8811-E9F62A9672AD','Talon V. Ford',633513772);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (12,'diam.Sed.diam@ullamcorper.com',59564504,'986-9266 Erat St.','IL312521271459484018803','293738A5-CACD-77B6-7BEA-94C52C1595C9','Holly U. Livingston',654105086);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (13,'et.magnis.dis@pedeSuspendisse.ca',31723686,'7761 Consectetuer Street','SK3624546789795347188213','76156B52-28AF-8828-99D8-92FBDCB17C10','Winter Q. Morin',428945697);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (14,'nunc.est@consequatpurusMaecenas.edu',66741923,'P.O. Box 357, 8626 Nam Avenue','IL924291939471633158438','2B4BA7CE-087C-C078-DA4E-561D1D41F39C','Cassandra L. Mann',694905120);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (15,'Donec.felis.orci@amet.co.uk',61448726,'P.O. Box 157, 5501 Neque Av.','EE828749673851082860','F41C36CE-0E2A-FE57-3F72-EFFFD5BDAF8E','Winifred U. Wilder',572846625);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (16,'molestie.orci.tincidunt@utcursus.org',22000112,'615-1369 Risus Road','GE63384372572116406071','F7F2E946-F7F7-A2CF-B08E-5D55B2E2CFE8','Tate E. Terrell',833397969);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (17,'est@perconubia.ca',37388850,'8390 Nascetur Rd.','MC1847723222627342634189228','BD5D40D5-0B86-9B95-5C5A-74B711955077','Iliana Z. Collier',758013255);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (18,'pharetra.Quisque@odioauctorvitae.com',95176507,'243-8303 Sem Av.','ES4315930656666571983823','3C41D2EF-D6A9-0674-3B83-43AB0CEFD08C','Abdul D. Santiago',236992396);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (19,'est.Mauris.eu@feugiat.com',74210511,'8147 Leo. Street','MR2892854707001135885698702','1EF76004-CCD2-AEEB-6FB5-F9110DEF3912','Sade R. Kirkland',223981256);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (20,'dictum@nequepellentesquemassa.com',51940861,'P.O. Box 798, 4731 Nam Rd.','AL24826507084014982070143947','4A2C9AE6-6437-8BBD-0563-6F77BDECB6CD','Glenna C. Parrish',751346122);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (21,'ac.nulla@iaculisneceleifend.com',24523091,'P.O. Box 520, 5410 Facilisis St.','DK5515109620164669','7F402956-22E4-5AE1-3F94-9010C0D0B8EA','Justine W. Lamb',644791661);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (22,'varius.orci.in@aliquet.ca',96846183,'9370 Ut Rd.','SM7688957901161747074663414','C3BDC8A8-D885-3A10-BE36-E93BB4F480ED','Shaeleigh B. Roach',992296784);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (23,'mus@ProinultricesDuis.org',42895336,'P.O. Box 278, 2552 Quis St.','AD2078682330920186492103','1BEC9403-7A84-330D-8B6B-88BA89591E1F','Lavinia S. Clay',988139937);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (24,'luctus@montesnasceturridiculus.edu',82606097,'P.O. Box 854, 8427 Phasellus Street','DO70511191861792965735189605','2BFA3F00-3FC8-2A0F-524A-0593F80DD4D8','Hop V. Salinas',225626327);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (25,'eleifend@consequat.net',93208635,'854-9260 Sed St.','HR6009575559427330990','AA60A6A7-982C-11CA-C698-47BFB6A919E8','Byron G. Reeves',919146275);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (26,'aliquam.adipiscing@convallis.com',48837575,'9127 Egestas, Avenue','DE51436880151302191706','C5CF6D1F-3BCE-A1E9-1654-7717EA2A9612','Luke F. Gay',251440672);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (27,'a@in.net',62795971,'7536 Rutrum, Rd.','GL2425495950960833','F1D29C08-8DB8-4385-716A-59CE83EF1868','Drake F. Aguirre',578808172);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (28,'vitae.purus@Vivamus.edu',90145565,'671-2815 Nulla. Rd.','GB32RPWI96073574710138','CB608D30-DE54-0C5F-73EE-72CC57A1E249','Alexis Z. Hartman',942998356);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (29,'magna.Ut@congue.net',18707264,'Ap #598-1151 Nunc Road','IL523426927656039327450','457CA984-7E0B-4391-EBD5-F7824EA89C6D','Harper V. Farley',760774404);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (30,'a.tortor.Nunc@sedconsequatauctor.net',26577048,'2373 Facilisis Street','FO1377968374450591','31D81269-DCBB-CF77-C35E-4E884CC50C19','Dominic L. White',595242229);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (31,'Proin.sed@fermentum.edu',85103534,'621-4906 Montes, Avenue','DE64823353485301748089','AE3A2F2C-CA07-8DE1-71DA-0F4BEE014861','Theodore E. Monroe',164414184);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (32,'eu@inhendreritconsectetuer.co.uk',99626905,'9552 Mauris Avenue','PL55546095125334723990088964','40FF2B18-CD54-4022-7EFB-B31284704AA5','Jada Q. Lang',456461416);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (33,'erat@Maurisnulla.net',90120786,'Ap #922-4852 Maecenas St.','LU727264973542957759','C09BA4DF-18EE-C00E-780A-1FE881684A09','Ella H. Cleveland',223930253);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (34,'interdum.libero@faucibusorciluctus.org',40889018,'363-4338 Tincidunt Road','AZ86029467058238566343026467','DAA5ED29-73D4-452C-2CE4-EE6F1B7A6BBF','Branden J. Smith',287202092);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (35,'luctus.felis@orcisemeget.net',14723316,'4057 Nec, St.','SE0424706333021004401310','E4937FF5-7D8D-8A2D-1191-1CCD34F93350','Halee R. Booth',143819404);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (36,'massa.Integer.vitae@et.org',15830338,'7112 Elit. Road','SE4418958080738578505633','8A8553A5-A919-C676-6064-9CE98E6CC77C','Alice Y. Buchanan',282557535);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (37,'cursus.non@pedeCumsociis.org',10148979,'P.O. Box 947, 6879 Diam Road','AL76143441214477891944655686','E02C8B8A-9708-6674-1A61-43ED49674C05','Cora E. Higgins',677880345);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (38,'arcu.Sed@nec.edu',26886847,'552-3487 Parturient Avenue','BA539607148707478567','ECF9FA07-5F62-3DCC-4EF7-237067AB2C69','Giselle L. Mckee',552402195);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (39,'ligula@nisl.com',43529796,'9096 Pede. Street','LV58ANPH8738441317825','00B8C8A2-EF1E-5614-4DCB-1B82519368BB','Yoshio Q. Conner',725956504);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (40,'molestie.in@elitpharetraut.co.uk',44034690,'Ap #352-991 Feugiat Av.','LB49108267987571502118727123','3483F153-C736-CDEF-EFBD-E1EDD83FE28F','Henry W. Byers',182990152);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (41,'elit.fermentum@natoquepenatibuset.net',25252595,'Ap #674-1643 Fringilla, Ave','FR5675908300108468233010614','A1CD17A6-BB31-39F8-F40E-AD6A7750AEE2','Tobias S. Douglas',929134555);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (42,'non@acmattisvelit.edu',54222314,'P.O. Box 796, 8832 Scelerisque St.','FR5708980121423034550829152','75A3D0D5-7547-F05E-9C8B-A1FA495DC154','Ora B. Gates',674746533);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (43,'ut@tellus.ca',87037663,'8141 Non, Street','KW9089068715494564597073714909','F4AB4F61-AE6E-2F65-09E5-1B2E9BCD5EE2','Norman X. Stout',976550368);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (44,'tellus.lorem@ullamcorpereu.net',54177055,'2178 Dolor Street','FR5338934799821693850438726','D79F629F-5F82-72D2-6650-0F7443F58C37','Madeline Y. Bates',324274122);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (45,'convallis.est.vitae@egestaslacinia.net',43217315,'P.O. Box 542, 2742 Amet, Rd.','LI7553414543514245001','FB4BD6AA-3457-F9C9-A7ED-921626A0CF00','William M. Floyd',443440101);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (46,'cursus.Integer@sodalesnisi.ca',19717774,'Ap #577-6292 Eget St.','FR8699419698887574365569761','9BA5E9F1-18C8-0472-FD0D-556873D04D75','Theodore Z. Boyd',620466654);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (47,'porttitor.eros@luctus.org',96529603,'P.O. Box 964, 2366 Diam Avenue','SI71703684122628671','E231D418-B945-6F83-8D9F-C1B50E2A542E','Vivian Y. Mcmahon',518996754);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (48,'ligula.Nullam@luctusvulputatenisi.edu',37998017,'4647 Molestie Ave','IE68YUMH45128536088366','BBA52F2E-68FC-4B23-F7C0-19D965119F39','Catherine W. Cox',977740044);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (49,'augue.scelerisque.mollis@penatibusetmagnis.org',73207469,'6216 Neque. St.','AL06266550352815953089095154','63E02712-E9CB-03E5-A013-C1CD002318A5','Jakeem O. Vang',682324101);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (50,'libero.Donec@volutpatornarefacilisis.edu',47441759,'170-2104 Integer Av.','AE724409874306823097685','0A6D37B1-D71B-723A-8DFF-A20680FEBA2A','Minerva Q. Puckett',931980987);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (51,'Phasellus@ametorci.co.uk',98127010,'4055 Cras Street','GI34IWXF708908135425382','DA1ED50C-B29C-E988-4BDA-7235B1096F39','Gillian O. Slater',667962671);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (52,'diam.luctus.lobortis@porttitorinterdumSed.net',91696743,'555-7736 Et Avenue','MU1537947536078537061537280214','9D38BC40-5F3F-6776-7597-E61AF9C5F61A','Kim E. Pena',297589897);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (53,'parturient@imperdiet.co.uk',79976062,'9778 Montes, Road','PL60713241895104589707602520','14BE7A9A-02C4-4AA4-4742-1106232B7141','Finn P. Warren',879006389);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (54,'lacus.vestibulum@elitCurabitur.ca',48450383,'Ap #760-2244 Dui Street','AZ06050479724640960956978704','14D1B111-BCDA-1C3E-432A-659CCEED9860','Amber R. Sykes',932349276);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (55,'elit@musDonecdignissim.co.uk',34464755,'501-2039 A, Avenue','ES2029890131871532175289','D1113506-0F6D-BAA3-E314-4D97E8837084','Wilma A. Clarke',864005331);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (56,'quis.pede@velsapien.co.uk',47749822,'5701 Nulla Street','PK3613814271727813468049','144C77F9-C4E7-A78F-002B-C5A44765D653','Ross T. Osborn',228172808);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (57,'ac@Donec.org',14380602,'Ap #329-6414 Bibendum Rd.','PK7705375632330770378560','4F598BD6-4144-FB01-E0CA-7E523ACE9667','Finn K. Perry',394465562);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (58,'Mauris.nulla@Innecorci.ca',56286319,'476-6773 Ornare, St.','KZ255554461256474905','F2CD41B6-BD39-EA57-BB32-F5708ACC1533','Gage C. Guy',142205449);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (59,'cursus.et.magna@hendrerit.co.uk',82667923,'4302 Facilisis St.','RO11DHWJ7334285322234265','D697432C-2ABC-682D-D1FC-542007FC9CF5','Yetta C. Dudley',368608639);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (60,'Duis.volutpat@eratvitae.org',57810812,'5676 Posuere, Road','CH0384481304938131975','880FCF94-53FA-44F5-6EE1-4969732D01AE','Maryam G. Oneal',695481715);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (61,'Sed.nunc@Cum.net',12840071,'6561 Sed, St.','KW9574615323512035183995309502','BF17BE46-56BB-62CF-6E65-489286F1C3A3','Denise N. Heath',557078434);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (62,'parturient.montes@lectusasollicitudin.net',12383606,'Ap #202-1267 Sed St.','AZ18808345247078340213064217','C5DB881D-8566-7FEA-51CA-C2BE307A7DE5','Brenna Q. Gay',473325103);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (63,'venenatis.lacus@eulacusQuisque.edu',32723184,'P.O. Box 180, 7340 Lorem Road','IT628XPLLI51231863468174023','FB141D0B-0657-CB14-3870-F394FA6EB35E','Virginia U. Larsen',225803956);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (64,'magna.Suspendisse@maurisblanditmattis.org',24973886,'P.O. Box 550, 4445 Et Rd.','IS912127391797101895665064','CD9A0D79-36D0-7F68-DCED-BA9AC49C76F0','Boris L. Salazar',612335030);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (65,'semper.tellus@ipsum.co.uk',36007184,'785-7101 Ipsum Avenue','BG45SWDQ28795902579715','719125D9-1F8F-0DB7-5176-1A7E0AE0BA22','Kaseem A. Chandler',834836613);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (66,'hendrerit@a.net',21535102,'P.O. Box 430, 2104 Urna. St.','MT50PGTA49968240701450110180734','DE7792C0-C9DB-8235-C0BC-2516D9944C4E','Finn L. Henderson',183867951);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (67,'amet@etmagnis.net',91311242,'2119 Donec Road','IS690133017765987792678037','B7F0D974-BF89-5297-BEFF-DE0AB315B9A8','Callie G. Williamson',354294372);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (68,'leo.Vivamus.nibh@idlibero.ca',70137457,'P.O. Box 728, 3258 Faucibus Ave','FO2551910791139942','06AFE2D3-314D-B875-8486-D0C5C80A811B','Tashya Y. Sharpe',755564553);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (69,'Donec.porttitor.tellus@eudui.ca',15045793,'P.O. Box 222, 7270 Massa. Road','CY38026602452070080374824328','207BF202-9A29-9696-7585-D269C81279F8','Ross M. Boone',677622814);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (70,'tincidunt.nunc.ac@ridiculusmus.net',75363481,'3938 Praesent St.','IT986PMOAI60809742508338032','88E0A609-218E-1516-5276-895ED7D47CF3','Tanya B. Rivera',344860734);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (71,'eu.nulla@Crasinterdum.ca',63493227,'Ap #571-3529 Metus. Rd.','CZ7333390444307547698514','C47C4481-D275-38D0-1454-50194CD38732','Lareina F. Sandoval',283361702);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (72,'urna@vulputate.org',95831827,'221-1087 Ullamcorper Rd.','IS240269252125153544675205','BEB163BC-118A-1141-FE7E-2CCD8D3F86E6','Reese P. Chen',732287795);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (73,'ac.urna.Ut@scelerisquesed.com',99043595,'Ap #173-9662 Consectetuer, Avenue','KZ514777906298011441','E5BA9233-2AE4-A6C0-5E81-F64CB9EB95EC','Jane K. Boyer',664365386);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (74,'velit.eu.sem@Ut.net',14774124,'P.O. Box 176, 6441 Arcu. Rd.','IE78IMDC20587629195369','AB8156AC-FDB7-B852-6897-86908918235C','Lenore V. Armstrong',198391210);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (75,'ipsum.non@necorciDonec.com',89624444,'P.O. Box 981, 6187 Commodo Av.','NO7721475725128','6139ED06-9B5A-8A96-3A8F-D69DEDEDA270','Joy S. Crawford',447840784);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (76,'accumsan.convallis@auctorvelitAliquam.edu',76304447,'P.O. Box 631, 8026 Diam. Ave','SM2050437889728880179967794','B179E06D-1F26-5D57-CD9E-A68F5645DCE6','Maia U. Mcintyre',275034624);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (77,'molestie.in@commodo.com',34203440,'2223 Sagittis Road','IL613720136531413762047','356D677C-4113-B164-F0A9-791443829406','Gil G. Wagner',737166149);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (78,'enim.Suspendisse.aliquet@nondapibusrutrum.co.uk',81623721,'2806 Mus. Street','BH31428468238630505081','021FE337-522C-0166-CA2A-BD6BE36C2E52','Freya N. Head',890157816);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (79,'elit.Nulla.facilisi@magnaa.co.uk',72735953,'Ap #651-2854 Ullamcorper, Ave','SI63652345327902166','CB3681B9-8A91-2284-137E-95FBA4146CA4','Whitney A. Miranda',670898759);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (80,'a@Etiamlaoreetlibero.co.uk',39789661,'5002 Ipsum. St.','FR6178126696450814854810075','78785D1F-F070-22F1-6B41-B25EFD4107D4','Griffith U. Alford',607547089);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (81,'quis@volutpatNulla.edu',89903718,'647 Et Av.','PS854157607858738450621031569','F1BC0597-BF03-C901-E01A-9338A6DB1CB0','Leandra U. Craft',668201760);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (82,'hendrerit.Donec.porttitor@facilisis.com',89003938,'P.O. Box 390, 4245 Nunc St.','GE68296416090004096092','5AA91EEB-4188-7C04-6DE4-53AE0CCC1BD7','Leonard J. Guzman',276705401);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (83,'interdum.ligula.eu@eratvitae.ca',75448488,'9322 Tristique Avenue','FI6203811083863076','E207ED60-A5A2-062D-A8A3-FED8FD83A519','Sybil V. Lancaster',914300489);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (84,'mauris.erat@adipiscingelit.edu',45671839,'P.O. Box 884, 6852 Rhoncus. St.','FO6037142236235041','892E78C5-721D-CBE8-19F4-D97A26BDFC26','Isadora D. Keith',815897223);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (85,'erat.eget@famesacturpis.edu',37307347,'P.O. Box 748, 1119 Vestibulum, Av.','CH5693977748456662066','D688B519-1861-701C-CB38-13A1B7038D6C','Shay J. Gomez',157922776);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (86,'sed.consequat@sit.org',46280744,'6018 In Road','TR242701761876350522788752','4512D880-2F19-5628-A4F9-99F6DCE50394','Colette H. Trujillo',659145466);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (87,'turpis@nislQuisque.org',37250993,'Ap #355-5876 Aliquam St.','GT63585446276927355141964013','022D0D50-996D-B1AD-26CB-CF84666B39C3','Hillary M. Wheeler',780024481);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (88,'libero.mauris@consequatnecmollis.co.uk',71631679,'Ap #980-3147 Id, St.','GI74JFMI455581506574831','346363DA-2557-3AF2-23B5-E88F7ECD6D37','Fulton O. Scott',551891029);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (89,'natoque.penatibus.et@feugiattelluslorem.co.uk',15758411,'P.O. Box 462, 4224 Aliquam St.','TN6612509056028720682246','F2A5E8B1-D0EB-6F7C-F72E-E5D0AA35A210','Rina C. Ellis',998507750);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (90,'orci@commodo.com',61998598,'2376 Rhoncus. Avenue','MU9648160047674692769063675809','F9E34371-9B42-44EE-7032-A893238F69FA','Jasper C. Fitzgerald',415203494);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (91,'consequat.purus.Maecenas@pede.co.uk',52116407,'Ap #499-6708 At Avenue','CY87192036087905958259944717','D10AB9F8-54A1-9F8B-4D72-0D66BC876CFF','Nathan S. Bailey',209822423);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (92,'Sed.et.libero@quis.edu',69622565,'P.O. Box 692, 5451 Sit Ave','ME61090777063235171357','1E1A41A9-7251-B58C-A8C6-552A717D9D13','Nevada W. Ewing',523264738);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (93,'sapien.imperdiet.ornare@necanteMaecenas.net',78185785,'Ap #480-7945 In Road','MU7957838895836096149674205259','A07670ED-E3F3-1DA7-E9A7-33579AE3A175','Norman Q. Bruce',737781858);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (94,'erat@sitamet.co.uk',90072635,'617-7226 Arcu St.','NL44HVZF7601925938','B506F5B6-5E68-33D9-AC09-E1E6385FF597','Plato X. Byers',166458479);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (95,'a@porttitorvulputate.edu',93602580,'Ap #450-7408 Enim Rd.','NL81PFNU0031937237','B2E0EE37-9B54-90A8-5B7F-C675DECB2748','Alan C. Ferrell',532297101);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (96,'malesuada.fames.ac@senectusetnetus.net',75938168,'Ap #945-1341 Neque Road','LT576397723898151571','84870273-AA8D-1715-5E22-C31654CCCF83','Shelley S. Washington',215974838);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (97,'Fusce.diam.nunc@Maurisblanditenim.com',66503600,'7189 Arcu. Ave','NO1218595944999','DE45EED0-051B-4FAA-B6B3-16A6A9D36154','Steven X. Harding',735619142);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (98,'ligula.Donec@Phasellusataugue.co.uk',81292823,'386-4548 Suspendisse Road','SA3967239456438881623658','ECDBFF54-8742-5DA4-6A6B-3A4928150623','Caesar A. Sykes',475643554);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (99,'arcu@primis.edu',21408050,'P.O. Box 468, 9987 Sem St.','GE63206088689940082440','6FC2441E-D982-4F03-6D53-1DB69229F420','Zelenia U. Pollard',966503149);
INSERT INTO Person (idPerson,email,fax,address,ban,fin,name,telephone) VALUES (100,'erat.in@vel.net',71291906,'3890 Metus Av.','SI63098354312897179','11985D08-1C22-D658-AF77-1465E21EF8FD','Margaret B. Tate',780273422);

INSERT INTO Client(idPerson) VALUES (51);
INSERT INTO Client(idPerson) VALUES (52);
INSERT INTO Client(idPerson) VALUES (53);
INSERT INTO Client(idPerson) VALUES (54);
INSERT INTO Client(idPerson) VALUES (55);
INSERT INTO Client(idPerson) VALUES (56);
INSERT INTO Client(idPerson) VALUES (57);
INSERT INTO Client(idPerson) VALUES (58);
INSERT INTO Client(idPerson) VALUES (59);
INSERT INTO Client(idPerson) VALUES (60);
INSERT INTO Client(idPerson) VALUES (61);
INSERT INTO Client(idPerson) VALUES (62);
INSERT INTO Client(idPerson) VALUES (63);
INSERT INTO Client(idPerson) VALUES (64);
INSERT INTO Client(idPerson) VALUES (65);
INSERT INTO Client(idPerson) VALUES (66);
INSERT INTO Client(idPerson) VALUES (67);
INSERT INTO Client(idPerson) VALUES (68);
INSERT INTO Client(idPerson) VALUES (69);
INSERT INTO Client(idPerson) VALUES (70);
INSERT INTO Client(idPerson) VALUES (71);
INSERT INTO Client(idPerson) VALUES (72);
INSERT INTO Client(idPerson) VALUES (73);
INSERT INTO Client(idPerson) VALUES (74);
INSERT INTO Client(idPerson) VALUES (75);

INSERT INTO Supplier(idPerson) VALUES (76);
INSERT INTO Supplier(idPerson) VALUES (77);
INSERT INTO Supplier(idPerson) VALUES (78);
INSERT INTO Supplier(idPerson) VALUES (79);
INSERT INTO Supplier(idPerson) VALUES (80);
INSERT INTO Supplier(idPerson) VALUES (81);
INSERT INTO Supplier(idPerson) VALUES (82);
INSERT INTO Supplier(idPerson) VALUES (83);
INSERT INTO Supplier(idPerson) VALUES (84);
INSERT INTO Supplier(idPerson) VALUES (85);
INSERT INTO Supplier(idPerson) VALUES (86);
INSERT INTO Supplier(idPerson) VALUES (87);
INSERT INTO Supplier(idPerson) VALUES (88);
INSERT INTO Supplier(idPerson) VALUES (89);
INSERT INTO Supplier(idPerson) VALUES (90);
INSERT INTO Supplier(idPerson) VALUES (91);
INSERT INTO Supplier(idPerson) VALUES (92);
INSERT INTO Supplier(idPerson) VALUES (93);
INSERT INTO Supplier(idPerson) VALUES (94);
INSERT INTO Supplier(idPerson) VALUES (95);
INSERT INTO Supplier(idPerson) VALUES (96);
INSERT INTO Supplier(idPerson) VALUES (97);
INSERT INTO Supplier(idPerson) VALUES (98);
INSERT INTO Supplier(idPerson) VALUES (99);
INSERT INTO Supplier(idPerson) VALUES (100);

INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (1,'C:\Users\Joao\Desktop\name.jpg','ZNW61BWI8UX','7928.94','Kitra');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (2,'C:\Users\Joao\Desktop\name.jpg','XLQ82WRP7FP','0879.38','Rebekah');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (3,'C:\Users\Joao\Desktop\name.jpg','BPN66YSP1AL','0638.72','Yvette');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (4,'C:\Users\Joao\Desktop\name.jpg','ELQ83KNV7OX','8705.37','Adena');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (5,'C:\Users\Joao\Desktop\name.jpg','DQH22CZF2GY','1919.97','Celeste');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (6,'C:\Users\Joao\Desktop\name.jpg','CPY10CUD4CF','8078.89','Shelly');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (7,'C:\Users\Joao\Desktop\name.jpg','JQC98WVD7YF','3653.34','Calista');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (8,'C:\Users\Joao\Desktop\name.jpg','VQM00OER7SM','6621.38','Sydnee');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (9,'C:\Users\Joao\Desktop\name.jpg','FLX57WBG4LI','0281.33','Rigel');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (10,'C:\Users\Joao\Desktop\name.jpg','PKZ86NMO0MC','5934.52','Belle');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (11,'C:\Users\Joao\Desktop\name.jpg','NSW02YKZ8KF','3942.76','Cassandra');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (12,'C:\Users\Joao\Desktop\name.jpg','UEC52TDB3IH','1946.61','Harrison');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (13,'C:\Users\Joao\Desktop\name.jpg','WNB87AGQ1WD','7679.27','Ursa');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (14,'C:\Users\Joao\Desktop\name.jpg','JGI44XZP0FG','5293.53','Sybil');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (15,'C:\Users\Joao\Desktop\name.jpg','VYF43CSH2XL','1299.08','Meghan');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (16,'C:\Users\Joao\Desktop\name.jpg','LEL25ZCT9OB','0585.35','Joan');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (17,'C:\Users\Joao\Desktop\name.jpg','BLX45ZYE0EZ','0787.56','Penelope');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (18,'C:\Users\Joao\Desktop\name.jpg','OCR74BTC7FU','5958.46','Carla');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (19,'C:\Users\Joao\Desktop\name.jpg','AFP22LRL7GZ','6820.15','Scarlet');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (20,'C:\Users\Joao\Desktop\name.jpg','DTS16VXS0OC','8674.33','Holmes');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (21,'C:\Users\Joao\Desktop\name.jpg','QMN76BKY0WY','3818.28','Brenna');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (22,'C:\Users\Joao\Desktop\name.jpg','BYC38TPH8IE','8183.27','Deanna');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (23,'C:\Users\Joao\Desktop\name.jpg','GHT44ZCL5KA','4082.97','Dawn');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (24,'C:\Users\Joao\Desktop\name.jpg','HVN32QWQ5HO','5547.23','Camille');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (25,'C:\Users\Joao\Desktop\name.jpg','LZQ39BYI1SE','0634.46','Naomi');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (26,'C:\Users\Joao\Desktop\name.jpg','GQD50BSA6XW','3842.22','Ivor');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (27,'C:\Users\Joao\Desktop\name.jpg','SIY14CIA3SS','4917.44','Miranda');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (28,'C:\Users\Joao\Desktop\name.jpg','GLK30VQM0ZF','1355.67','Bernard');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (29,'C:\Users\Joao\Desktop\name.jpg','REU22NOS6BK','2077.25','Moses');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (30,'C:\Users\Joao\Desktop\name.jpg','RJK27DOL3PR','6043.03','Xandra');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (31,'C:\Users\Joao\Desktop\name.jpg','WEM88PNV9ZB','0359.61','Herrod');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (32,'C:\Users\Joao\Desktop\name.jpg','LSL13OAC1PN','4271.11','Ann');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (33,'C:\Users\Joao\Desktop\name.jpg','VNT95VDY2IT','1931.26','Evan');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (34,'C:\Users\Joao\Desktop\name.jpg','YWD27JOH9MG','0443.52','Brenden');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (35,'C:\Users\Joao\Desktop\name.jpg','PMI05VEC9IS','2065.91','Sandra');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (36,'C:\Users\Joao\Desktop\name.jpg','HTB05DEM5CR','6871.33','Dorothy');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (37,'C:\Users\Joao\Desktop\name.jpg','YSG42CCG8VP','6605.70','Kaye');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (38,'C:\Users\Joao\Desktop\name.jpg','ANF73DRY3QV','1017.83','Giacomo');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (39,'C:\Users\Joao\Desktop\name.jpg','PHE23EAI8AI','4574.34','Dai');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (40,'C:\Users\Joao\Desktop\name.jpg','AUI60DAK3KO','1883.86','Vladimir');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (41,'C:\Users\Joao\Desktop\name.jpg','NOO43WVY5IH','9011.31','Porter');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (42,'C:\Users\Joao\Desktop\name.jpg','BOM20IMJ4DG','6073.70','Coby');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (43,'C:\Users\Joao\Desktop\name.jpg','UVA54HLZ5GP','4988.11','Kato');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (44,'C:\Users\Joao\Desktop\name.jpg','NSH81XYI1JA','4500.35','Hiram');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (45,'C:\Users\Joao\Desktop\name.jpg','MKK76YBA5YC','9177.62','Matthew');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (46,'C:\Users\Joao\Desktop\name.jpg','GFF93CNC2ON','9562.35','Montana');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (47,'C:\Users\Joao\Desktop\name.jpg','KUE06QTK2JB','1204.44','Carissa');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (48,'C:\Users\Joao\Desktop\name.jpg','XVN88KLO0KB','2955.15','Arsenio');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (49,'C:\Users\Joao\Desktop\name.jpg','EYM02PML2NR','2505.91','Kennan');
INSERT INTO Userino (idPerson,photograph,password,salary,userName) VALUES (50,'C:\Users\Joao\Desktop\name.jpg','JMN78PFZ0AG','7213.84','Liberty');

INSERT INTO Manager (idPerson) VALUES (1);

INSERT INTO PoSOperator (idPerson) VALUES (2);
INSERT INTO PoSOperator (idPerson) VALUES (3);
INSERT INTO PoSOperator (idPerson) VALUES (4);
INSERT INTO PoSOperator (idPerson) VALUES (5);
INSERT INTO PoSOperator (idPerson) VALUES (6);
INSERT INTO PoSOperator (idPerson) VALUES (7);
INSERT INTO PoSOperator (idPerson) VALUES (8);
INSERT INTO PoSOperator (idPerson) VALUES (9);
INSERT INTO PoSOperator (idPerson) VALUES (10);
INSERT INTO PoSOperator (idPerson) VALUES (11);
INSERT INTO PoSOperator (idPerson) VALUES (12);

INSERT INTO ShopKeeper (idPerson) VALUES (13);
INSERT INTO ShopKeeper (idPerson) VALUES (14);
INSERT INTO ShopKeeper (idPerson) VALUES (15);
INSERT INTO ShopKeeper (idPerson) VALUES (16);
INSERT INTO ShopKeeper (idPerson) VALUES (17);
INSERT INTO ShopKeeper (idPerson) VALUES (18);
INSERT INTO ShopKeeper (idPerson) VALUES (19);
INSERT INTO ShopKeeper (idPerson) VALUES (20);
INSERT INTO ShopKeeper (idPerson) VALUES (21);
INSERT INTO ShopKeeper (idPerson) VALUES (22);
INSERT INTO ShopKeeper (idPerson) VALUES (23);
INSERT INTO ShopKeeper (idPerson) VALUES (24);
INSERT INTO ShopKeeper (idPerson) VALUES (25);
INSERT INTO ShopKeeper (idPerson) VALUES (26);
INSERT INTO ShopKeeper (idPerson) VALUES (27);
INSERT INTO ShopKeeper (idPerson) VALUES (28);
INSERT INTO ShopKeeper (idPerson) VALUES (29);
INSERT INTO ShopKeeper (idPerson) VALUES (30);
INSERT INTO ShopKeeper (idPerson) VALUES (31);
INSERT INTO ShopKeeper (idPerson) VALUES (32);
INSERT INTO ShopKeeper (idPerson) VALUES (33);
INSERT INTO ShopKeeper (idPerson) VALUES (34);
INSERT INTO ShopKeeper (idPerson) VALUES (35);
INSERT INTO ShopKeeper (idPerson) VALUES (36);
INSERT INTO ShopKeeper (idPerson) VALUES (37);
INSERT INTO ShopKeeper (idPerson) VALUES (38);
INSERT INTO ShopKeeper (idPerson) VALUES (39);
INSERT INTO ShopKeeper (idPerson) VALUES (40);
INSERT INTO ShopKeeper (idPerson) VALUES (41);
INSERT INTO ShopKeeper (idPerson) VALUES (42);
INSERT INTO ShopKeeper (idPerson) VALUES (43);
INSERT INTO ShopKeeper (idPerson) VALUES (44);
INSERT INTO ShopKeeper (idPerson) VALUES (45);
INSERT INTO ShopKeeper (idPerson) VALUES (46);
INSERT INTO ShopKeeper (idPerson) VALUES (47);
INSERT INTO ShopKeeper (idPerson) VALUES (48);
INSERT INTO ShopKeeper (idPerson) VALUES (49);
INSERT INTO ShopKeeper (idPerson) VALUES (50);

INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (1,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula','02/06/2013','Suspendisse',11,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (2,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna.','23/08/2013','elit, a',12,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (3,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et','31/08/2013','aliquet nec, imperdiet',4,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (4,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam','20/11/2013','nec mauris blandit',3,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (5,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam quis diam. Pellentesque','25/09/2013','imperdiet dictum',3,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (6,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula','20/08/2013','pharetra. Quisque ac',3,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (7,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis','03/11/2013','turpis',6,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (8,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis','29/03/2013','Curabitur sed tortor. Integer',7,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (9,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada','30/01/2014','Donec egestas. Aliquam nec',9,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (10,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci','17/11/2013','ac orci. Ut semper',11,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (11,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue','11/12/2013','augue, eu tempor',8,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (12,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna.','26/06/2013','Duis',5,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (13,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae,','06/06/2013','vulputate dui, nec',11,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (14,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam quis','19/11/2013','torquent per conubia',11,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (15,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam','27/02/2014','gravida. Praesent eu',5,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (16,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt','25/06/2013','dapibus ligula. Aliquam erat',2,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (17,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut','15/06/2013','Lorem ipsum dolor',10,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (18,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna','05/04/2013','malesuada. Integer id magna',10,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (19,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar','17/02/2014','Duis dignissim tempor arcu.',8,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (20,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam quis diam.','29/01/2014','Quisque nonummy ipsum non',3,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (21,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu','28/03/2013','ut, pellentesque eget,',6,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (22,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci.','10/12/2013','sit',8,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (23,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas','22/01/2014','libero lacus,',11,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (24,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis','11/01/2014','magna',4,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (25,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat','28/05/2013','enim.',9,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (26,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque','16/11/2013','enim',2,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (27,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae,','26/10/2013','hymenaeos.',2,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (28,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque','28/06/2013','aliquet nec,',9,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (29,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas','18/08/2013','Curabitur',5,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (30,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at,','17/01/2014','Aliquam erat',6,'Sales');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (31,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla','07/07/2013','egestas a,',6,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (32,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed,','19/11/2013','massa. Quisque',7,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (33,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus','03/07/2013','commodo auctor velit. Aliquam',12,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (34,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam','30/07/2013','tempus eu, ligula.',11,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (35,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et','04/04/2013','mi, ac mattis',7,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (36,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing','17/04/2013','sed',6,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (37,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget','24/01/2014','et libero.',8,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (38,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque','23/08/2013','dictum',11,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (39,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam','11/06/2013','et nunc. Quisque ornare',6,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (40,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed,','25/05/2013','convallis convallis dolor. Quisque',9,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (41,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede.','26/08/2013','elit erat vitae risus.',8,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (42,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer','11/05/2013','aliquet, metus urna',2,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (43,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa','04/06/2013','Nam ligula elit,',7,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (44,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec','26/10/2013','In',11,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (45,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu,','18/02/2014','laoreet, libero et tristique',8,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (46,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce','05/09/2013','sodales at,',10,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (47,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede.','07/09/2013','ullamcorper eu,',4,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (48,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam,','08/04/2013','consequat dolor vitae',6,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (49,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris,','04/06/2013','enim commodo hendrerit.',8,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (50,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu,','21/04/2013','pellentesque massa lobortis ultrices.',9,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (51,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc','16/04/2013','orci quis lectus.',9,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (52,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam quis diam. Pellentesque habitant','21/07/2013','et, eros. Proin ultrices.',2,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (53,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam','26/08/2013','aliquet nec,',12,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (54,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non,','10/11/2013','aliquam eu, accumsan sed,',11,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (55,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci','20/10/2013','luctus vulputate, nisi',8,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (56,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam quis diam.','22/01/2014','diam lorem,',5,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (57,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque','05/02/2014','fermentum risus,',2,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (58,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum.','22/06/2013','vehicula et, rutrum',12,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (59,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet','28/12/2013','Sed',6,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (60,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque','06/04/2013','Nam',5,'Deposit');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (61,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor.','13/04/2013','pharetra',4,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (62,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis','30/01/2014','facilisis.',9,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (63,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum','03/04/2013','nec metus facilisis',2,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (64,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu','03/06/2013','sem,',5,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (65,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque','25/06/2013','ac mattis velit justo',2,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (66,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci','11/04/2013','arcu',9,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (67,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut','05/10/2013','dictum magna.',6,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (68,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam quis diam. Pellentesque habitant morbi','01/12/2013','eu dolor egestas',7,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (69,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida','19/09/2013','Etiam bibendum fermentum metus.',11,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (70,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus.','10/10/2013','sem ut dolor',8,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (71,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin','14/06/2013','Nunc',5,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (72,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam,','09/06/2013','Integer tincidunt aliquam',3,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (73,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a,','01/12/2013','tempor',12,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (74,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan','27/07/2013','adipiscing',3,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (75,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus.','24/07/2013','sociosqu',11,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (76,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt','25/10/2013','pulvinar arcu',8,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (77,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt','02/12/2013','non, lobortis quis,',10,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (78,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus','17/07/2013','tempus eu, ligula. Aenean',7,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (79,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci','16/05/2013','ultrices. Duis volutpat nunc',10,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (80,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus','26/02/2014','adipiscing non, luctus sit',4,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (81,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis','29/11/2013','pede',11,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (82,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet','13/08/2013','velit. Quisque',8,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (83,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce','02/05/2013','sodales nisi magna',8,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (84,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero','28/01/2014','Integer eu lacus.',5,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (85,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc','05/05/2013','pharetra. Nam',2,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (86,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada','22/09/2013','Mauris',12,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (87,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et','28/03/2013','nibh enim,',7,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (88,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas','17/12/2013','pede,',4,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (89,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam quis diam.','31/10/2013','Nulla tempor augue',12,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (90,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor.','22/12/2013','Nullam ut',9,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (91,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan','20/01/2014','ultrices posuere cubilia Curae;',2,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (92,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor.','31/07/2013','cursus purus.',8,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (93,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut','13/08/2013','Nullam',4,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (94,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis','31/01/2014','diam vel arcu.',6,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (95,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu','04/09/2013','Curabitur ut',4,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (96,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper','02/12/2013','molestie dapibus',7,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (97,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat.','20/12/2013','at',11,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (98,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida','22/10/2013','ligula.',8,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (99,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus.','25/02/2014','Class aptent taciti',5,'Delivery');
INSERT INTO Report (idReport,content,completionDate,name,idPerson,type) VALUES (100,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum.','04/01/2014','nunc risus varius',8,'Delivery');

INSERT INTO Building (idBuilding,zipCode,address,idPerson) VALUES (1,'3050-011,Aveiro','546-1778 Aliquet Rd.',12);
INSERT INTO Building (idBuilding,zipCode,address,idPerson) VALUES (2,'7600-122,Beja','Ap #939-8354 Nibh St.',2);
INSERT INTO Building (idBuilding,zipCode,address,idPerson) VALUES (3,'4620-525,Braga','P.O. Box 412, 9850 Pharetra. St.',3);
INSERT INTO Building (idBuilding,zipCode,address,idPerson) VALUES (4,'5140-202,Braganca','Ap #511-5300 Non Avenue',4);
INSERT INTO Building (idBuilding,zipCode,address,idPerson) VALUES (5,'3430-001,Viseu','7833 Diam Road',5);
INSERT INTO Building (idBuilding,zipCode,address,idPerson) VALUES (6,'3000-042,Coimbra','P.O. Box 670, 6021 Congue, Rd.',6);
INSERT INTO Building (idBuilding,zipCode,address,idPerson) VALUES (7,'7000-092,Evora','Ap #792-835 At, St.',7);
INSERT INTO Building (idBuilding,zipCode,address,idPerson) VALUES (8,'8000-146,Faro','P.O. Box 724, 2822 Laoreet St.',8);
INSERT INTO Building (idBuilding,zipCode,address,idPerson) VALUES (9,'1000-209,Lisboa','2630 Ante St.',9);
INSERT INTO Building (idBuilding,zipCode,address,idPerson) VALUES (10,'4000-224,Porto','Ap #626-4168 Nec Street',10);
INSERT INTO Building (idBuilding,zipCode,address,idPerson) VALUES (11,'4900-290,Viana do Castelo','Ap #103-2097 Ornare Rd.',11);

INSERT INTO Storage (idBuilding) VALUES (1);
INSERT INTO Storage (idBuilding) VALUES (2);

INSERT INTO PointOfSale (idBuilding) VALUES (3);
INSERT INTO PointOfSale (idBuilding) VALUES (4);
INSERT INTO PointOfSale (idBuilding) VALUES (5);
INSERT INTO PointOfSale (idBuilding) VALUES (6);
INSERT INTO PointOfSale (idBuilding) VALUES (7);
INSERT INTO PointOfSale (idBuilding) VALUES (8);
INSERT INTO PointOfSale (idBuilding) VALUES (9);
INSERT INTO PointOfSale (idBuilding) VALUES (10);
INSERT INTO PointOfSale (idBuilding) VALUES (11);

INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (1,'category','07/11/2014','ante, iaculis nec, eleifend non, dapibus rutrum, justo. Praesent luctus.','C:\Users\Joao\Desktop\name.jpg','et,','17,395');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (2,'category','10/12/2014','augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum.','C:\Users\Joao\Desktop\name.jpg','Sed','11,059');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (3,'category','01/09/2014','lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at','C:\Users\Joao\Desktop\name.jpg','sit','15,871');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (4,'category','23/11/2014','tellus justo sit amet nulla. Donec non justo. Proin non','C:\Users\Joao\Desktop\name.jpg','primis','9,152');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (5,'category','21/04/2014','tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget','C:\Users\Joao\Desktop\name.jpg','lobortis','7,291');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (6,'category','20/10/2014','Nunc mauris sapien, cursus in, hendrerit consectetuer, cursus et, magna.','C:\Users\Joao\Desktop\name.jpg','eu','14,545');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (7,'category','17/12/2014','leo, in lobortis tellus justo sit amet nulla. Donec non','C:\Users\Joao\Desktop\name.jpg','molestie','7,830');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (8,'category','09/09/2014','arcu iaculis enim, sit amet ornare lectus justo eu arcu.','C:\Users\Joao\Desktop\name.jpg','a','17,099');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (9,'category','23/10/2014','tempus scelerisque, lorem ipsum sodales purus, in molestie tortor nibh','C:\Users\Joao\Desktop\name.jpg','amet','7,486');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (10,'category','05/04/2014','nunc sed pede. Cum sociis natoque penatibus et magnis dis','C:\Users\Joao\Desktop\name.jpg','in','18,381');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (11,'category','22/02/2015','augue id ante dictum cursus. Nunc mauris elit, dictum eu,','C:\Users\Joao\Desktop\name.jpg','amet','9,263');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (12,'category','12/11/2014','vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non','C:\Users\Joao\Desktop\name.jpg','odio.','13,494');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (13,'category','30/07/2014','nunc sit amet metus. Aliquam erat volutpat. Nulla facilisis. Suspendisse','C:\Users\Joao\Desktop\name.jpg','tellus.','13,612');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (14,'category','08/08/2014','orci, adipiscing non, luctus sit amet, faucibus ut, nulla. Cras','C:\Users\Joao\Desktop\name.jpg','ac','16,277');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (15,'category','07/02/2015','et tristique pellentesque, tellus sem mollis dui, in sodales elit','C:\Users\Joao\Desktop\name.jpg','Donec','11,762');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (16,'category','17/03/2015','consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus.','C:\Users\Joao\Desktop\name.jpg','laoreet','15,461');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (17,'category','06/02/2015','metus. In nec orci. Donec nibh. Quisque nonummy ipsum non','C:\Users\Joao\Desktop\name.jpg','magnis','6,203');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (18,'category','03/09/2014','consectetuer rhoncus. Nullam velit dui, semper et, lacinia vitae, sodales','C:\Users\Joao\Desktop\name.jpg','nascetur','17,829');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (19,'category','28/02/2015','nonummy. Fusce fermentum fermentum arcu. Vestibulum ante ipsum primis in','C:\Users\Joao\Desktop\name.jpg','nulla','13,829');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (20,'category','07/06/2014','pede sagittis augue, eu tempor erat neque non quam. Pellentesque','C:\Users\Joao\Desktop\name.jpg','Aenean','11,387');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (21,'category','15/01/2015','Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio.','C:\Users\Joao\Desktop\name.jpg','egestas','19,612');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (22,'category','24/11/2014','orci. Ut semper pretium neque. Morbi quis urna. Nunc quis','C:\Users\Joao\Desktop\name.jpg','velit.','5,281');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (23,'category','26/09/2014','interdum. Nunc sollicitudin commodo ipsum. Suspendisse non leo. Vivamus nibh','C:\Users\Joao\Desktop\name.jpg','parturient','15,364');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (24,'category','30/11/2014','nisi dictum augue malesuada malesuada. Integer id magna et ipsum','C:\Users\Joao\Desktop\name.jpg','magna.','5,283');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (25,'category','17/03/2015','ligula elit, pretium et, rutrum non, hendrerit id, ante. Nunc','C:\Users\Joao\Desktop\name.jpg','enim,','6,869');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (26,'category','13/07/2014','bibendum ullamcorper. Duis cursus, diam at pretium aliquet, metus urna','C:\Users\Joao\Desktop\name.jpg','massa.','15,308');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (27,'category','11/12/2014','luctus sit amet, faucibus ut, nulla. Cras eu tellus eu','C:\Users\Joao\Desktop\name.jpg','euismod','10,123');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (28,'category','07/06/2014','non, luctus sit amet, faucibus ut, nulla. Cras eu tellus','C:\Users\Joao\Desktop\name.jpg','dolor,','8,517');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (29,'category','01/06/2014','mi. Aliquam gravida mauris ut mi. Duis risus odio, auctor','C:\Users\Joao\Desktop\name.jpg','fermentum','18,182');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (30,'category','05/10/2014','Mauris molestie pharetra nibh. Aliquam ornare, libero at auctor ullamcorper,','C:\Users\Joao\Desktop\name.jpg','semper','12,547');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (31,'category','01/05/2014','vel, mauris. Integer sem elit, pharetra ut, pharetra sed, hendrerit','C:\Users\Joao\Desktop\name.jpg','cursus.','12,109');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (32,'category','19/11/2014','turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi','C:\Users\Joao\Desktop\name.jpg','enim,','14,529');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (33,'category','29/11/2014','at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit','C:\Users\Joao\Desktop\name.jpg','sit','18,841');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (34,'category','25/03/2015','bibendum sed, est. Nunc laoreet lectus quis massa. Mauris vestibulum,','C:\Users\Joao\Desktop\name.jpg','auctor','9,333');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (35,'category','24/05/2014','magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus.','C:\Users\Joao\Desktop\name.jpg','erat,','14,489');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (36,'category','29/10/2014','Aliquam tincidunt, nunc ac mattis ornare, lectus ante dictum mi,','C:\Users\Joao\Desktop\name.jpg','Duis','17,388');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (37,'category','09/10/2014','et malesuada fames ac turpis egestas. Fusce aliquet magna a','C:\Users\Joao\Desktop\name.jpg','Morbi','7,115');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (38,'category','01/11/2014','nec, imperdiet nec, leo. Morbi neque tellus, imperdiet non, vestibulum','C:\Users\Joao\Desktop\name.jpg','tristique','8,620');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (39,'category','30/06/2014','amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing','C:\Users\Joao\Desktop\name.jpg','eget','13,490');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (40,'category','21/05/2014','quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed','C:\Users\Joao\Desktop\name.jpg','porttitor','5,173');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (41,'category','25/07/2014','fringilla est. Mauris eu turpis. Nulla aliquet. Proin velit. Sed','C:\Users\Joao\Desktop\name.jpg','ut','10,872');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (42,'category','27/05/2014','rutrum urna, nec luctus felis purus ac tellus. Suspendisse sed','C:\Users\Joao\Desktop\name.jpg','lacus','15,597');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (43,'category','02/05/2014','amet, consectetuer adipiscing elit. Aliquam auctor, velit eget laoreet posuere,','C:\Users\Joao\Desktop\name.jpg','quis','6,033');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (44,'category','04/07/2014','a, facilisis non, bibendum sed, est. Nunc laoreet lectus quis','C:\Users\Joao\Desktop\name.jpg','ipsum.','13,255');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (45,'category','17/08/2014','Nullam feugiat placerat velit. Quisque varius. Nam porttitor scelerisque neque.','C:\Users\Joao\Desktop\name.jpg','est,','18,893');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (46,'category','30/11/2014','ornare sagittis felis. Donec tempor, est ac mattis semper, dui','C:\Users\Joao\Desktop\name.jpg','elit.','18,177');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (47,'category','27/01/2015','nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante','C:\Users\Joao\Desktop\name.jpg','ut','8,003');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (48,'category','20/10/2014','senectus et netus et malesuada fames ac turpis egestas. Fusce','C:\Users\Joao\Desktop\name.jpg','cursus','15,107');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (49,'category','12/08/2014','egestas hendrerit neque. In ornare sagittis felis. Donec tempor, est','C:\Users\Joao\Desktop\name.jpg','magna.','12,160');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (50,'category','20/05/2014','neque sed dictum eleifend, nunc risus varius orci, in consequat','C:\Users\Joao\Desktop\name.jpg','odio.','12,707');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (51,'category','13/08/2014','consequat dolor vitae dolor. Donec fringilla. Donec feugiat metus sit','C:\Users\Joao\Desktop\name.jpg','ac','9,526');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (52,'category','25/02/2015','sit amet nulla. Donec non justo. Proin non massa non','C:\Users\Joao\Desktop\name.jpg','mollis','16,771');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (53,'category','21/03/2015','luctus. Curabitur egestas nunc sed libero. Proin sed turpis nec','C:\Users\Joao\Desktop\name.jpg','orci.','7,022');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (54,'category','09/12/2014','fringilla mi lacinia mattis. Integer eu lacus. Quisque imperdiet, erat','C:\Users\Joao\Desktop\name.jpg','tellus.','7,455');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (55,'category','05/07/2014','tincidunt, neque vitae semper egestas, urna justo faucibus lectus, a','C:\Users\Joao\Desktop\name.jpg','dui,','11,575');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (56,'category','12/10/2014','quis accumsan convallis, ante lectus convallis est, vitae sodales nisi','C:\Users\Joao\Desktop\name.jpg','Suspendisse','5,736');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (57,'category','29/10/2014','enim nec tempus scelerisque, lorem ipsum sodales purus, in molestie','C:\Users\Joao\Desktop\name.jpg','vel,','6,457');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (58,'category','02/11/2014','tristique ac, eleifend vitae, erat. Vivamus nisi. Mauris nulla. Integer','C:\Users\Joao\Desktop\name.jpg','tincidunt.','19,731');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (59,'category','07/02/2015','lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit amet','C:\Users\Joao\Desktop\name.jpg','eu','10,464');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (60,'category','03/04/2014','nulla. Donec non justo. Proin non massa non ante bibendum','C:\Users\Joao\Desktop\name.jpg','nec,','6,360');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (61,'category','03/01/2015','dignissim pharetra. Nam ac nulla. In tincidunt congue turpis. In','C:\Users\Joao\Desktop\name.jpg','dapibus','13,952');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (62,'category','24/10/2014','id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis','C:\Users\Joao\Desktop\name.jpg','ut,','18,620');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (63,'category','28/01/2015','posuere cubilia Curae; Phasellus ornare. Fusce mollis. Duis sit amet','C:\Users\Joao\Desktop\name.jpg','Nullam','7,566');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (64,'category','09/02/2015','egestas nunc sed libero. Proin sed turpis nec mauris blandit','C:\Users\Joao\Desktop\name.jpg','blandit.','18,353');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (65,'category','22/02/2015','purus mauris a nunc. In at pede. Cras vulputate velit','C:\Users\Joao\Desktop\name.jpg','elit','18,321');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (66,'category','11/09/2014','egestas. Fusce aliquet magna a neque. Nullam ut nisi a','C:\Users\Joao\Desktop\name.jpg','cursus','19,512');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (67,'category','19/06/2014','sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna.','C:\Users\Joao\Desktop\name.jpg','rutrum.','8,359');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (68,'category','07/06/2014','neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris eu turpis.','C:\Users\Joao\Desktop\name.jpg','aliquet,','12,756');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (69,'category','20/08/2014','nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus','C:\Users\Joao\Desktop\name.jpg','est','19,946');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (70,'category','26/06/2014','orci. Ut semper pretium neque. Morbi quis urna. Nunc quis','C:\Users\Joao\Desktop\name.jpg','Vivamus','13,467');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (71,'category','19/01/2015','auctor ullamcorper, nisl arcu iaculis enim, sit amet ornare lectus','C:\Users\Joao\Desktop\name.jpg','eu,','17,689');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (72,'category','26/08/2014','Fusce aliquet magna a neque. Nullam ut nisi a odio','C:\Users\Joao\Desktop\name.jpg','massa','6,441');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (73,'category','19/08/2014','ipsum. Suspendisse sagittis. Nullam vitae diam. Proin dolor. Nulla semper','C:\Users\Joao\Desktop\name.jpg','at,','8,231');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (74,'category','03/04/2014','id ante dictum cursus. Nunc mauris elit, dictum eu, eleifend','C:\Users\Joao\Desktop\name.jpg','diam','11,138');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (75,'category','23/07/2014','amet massa. Quisque porttitor eros nec tellus. Nunc lectus pede,','C:\Users\Joao\Desktop\name.jpg','neque','7,842');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (76,'category','06/04/2014','lectus rutrum urna, nec luctus felis purus ac tellus. Suspendisse','C:\Users\Joao\Desktop\name.jpg','nisl','7,020');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (77,'category','26/09/2014','nulla vulputate dui, nec tempus mauris erat eget ipsum. Suspendisse','C:\Users\Joao\Desktop\name.jpg','eu','8,836');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (78,'category','14/07/2014','ridiculus mus. Proin vel arcu eu odio tristique pharetra. Quisque','C:\Users\Joao\Desktop\name.jpg','facilisis,','19,355');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (79,'category','11/06/2014','dapibus quam quis diam. Pellentesque habitant morbi tristique senectus et','C:\Users\Joao\Desktop\name.jpg','ultrices.','16,007');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (80,'category','06/06/2014','eros non enim commodo hendrerit. Donec porttitor tellus non magna.','C:\Users\Joao\Desktop\name.jpg','vel','15,018');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (81,'category','25/02/2015','risus. Nulla eget metus eu erat semper rutrum. Fusce dolor','C:\Users\Joao\Desktop\name.jpg','ipsum.','11,813');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (82,'category','15/11/2014','In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas.','C:\Users\Joao\Desktop\name.jpg','pharetra','9,059');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (83,'category','01/06/2014','Mauris eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue','C:\Users\Joao\Desktop\name.jpg','molestie','9,937');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (84,'category','19/03/2015','Donec tincidunt. Donec vitae erat vel pede blandit congue. In','C:\Users\Joao\Desktop\name.jpg','auctor','18,330');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (85,'category','22/09/2014','justo. Praesent luctus. Curabitur egestas nunc sed libero. Proin sed','C:\Users\Joao\Desktop\name.jpg','Aenean','19,671');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (86,'category','25/11/2014','Ut tincidunt orci quis lectus. Nullam suscipit, est ac facilisis','C:\Users\Joao\Desktop\name.jpg','amet,','11,041');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (87,'category','15/02/2015','Integer sem elit, pharetra ut, pharetra sed, hendrerit a, arcu.','C:\Users\Joao\Desktop\name.jpg','varius','9,165');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (88,'category','01/08/2014','Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas','C:\Users\Joao\Desktop\name.jpg','sem','18,726');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (89,'category','13/04/2014','et, rutrum eu, ultrices sit amet, risus. Donec nibh enim,','C:\Users\Joao\Desktop\name.jpg','lacus.','19,640');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (90,'category','20/02/2015','id nunc interdum feugiat. Sed nec metus facilisis lorem tristique','C:\Users\Joao\Desktop\name.jpg','scelerisque','16,932');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (91,'category','19/04/2014','neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede','C:\Users\Joao\Desktop\name.jpg','Nunc','19,773');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (92,'category','28/05/2014','rhoncus id, mollis nec, cursus a, enim. Suspendisse aliquet, sem','C:\Users\Joao\Desktop\name.jpg','Nulla','19,759');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (93,'category','25/11/2014','id, blandit at, nisi. Cum sociis natoque penatibus et magnis','C:\Users\Joao\Desktop\name.jpg','augue','16,048');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (94,'category','01/07/2014','urna. Nullam lobortis quam a felis ullamcorper viverra. Maecenas iaculis','C:\Users\Joao\Desktop\name.jpg','arcu.','16,429');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (95,'category','06/12/2014','ligula. Donec luctus aliquet odio. Etiam ligula tortor, dictum eu,','C:\Users\Joao\Desktop\name.jpg','Cum','11,781');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (96,'category','05/02/2015','laoreet lectus quis massa. Mauris vestibulum, neque sed dictum eleifend,','C:\Users\Joao\Desktop\name.jpg','et','14,891');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (97,'category','22/11/2014','enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum','C:\Users\Joao\Desktop\name.jpg','natoque','8,418');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (98,'category','01/06/2014','ligula. Nullam feugiat placerat velit. Quisque varius. Nam porttitor scelerisque','C:\Users\Joao\Desktop\name.jpg','Phasellus','7,634');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (99,'category','12/11/2014','nulla magna, malesuada vel, convallis in, cursus et, eros. Proin','C:\Users\Joao\Desktop\name.jpg','ut','9,234');
INSERT INTO Product (idProduct,category,expirationDate,description,photograph,name,price) VALUES (100,'category','29/03/2014','dictum. Phasellus in felis. Nulla tempor augue ac ipsum. Phasellus','C:\Users\Joao\Desktop\name.jpg','ipsum','10,600');

INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (1,'11,342',11);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (2,'14,511',11);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (3,'7,029',8);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (4,'17,184',10);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (5,'7,593',6);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (6,'13,596',4);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (7,'5,516',8);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (8,'10,258',8);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (9,'15,436',10);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (10,'10,372',8);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (11,'14,496',4);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (12,'15,183',9);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (13,'8,264',9);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (14,'18,326',6);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (15,'12,556',9);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (16,'5,141',4);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (17,'5,227',3);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (18,'16,591',4);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (19,'9,545',7);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (20,'5,041',9);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (21,'9,829',8);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (22,'19,576',5);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (23,'11,305',10);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (24,'14,371',11);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (25,'8,065',6);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (26,'15,959',5);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (27,'19,272',6);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (28,'12,024',8);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (29,'7,513',11);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (30,'18,550',4);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (31,'15,710',6);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (32,'12,246',4);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (33,'19,099',9);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (34,'19,558',11);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (35,'14,981',4);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (36,'5,282',4);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (37,'18,608',11);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (38,'6,130',6);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (39,'14,975',10);
INSERT INTO Transaction (idTransaction,value,idPointOfSale) VALUES (40,'18,417',11);

INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (1,77);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (2,94);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (3,91);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (4,94);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (5,89);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (6,87);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (7,96);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (8,79);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (9,99);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (10,81);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (11,94);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (12,100);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (13,91);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (14,79);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (15,79);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (16,78);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (17,76);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (18,92);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (19,94);
INSERT INTO SupplierCompany (idTransaction,idPerson) VALUES (20,78);

INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (1,'20/04/2014','02/06/2014','26/08/2014',1);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (2,'03/05/2014','28/07/2014','18/08/2014',2);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (3,'22/05/2014','25/06/2014','22/08/2014',3);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (4,'11/04/2014','24/07/2014','12/08/2014',4);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (5,'09/05/2014','06/07/2014','13/08/2014',5);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (6,'29/04/2014','24/06/2014','17/08/2014',6);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (7,'12/04/2014','21/07/2014','19/08/2014',7);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (8,'14/05/2014','21/06/2014','18/08/2014',8);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (9,'31/03/2014','27/07/2014','11/08/2014',9);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (10,'18/05/2014','12/06/2014','30/08/2014',10);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (11,'21/04/2014','13/07/2014','05/08/2014',11);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (12,'25/05/2014','10/07/2014','27/08/2014',12);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (13,'15/05/2014','20/07/2014','19/08/2014',13);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (14,'29/04/2014','02/07/2014','26/08/2014',14);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (15,'13/04/2014','03/07/2014','04/08/2014',15);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (16,'09/05/2014','15/06/2014','18/08/2014',16);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (17,'20/05/2014','21/06/2014','25/08/2014',17);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (18,'19/04/2014','15/06/2014','20/08/2014',18);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (19,'20/04/2014','17/07/2014','27/08/2014',19);
INSERT INTO Orderino (idOrder,orderDate,paymentDate,deliveryDate,idSupplierCompany) VALUES (20,'17/04/2014','11/06/2014','13/08/2014',20);

INSERT INTO ProductOrder (idOrder, idProduct) VALUES (1,17);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (1,2);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (1,13);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (2,19);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (2,14);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (2,1);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (3,1);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (3,4);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (3,8);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (4,2);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (4,95);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (4,26);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (5,56);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (5,23);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (5,84);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (6,59);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (6,26);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (6,16);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (7,78);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (7,58);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (7,26);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (8,89);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (8,100);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (8,6);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (9,3);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (9,95);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (9,89);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (10,95);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (10,36);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (10,20);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (11,85);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (11,6);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (11,3);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (12,20);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (13,30);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (13,63);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (14,100);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (14,62);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (14,20);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (15,3);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (15,2);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (15,1);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (16,31);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (16,63);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (16,23);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (17,36);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (17,12);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (17,2);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (18,1);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (18,3);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (18,60);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (19,31);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (19,63);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (19,23);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (20,36);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (20,69);
INSERT INTO ProductOrder (idOrder, idProduct) VALUES (20,75);

INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (1,13);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (1,26);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (1,1);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (2,98);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (2,99);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (2,46);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (3,47);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (3,78);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (3,9);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (4,25);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (4,65);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (4,85);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (5,51);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (5,3);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (5,11);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (6,10);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (6,87);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (6,73);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (7,72);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (7,55);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (7,45);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (8,23);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (8,24);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (8,33);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (9,41);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (9,39);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (9,67);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (10,100);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (10,38);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (10,37);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (11,64);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (11,20);
INSERT INTO ProductBuilding (idBuilding,idProduct) VALUES (11,74);

INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (17,3);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (18,4);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (14,5);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (16,6);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (19,7);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (49,8);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (20,9);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (39,10);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (32,11);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (15,3);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (50,4);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (13,5);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (23,6);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (42,7);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (39,8);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (14,9);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (32,10);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (35,11);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (21,3);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (39,4);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (47,5);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (38,6);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (36,7);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (43,8);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (26,9);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (50,10);
INSERT INTO ShopkeeperPointOfSale (idPerson,idBuilding) VALUES (36,11);

INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (1,13,449);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (1,26,761);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (1,1,427);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (2,98,373);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (2,99,628);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (2,46,88);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (3,47,911);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (3,78,520);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (3,9,351);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (4,25,674);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (4,65,416);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (4,85,312);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (5,51,440);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (5,3,454);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (5,11,6);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (6,10,38);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (6,87,101);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (6,73,508);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (7,72,621);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (7,55,144);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (7,45,883);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (8,23,983);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (8,24,255);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (8,33,533);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (9,41,12);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (9,39,267);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (9,67,829);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (10,100,771);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (10,38,85);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (10,37,630);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (11,64,453);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (11,20,86);
INSERT INTO Quantity (idBuilding,idProduct,quantity) VALUES (11,74,6);