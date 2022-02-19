-- Creating FilmSubscrip Database
CREATE DATABASE FilmSubscrip;

-- Using FilmSubscrip Database
USE FilmSubscrip;


-- Creating Region Table
CREATE TABLE Region (
	RegionID INTEGER NOT NULL,
	Name varchar(100) NOT NULL,
	Last_Update date NOT NULL,
	CONSTRAINT Region_PK PRIMARY KEY (RegionID)  -- Primary key
);

-- Creating Language Table
CREATE TABLE Language (
	LanguageID INTEGER NOT NULL,
	Name varchar(20) NOT NULL,
	Last_Update date NOT NULL,
	CONSTRAINT Language_PK PRIMARY KEY (LanguageID)		-- Primary key
);

-- Creating Film Table
CREATE TABLE Film (
	Film_ID INTEGER NOT NULL,
	LanguageID INTEGER NOT NULL,
	RegionID INTEGER NOT NULL,
	Title varchar(255) NOT NULL,
	Description varchar(255),
	Release_Year INTEGER NOT NULL,
	Rental_Duration INTEGER NOT NULL,
	Rental_Rate NUMERIC(19, 0) NOT NULL,
	Length INTEGER,
	Replacement_Cost NUMERIC(19, 0) NOT NULL,
	Rating INTEGER,
	Special_Features varchar(255),
	FullText_Var varchar(255),
	Last_Update date NOT NULL,	
	CONSTRAINT Film_PK PRIMARY KEY (Film_ID),	-- Primary key
	CONSTRAINT Film_FK FOREIGN KEY (LanguageID) REFERENCES Language (LanguageID),  -- Foreign key
	CONSTRAINT Film_FK_1 FOREIGN KEY (RegionID) REFERENCES Region(RegionID)			-- Foreign key
);

-- Creating Category Table
CREATE TABLE Category (
	CategoryID INTEGER NOT NULL,
	Last_Update date NOT NULL,
	Name varchar(20) NOT NULL,
	CONSTRAINT Category_PK PRIMARY KEY (CategoryID)		-- Primary Key
);

-- Creating Film_Category Table
CREATE TABLE Film_Category (
	Film_CategoryID INTEGER NOT NULL,
	Film_ID INTEGER NOT NULL,
	CategoryID INTEGER NOT NULL,
	Last_Update date NOT NULL,
	CONSTRAINT Film_Category_PK PRIMARY KEY (Film_CategoryID),	-- Primary key
	CONSTRAINT Film_Category_FK FOREIGN KEY (Film_ID) REFERENCES Film(Film_ID),	-- Foreign key
	CONSTRAINT Film_Category_FK_1 FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)	-- Foreign key
);

-- Creating Actor Table
CREATE TABLE Actor (
	ActorID INTEGER NOT NULL,
	First_Name varchar(255) NOT NULL,
	Last_Name varchar(255) NOT NULL,
	Last_Update date NOT NULL,
	CONSTRAINT Actor_PK PRIMARY KEY (ActorID)	-- Primary key
);

-- Creating Film_Actor Table
CREATE TABLE Film_Actor (
	Film_ActorID INTEGER NOT NULL,
	Film_ID INTEGER NOT NULL,
	ActorID INTEGER NOT NULL,
	Last_Update date NOT NULL,
	CONSTRAINT Film_Actor_PK PRIMARY KEY (Film_ActorID),	-- Primary key
	CONSTRAINT Film_Actor_FK FOREIGN KEY (Film_ID) REFERENCES Film(Film_ID),	-- Foreign key
	CONSTRAINT Film_Actor_FK_1 FOREIGN KEY (ActorID) REFERENCES Actor(ActorID)	-- Foreign key
);

-- Creating Directory Table
CREATE TABLE Directory (
	DirectoryID INTEGER NOT NULL,
	Film_ID INTEGER NOT NULL,
	Last_Update date NOT NULL,
	CONSTRAINT Directory_PK PRIMARY KEY (DirectoryID),		-- Primary key
	CONSTRAINT Directory_FK FOREIGN KEY (Film_ID) REFERENCES Film(Film_ID)	-- Foreign key
);

-- Creating Country Table
CREATE TABLE Country (
	CountryID INTEGER NOT NULL,
	Country_Name varchar(255) NOT NULL,
	Last_Update date NOT NULL,
	CONSTRAINT Country_PK PRIMARY KEY (CountryID)		-- Primary key
);

-- Creating City Table
CREATE TABLE City (
	CityID INTEGER NOT NULL,	
	CountryID INTEGER NOT NULL,
	City_Name varchar(255) NOT NULL,
	Last_Update date NOT NULL,
	CONSTRAINT City_PK PRIMARY KEY (CityID),		-- Primary key
	CONSTRAINT City_FK FOREIGN KEY (CountryID) REFERENCES Country(CountryID)	-- Foreign key
);

-- Creating Address Table
CREATE TABLE Address (
	AddressID INTEGER NOT NULL,
	CityID INTEGER NOT NULL,
	Address1 varchar(50) NOT NULL,
	Address2 varchar(50),
	District INTEGER NOT NULL,
	Postal_Code varchar(10) NOT NULL,
	Phone varchar(20),
	Last_Update date NOT NULL,
	CONSTRAINT Address_PK PRIMARY KEY (AddressID),		-- Primary key
	CONSTRAINT Address_FK FOREIGN KEY (CityID) REFERENCES City(CityID)	-- Foreign key
);

-- Creating Store Table
CREATE TABLE Store (
	StoreID INTEGER NOT NULL,
	AddressID INTEGER NOT NULL,
	Last_Update date NOT NULL,
	CONSTRAINT Store_PK PRIMARY KEY (StoreID),		-- Primary key
	CONSTRAINT Store_FK FOREIGN KEY (AddressID) REFERENCES Address(AddressID)	-- Foreign key
);

-- Creating Staff Table
CREATE TABLE Staff (
	StaffID INTEGER NOT NULL,
	StoreID INTEGER NOT NULL,
	AddressID INTEGER NOT NULL,
	First_Name varchar(255) NOT NULL,
	Last_Name varchar(255) NOT NULL,
	Email varchar(50) NOT NULL,
	Active Char,
	Password varchar(40) NOT NULL,
	PictureURL varchar(80),
	Last_Update datetime NOT NULL,
	CONSTRAINT Staff_PK PRIMARY KEY (StaffID),		-- Primary key
	CONSTRAINT Staff_FK FOREIGN KEY (StoreID) REFERENCES Store(StoreID),	-- Foreign key
	CONSTRAINT Staff_FK_1 FOREIGN KEY (AddressID) REFERENCES Address(AddressID)	-- Foreign key
);

-- Creating Bought_Items Table
CREATE TABLE Bought_Items (
	Bought_ItemsID INTEGER NOT NULL,
	Item_Name varchar(255) NOT NULL,
	Last_Update date NOT NULL,
	CONSTRAINT Bought_Items_PK PRIMARY KEY (Bought_ItemsID)	-- Primary key
);

-- Creating Customer Table
CREATE TABLE Customer (
	CustomerID INTEGER NOT NULL,
	AddressID INTEGER NOT NULL,
	Bought_ItemsID INTEGER NOT NULL,
	AddressColumn INTEGER,
	First_Name varchar(255) NOT NULL,
	Last_Name varchar(255) NOT NULL,
	Email varchar(50) NOT NULL,
	Active Char(1),
	Create_Date date NOT NULL,
	Last_Update date NOT NULL,
	CONSTRAINT Customer_PK PRIMARY KEY (CustomerID),	-- Primary key
	CONSTRAINT Customer_FK FOREIGN KEY (Bought_ItemsID) REFERENCES Bought_Items(Bought_ItemsID),	-- Foreign key
	CONSTRAINT Customer_FK_1 FOREIGN KEY (AddressID) REFERENCES Address(AddressID)			-- Foreign key
);

-- Creating Subscription Table
CREATE TABLE Subscription (
	SubscriptionID INTEGER NOT NULL,
	DirectoryID INTEGER NOT NULL,
	StaffID INTEGER NOT NULL,
	CustomerID INTEGER NOT NULL,
	Rental_Date date NOT NULL,
	Return_Date date NOT NULL,
	Last_Update date NOT NULL,
	CONSTRAINT Subscription_PK PRIMARY KEY (SubscriptionID),	-- Primary key
	CONSTRAINT Subscription_FK FOREIGN KEY (DirectoryID) REFERENCES Directory(DirectoryID), -- Foreign key
	CONSTRAINT Subscription_FK_1 FOREIGN KEY (StaffID) REFERENCES Staff(StaffID), -- Foreign key
	CONSTRAINT Subscription_FK_2 FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)	-- Foreign key
);

-- Creating CategoryC Table
CREATE TABLE CategoryC (
	CategoryCID INTEGER NOT NULL,
	Name varchar(255) NOT NULL,
	Last_Update date NOT NULL,
	CONSTRAINT CategoryC_PK PRIMARY KEY (CategoryCID)	-- Primary Key
);

-- Creating Customer_Category Table
CREATE TABLE Customer_Category (
	Customer_CategoryID INTEGER NOT NULL,	
	CustomerID INTEGER NOT NULL,
	CategoryCID INTEGER NOT NULL,
	Last_Update date NOT NULL,
	CONSTRAINT Customer_Category_PK PRIMARY KEY (Customer_CategoryID),	-- Primary Key
	CONSTRAINT Customer_Category_FK FOREIGN KEY (CategoryCID) REFERENCES CategoryC(CategoryCID),	-- Foreign Key
	CONSTRAINT Customer_Category_FK_1 FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)		-- Foreign Key
);

-- Creating Payment Table
CREATE TABLE Payment (
	PaymentID INTEGER NOT NULL,
	SubscriptionID INTEGER NOT NULL,
	CustomerID INTEGER NOT NULL,
	StaffID INTEGER NOT NULL,
	Amount NUMERIC NOT NULL,
	Payment_Date date NOT NULL,
	CONSTRAINT Payment_PK PRIMARY KEY (PaymentID),		-- Primary Key
	CONSTRAINT Payment_FK FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID),	-- Foreign Key
	CONSTRAINT Payment_FK_1 FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),			-- Foreign Key
	CONSTRAINT Payment_FK_2 FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)	-- Foreign Key
);



-- Applying CRUD Operation on Region Table

-- Insert
INSERT INTO Region(RegionID, Name, Last_Update)
VALUES
(1, 'South-Central Asia', '2015-12-25'),
(2, 'Balkan Peninsula', '2015-12-25'),
(3, 'Northern Africa', '2015-12-25'),
(4, 'Polynesia, Oceania', '2015-12-25'),
(5, 'Southern Europe', '2015-12-25'),
(6, 'Central Africa', '2015-12-25'),
(7, 'Leeward Islands, Caribbean', '2015-12-25'),
(8, 'Antarctica', '2015-12-25'),
(9, 'Leeward Islands, Caribbean', '2015-12-25'),
(10, 'Western Asia', '2015-12-25');

-- Update
UPDATE Region 
SET Last_Update = '2022-05-17'
WHERE RegionID = 5;

-- Delete
DELETE FROM Region
WHERE RegionID = 8;

-- Read
SELECT * FROM Region;

-- Applying CRUD Operation on Language Table

-- Insert
INSERT INTO Language(LanguageID , Name, Last_Update)
VALUES
(1, 'ENGLISH', '2021-05-16'),
(2, 'URDU', '2021-05-16'),
(3, 'SPANISH', '2022-05-18'),
(4, 'RUSSIAN', '2021-05-24'),
(5, 'CHINESE', '2012-05-16'),
(6, 'HINDHI', '2021-05-16'),
(7, 'PASHTO', '2021-05-16'),
(8, 'PANJABI', '2022-05-18'),
(9, 'SINDHI', '2021-05-24'),
(10, 'SPANISH', '2012-05-16');

-- Update
UPDATE Language
SET Name = 'PURE HINDHI'
WHERE Name = 'HINDHI';

-- Delete
DELETE FROM Language
WHERE LanguageID = 10;

-- Read
SELECT * FROM Language;

-- Applying CRUD Operation on Film Table
INSERT INTO Film(Film_ID, LanguageID, RegionID, Title, Description, Release_Year, 
Rental_Duration, Rental_Rate, Length, Replacement_Cost, Rating, Special_Features, 
FullText_Var, Last_Update)
VALUES
(1, 2, 1, 'Movie1', 'Description1', 2004, 25, 2500, 50, 20, 5, 'SpecialFeature1', 'FullText1', '2022-05-20'),
(2, 4, 3, 'Movie2', 'Description2', 2005, 35, 3500, 60, 22, 8, 'SpecialFeature2', 'FullText2', '2015-05-12'),
(3, 6, 5, 'Movie3', 'Description3', 2008, 45, 4500, 70, 24, 6, 'SpecialFeature3', 'FullText3', '2014-05-14'),
(4, 8, 7, 'Movie4', 'Description4', 2010, 55, 5500, 80, 60, 2, 'SpecialFeature4', 'FullText4', '2021-05-17'),
(5, 1, 9, 'Movie5', 'Description5', 2004, 65, 6500, 90, 80, 6, 'SpecialFeature5', 'FullText5', '2016-05-17'),
(6, 1, 2, 'Movie6', 'Description6', 2015, 75, 7500, 100, 50, 5, 'SpecialFeature6', 'FullText6', '2021-09-29'),
(7, 3, 4, 'Movie7', 'Description7', 2018, 85, 8500, 150, 90, 4, 'SpecialFeature7', 'FullText7', '2020-05-19'),
(8, 5, 6, 'Movie8', 'Description8', 2014, 95, 9500, 120, 40, 90, 'SpecialFeature8', 'FullText8', '2021-04-19');

-- Update
UPDATE Film
SET Title = 'MovieUpdate'
WHERE Film_ID = 4;

-- Delete
DELETE FROM Film
WHERE Film_ID = 4;

-- Read
SELECT * FROM Film;


-- Applying CRUD Operation on Category Table

-- Insert
INSERT INTO Category(CategoryID, Last_Update, Name)
VALUES
(1, '2022-05-08', 'High'),
(2, '2021-06-09', 'Low'),
(3, '2015-07-10', 'High'),
(4, '2014-10-11', 'Medium'),
(5, '2018-12-12', 'High'),
(6, '2012-05-13', 'Medium'),
(7, '2011-05-08', 'High'),
(8, '2009-12-28', 'Low'),
(9, '2022-11-08', 'High'),
(10, '2008-05-18', 'Low');

-- Update
UPDATE Category
SET Name = 'Medium'
WHERE CategoryID = 10;

-- Delete
DELETE FROM Category
Where CategoryID = 10;

-- Read
SELECT * FROM Category;

-- Applying CRUD Operation on Film_Category Table

-- Insert
INSERT INTO Film_Category(Film_CategoryID, Film_ID, CategoryID, Last_Update)
VALUES
(1, 1, 1, '2022-05-12'), 
(2, 3, 3, '2015-03-19'), 
(3, 5, 5, '2014-06-15'), 
(4, 2, 7, '2018-07-19'), 
(5, 1, 2, '2009-08-19'), 
(6, 3, 4, '2022-08-19'), 
(7, 2, 6, '2023-05-12'), 
(8, 5, 8, '2022-09-09'), 
(9, 2, 1, '2005-05-19'), 
(10, 1, 3, '2021-05-29'); 

-- Update
UPDATE Film_Category
SET Film_ID = 2
WHERE Film_ID = 1;

-- Delete
DELETE FROM Film_Category
WHERE Film_CategoryID = 5;

-- Read
SELECT * FROM Film_Category;

-- Applying CRUD Operation on Actor Table

-- Insert
INSERT INTO Actor(ActorID, First_Name, Last_Name, Last_Update)
VALUES
(1, 'Sam', 'Jhon', '2022-05-12'), 
(2, 'Eza', 'Elsa', '2015-03-19'), 
(3, 'Ali', 'Mahnnor', '2014-06-15'), 
(4, 'David', 'Eza', '2018-07-19'), 
(5, 'Ali', 'Khan', '2009-08-19'), 
(6, 'Ela', 'Ali', '2022-08-19'), 
(7, 'Jhon', 'Sam', '2023-05-12'), 
(8, 'David', 'Khan', '2022-09-09'), 
(9, 'Sam', 'David', '2005-05-19'), 
(10, 'Elizibeth', 'Sam', '2021-05-29'); 

-- Update
UPDATE Actor 
SET First_Name = 'Sami'
WHERE ActorID = 1;

-- Delete
DELETE FROM Actor
WHERE ActorID = 9;

-- Read
SELECT * FROM Actor;

-- Applying CRUD Operation on Film_Actor Table

-- Insert
INSERT INTO Film_Actor(Film_ActorID , Film_ID, ActorID, Last_Update)
VALUES
(1, 1, 1, '2022-05-12'), 
(2, 3, 3, '2015-03-19'), 
(3, 2, 5, '2014-06-15'), 
(4, 5, 7, '2018-07-19'), 
(5, 1, 2, '2009-08-19'), 
(6, 3, 4, '2022-08-19'), 
(7, 2, 6, '2023-05-12'), 
(8, 5, 8, '2022-09-09'), 
(9, 3, 10, '2005-05-19'), 
(10, 2, 2, '2021-05-29'); 

-- Update
UPDATE Film_Actor
SET ActorID = 5
WHERE Film_ActorID = 9;

-- Delete
DELETE FROM Film_Actor
WHERE Film_ActorID = 9;

-- Read
SELECT * FROM Film_Actor;

-- Applying CRUD Operation on Directory Table

-- Insert
INSERT INTO Directory(DirectoryID, Film_ID, Last_Update)
VALUES
(1, 1, '2022-05-12'), 
(2, 3,'2015-03-19'), 
(3, 2,'2014-06-15'), 
(4, 5,'2018-07-19'), 
(5, 1,'2009-08-19'), 
(6, 3,'2022-08-19'), 
(7, 2,'2023-05-12'), 
(8, 5,'2022-09-09'), 
(9, 3, '2005-05-19'), 
(10, 2,'2021-05-29'); 

-- Update
UPDATE Directory
SET Last_Update = '2021-05-09'
WHERE DirectoryID = 7; 

-- Delete
DELETE FROM Directory
WHERE DirectoryID = 7;

-- Read
SELECT * FROM Directory;

-- Applying CRUD Operation on Country Table

-- Insert
INSERT INTO Country(CountryID, Country_Name, Last_Update)
VALUES
(1, 'Canada', '2022-05-12'), 
(2, 'Bngladesh','2015-03-19'), 
(3, 'Afghanistan','2014-06-15'), 
(4, 'China','2018-07-19'), 
(5, 'Nipal','2009-08-19'), 
(6, 'Pakistan','2022-08-19'), 
(7, 'Spain','2023-05-12'), 
(8, 'Europe','2022-09-09'), 
(9, 'Germany', '2005-05-19'), 
(10, 'Columbo','2021-05-29'); 

-- Update
UPDATE Country
SET Last_Update = '2021-05-08'
WHERE CountryID = 2;

-- Delete
DELETE FROM Country
WHERE CountryID = 2;

-- Read
SELECT * FROM Country;

-- Applying CRUD Operation on Country Table

-- Insert
INSERT INTO City(CityID, CountryID, City_Name, Last_Update)
VALUES
(1, 1, 'Vancuover', '2022-05-12'), 
(2, 3, 'Toronto', '2015-03-19'), 
(3, 8, 'Karachi', '2014-06-15'), 
(4, 5, 'Islamabad', '2018-07-19'), 
(5, 1, 'Washington', '2009-08-19'), 
(6, 3, 'Atlanta', '2022-08-19'), 
(7, 7, 'Lahore', '2023-05-12'), 
(8, 5, 'Calegary', '2022-09-09'), 
(9, 3, 'Texas', '2005-05-19'), 
(10, 9, 'Melbourne', '2021-05-29'); 

-- Update
UPDATE City
SET CountryID = 4
WHERE CityID =1;

-- Delete
DELETE FROM City
WHERE CityID = 1;

-- Read
SELECT * FROM City;

-- Applying CRUD Operation on Address Table

-- Insert
INSERT INTO Address(AddressID, CityID, Address1, Address2, District, Postal_Code, Phone, Last_Update)
VALUES
(1, 4, 'Address1.1', 'Address1.2', 5, '78612', '1234567896', '2022-05-12'), 
(2, 3, 'Address2.1', 'Address2.2', 6, '78613', '4564567896', '2015-03-19'), 
(3, 8, 'Address3.1', 'Address3.2', 7, '78614', '7864567896', '2014-06-15'), 
(4, 5, 'Address4.1', 'Address4.2', 8, '78615', '4464567896', '2018-07-19'), 
(5, 4, 'Address5.1', 'Address5.2', 12, '78616', '4564567896', '2009-08-19'), 
(6, 3, 'Address6.1', 'Address6.2', 15, '78617', '5554567896', '2022-08-19'), 
(7, 7, 'Address7.1', 'Address7.2', 18, '78618', '3654567896', '2023-05-12'), 
(8, 5, 'Address8.1', 'Address8.2', 54, '78619', '5484567896', '2022-09-09'), 
(9, 3, 'Address9.1', 'Address9.2', 51, '78612', '5454567896', '2005-05-19'), 
(10, 9, 'Address10.1', 'Address10.2', 115, '78610', '8884567896', '2021-05-29'); 

-- Update
UPDATE Address
SET CityID = 9
WHERE CityID = 4;

-- Delete
DELETE FROM Address
WHERE AddressID = 7;

-- Read
SELECT * FROM Address;

-- Applying CRUD Operation on Store Table

-- Insert
INSERT INTO Store(StoreID, AddressID, Last_Update)
VALUES
(1, 1, '2022-05-12'), 
(2, 3,'2015-03-19'), 
(3, 2,'2014-06-15'), 
(4, 5,'2018-07-19'), 
(5, 1,'2009-08-19'), 
(6, 3,'2022-08-19'), 
(7, 2,'2023-05-12'), 
(8, 5,'2022-09-09'), 
(9, 3, '2005-05-19'), 
(10, 2,'2021-05-29'); 

-- Update
UPDATE Store
SET Last_Update = '2021-04-04'
WHERE StoreID = 1;

-- Delete
DELETE FROM Store
WHERE StoreID = 4;

-- Read
SELECT * FROM Store;

-- Applying CRUD Operation on Staff Table

-- Insert
INSERT INTO Staff(StaffID, StoreID, AddressID, First_Name, Last_Name, Email, Active, 
Password, PictureURL, Last_Update)
VALUES
(1, 2, 1, 'Sam', 'Jhon', 'sam@gmail.com', 'Y' , '123', 'https//pic1.com', '2022-05-12'), 
(2, 5, 3, 'Eza', 'Elsa', 'eza@gmail.com', 'N' , '456', 'https//pic2.com','2015-03-19'), 
(3, 6, 5, 'Ali', 'Mahnnor', 'ali@gmail.com', 'Y' , '789', 'https//pic3.com','2014-06-15'), 
(4, 8, 4, 'David', 'Eza', 'david@gmail.com', 'N' , '741', 'https//pic4.com','2018-07-19'), 
(5, 10, 9, 'Ali', 'Khan', 'khan@gmail.com', 'Y' , '258', 'https//pic5.com','2009-08-19'), 
(6, 1, 2, 'Ela', 'Ali', 'ela@gmail.com', 'Y' , '963', 'https//pic6.com', '2022-08-19'), 
(7, 3, 4, 'Jhon', 'Sam', 'jhon@gmail.com',  'N' , '145', 'https//pic7.com', '2023-05-12'), 
(8, 5, 6, 'David', 'Khan', 'david@gmail.com', 'Y' , '659', 'https//pic8.com', '2022-09-09'), 
(9, 7, 8, 'Sam', 'David', 'khan@gmail.com', 'Y' , '365', 'https//pic9.com', '2005-05-19'), 
(10, 8, 10, 'Elizibeth', 'Sam', 'dav@gmail.com', 'N' , '329', 'https//pic10.com', '2021-05-29');

-- Update
UPDATE Staff
SET StoreID = 9
WHERE StaffID = 1; 

-- Delete
DELETE FROM Staff
WHERE StaffID = 1;

-- Read
SELECT * FROM Staff;

-- Applying CRUD Operation on Staff Table

-- Insert
INSERT INTO Bought_Items(Bought_ItemsID, Item_Name, Last_Update)
VALUES
(1, 'Pencil', '2022-05-12'), 
(2, 'Rubber','2015-03-19'), 
(3, 'Scale','2014-06-15'), 
(4, 'Water','2018-07-19'), 
(5, 'Paint','2009-08-19'), 
(6, 'Recoder','2022-08-19');

-- Update
UPDATE Bought_Items
SET Last_Update = '2021-05-08'
WHERE Bought_ItemsID = 4;

-- Delete
DELETE FROM Bought_Items
WHERE Bought_ItemsID = 2;

-- Read
SELECT * FROM Bought_Items;

-- Applying CRUD Operation on Customer Table

-- Insert
INSERT INTO Customer(CustomerID, AddressID, Bought_ItemsID, AddressColumn, First_Name, 
Last_Name, Email, Active, Create_Date, Last_Update)
VALUES
(1, 2, 1, 1, 'Sam', 'Jhon', 'sam@gmail.com', 'Y' , '2022-05-12', '2022-05-12'), 
(2, 5, 3, 2, 'Eza', 'Elsa', 'eza@gmail.com', 'N' , '2022-05-12','2015-03-19'), 
(3, 6, 5, 4, 'Ali', 'Mahnnor', 'ali@gmail.com', 'Y' , '2022-05-12','2014-06-15'), 
(4, 8, 4, 6, 'David', 'Eza', 'david@gmail.com', 'N' , '2022-05-12','2018-07-19'), 
(5, 10, 6, 8, 'Ali', 'Khan', 'khan@gmail.com', 'Y' , '2022-05-12','2009-08-19'), 
(6, 1, 4, 10, 'Ela', 'Ali', 'ela@gmail.com', 'Y' ,'2022-05-12', '2022-08-19'), 
(7, 3, 4, 14, 'Jhon', 'Sam', 'jhon@gmail.com',  'N' , '2022-05-12', '2023-05-12'), 
(8, 5, 6, 21, 'David', 'Khan', 'david@gmail.com', 'Y' , '2022-05-12', '2022-09-09'), 
(9, 2, 1, 25, 'Sam', 'David', 'khan@gmail.com', 'Y' , '2022-05-12', '2005-05-19'), 
(10, 8, 4, 18, 'Elizibeth', 'Sam', 'dav@gmail.com', 'N' , '2022-05-12', '2021-05-29');

-- Update
UPDATE Customer
SET AddressColumn = 80
WHERE CustomerID = 4;

-- Delete
DELETE FROM Customer
WHERE CustomerID = 1;

-- Read
SELECT * FROM Customer;

-- Applying CRUD Operation on Subscription Table

-- Insert
INSERT INTO Subscription(SubscriptionID, DirectoryID, StaffID, CustomerID, Rental_Date, 
Return_Date, Last_Update)
VALUES
(1, 2, 2, 4, '2021-05-12', '2021-05-12', '2021-07-12'), 
(2, 5, 3, 2, '2021-06-12','2021-03-19', '2021-08-19'), 
(3, 6, 5, 4, '2021-07-12','2021-06-15', '2021-08-12'), 
(4, 8, 4, 6, '2021-08-12','2021-07-19', '2021-07-19'), 
(5, 10, 6, 8, '2021-09-12','2021-08-19', '2021-08-19'), 
(6, 1, 4, 8, '2021-01-12', '2021-08-19', '2021-07-12'), 
(7, 3, 4, 4, '2021-12-12', '2021-05-12', '2021-07-19'), 
(8, 5, 6, 9, '2021-04-12', '2021-09-09', '2021-08-19'), 
(9, 2, 9, 2, '2021-08-12', '2021-05-19', '2021-08-12'), 
(10, 8, 4, 8,'2021-05-12', '2021-05-29', '2021-07-12');

-- Update
UPDATE Subscription
SET DirectoryID = 5
WHERE SubscriptionID = 4;

-- Delete
DELETE FROM Subscription
WHERE SubscriptionID = 1;

-- Read
SELECT * FROM Subscription;

-- Applying CRUD Operation on CategoryC Table

-- Insert
INSERT INTO CategoryC(CategoryCID, Name, Last_Update)
VALUES
(1, 'High', '2022-05-12'), 
(2, 'Medium','2015-03-19'), 
(3, 'Low','2014-06-15'), 
(4, 'High','2018-07-19'), 
(5, 'Low','2009-08-19'), 
(6, 'High','2022-08-19'), 
(7, 'High','2023-05-12'), 
(8, 'Medium','2022-09-09'), 
(9, 'High', '2005-05-19'), 
(10, 'Medium','2021-05-29'); 

-- Update
UPDATE CategoryC
SET Name = 'High'
WHERE CategoryCID = 2;

-- Delete
DELETE FROM CategoryC
WHERE CategoryCID = 2;

-- Read
SELECT * FROM CategoryC;

-- Applying CRUD Operation on Customer_Category Table

-- Insert
INSERT INTO Customer_Category(Customer_CategoryID, CustomerID, CategoryCID, Last_Update)
VALUES
(1, 4, 1, '2022-05-12'), 
(2, 3, 3, '2015-03-19'), 
(3, 2, 5, '2014-06-15'), 
(4, 5, 7, '2018-07-19'), 
(5, 4, 9, '2009-08-19'), 
(6, 3, 4, '2022-08-19'), 
(7, 2, 6, '2023-05-12'), 
(8, 5, 8, '2022-09-09'), 
(9, 3, 10, '2005-05-19'), 
(10, 2, 9, '2021-05-29'); 

-- Update
UPDATE Customer_Category
SET CategoryCID = 6
WHERE Customer_CategoryID = 2;

-- Delete
DELETE FROM Customer_Category
WHERE Customer_CategoryID = 9;

-- Read
SELECT * FROM Customer_Category;

-- Applying CRUD Operation on Payment Table

-- Insert
INSERT INTO Payment(PaymentID, SubscriptionID, CustomerID, StaffID, Amount, Payment_Date)
VALUES
(1, 2, 2, 4, 2500, '2021-07-12'), 
(2, 5, 3, 2, 3590, '2021-08-19'), 
(3, 6, 5, 4, 800, '2021-08-12'), 
(4, 8, 4, 6, 200, '2021-07-19'), 
(5, 10, 6, 8, 3500, '2021-08-19'), 
(6, 5, 4, 8, 900, '2021-07-12'), 
(7, 3, 4, 4, 400, '2021-07-19'), 
(8, 5, 6, 9, 5020, '2021-08-19'), 
(9, 2, 9, 2, 1020, '2021-08-12'), 
(10, 8, 4, 8, 2050, '2021-07-12');

-- Update 
UPDATE Payment
SET Amount = 6500
WHERE PaymentID = 8;

-- Delete
DELETE FROM Payment
WHERE PaymentID = 4;

-- Read
SELECT * FROM Payment;

--- Done

