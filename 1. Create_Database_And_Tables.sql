 /*
=============================================================
FileName: Create_Database_And_Tables.sql
Programmer: Zwelethu Jr. Nkosi
Description: This file will create the database and tables with the necessary constraints.
=============================================================
*/

USE master
GO

-- Checking if database exists, if it exists, it drops the database
IF EXISTS(SELECT name FROM master.dbo.sysdatabases
	       WHERE name = 'tvps')
BEGIN
	DROP DATABASE tvps
	PRINT 'The database has been deleted'
END

--Creating new database

CREATE DATABASE tvps
ON PRIMARY
(
	NAME = 'tvps',
	FILENAME = 'C:\sql18\tvps.mdf',
	SIZE = 5MB,
	FILEGROWTH = 10%
)
LOG ON
(
	NAME = 'tvps_log',
	FILENAME = 'C:\sql18\tvps_log.ldf',
	SIZE = 5MB,
	FILEGROWTH = 10%
)
GO

USE tvps
GO

-- Now that database has been created, I can use it

CREATE TABLE supplier
(
	suppID INT IDENTITY(1,1) NOT NULL, -- making the id an identity that starts at 1 and increments by 1
	suppName VARCHAR(30)  UNIQUE NOT NULL, -- making sure each supplier's name is unique
	contactNo VARCHAR(15) UNIQUE NOT NULL, -- making sure each supplier's contact number is unique
	email VARCHAR(30) NULL, -- email is optional
	CONSTRAINT supplier_pk PRIMARY KEY(suppID)
)
GO
PRINT '"SUPPLIER" TABLE CREATED'
GO

CREATE TABLE food_type
(
	foodID INT IDENTITY(1,1) NOT NULL, -- making the id an identity that starts at 1 and increments by 1
	supplier INT NOT NULL,
	foodName VARCHAR(30) NOT NULL,
	foodType VARCHAR(30) NOT NULL,
	expDate DATE NOT NULL,
	CONSTRAINT food_pk FOREIGN KEY (supplier) REFERENCES supplier(suppID),
	PRIMARY KEY(foodID)
)
GO
PRINT '"FOOD TYPE" TABLE CREATED'
GO

CREATE TABLE animal_category
(
	animalCatID INT IDENTITY(1,1) NOT NULL, -- making the id an identity that starts at 1 and increments by 1
	animalCat VARCHAR(30) UNIQUE NOT NULL, -- making sure each animal category is unique
	totalStock INT DEFAULT '0' NOT NULL
	CONSTRAINT animal_category_pk PRIMARY KEY(animalCatID)
)
GO
PRINT '"ANIMAL CATEGORY" TABLE CREATED'
GO

CREATE TABLE animal_cat_food
(
	animalCategory INT NOT NULL,
	foodType INT NOT NULL,
	amount INT NOT NULL CHECK (amount > 0), -- checking if there is at least 1 unit 
	unit VARCHAR(3) NOT NULL -- Setting a default value for the units to be kg
	CONSTRAINT animal_cat_food_pk FOREIGN KEY (animalCategory) REFERENCES animal_category(animalCatID),  -- creating composite primary key since this is an intersection table
	FOREIGN KEY (foodType) REFERENCES food_type(foodID),
	PRIMARY KEY(animalCategory, foodType)
)
GO
PRINT '"ANIMAL CATEGORY FOOD" TABLE CREATED'
GO

CREATE TABLE pet_type
(
	petTypeID INT IDENTITY(1,1) NOT NULL, -- making the id an identity that starts at 1 and increments by 1
	animalCatID INT NOT NULL,
	petType VARCHAR(30) NOT NULL,
	petTypeQty INT NOT NULL,
	CONSTRAINT pet_type_pk FOREIGN KEY (animalCatID) REFERENCES animal_category(animalCatID),
	PRIMARY KEY(petTypeID)
)
GO
PRINT '"PET TYPE" CREATED'
GO