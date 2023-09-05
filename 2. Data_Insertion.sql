 /*
=============================================================
FileName: Data_Insertion.sql
Programmer: Zwelethu Jr. Nkosi
Description: This file is for inserting all the sample data into all the tables.
=============================================================
*/

USE tvps
GO

INSERT INTO supplier
VALUES ('SZA Suppliers', '(062) 884 9923', NULL),
	('Veggie Land', '(051) 861 2571 ', 'sales@veggieland.co.za'),
	('Waltloo Meats', '(081) 364 2123', 'services@waltloomeats.com'),
	('Food lovers Market', '(012) 111 3201', NULL),
	('Aquafina', '(012) 772 8000', 'sales@aquafina.com')
GO

INSERT INTO food_type
VALUES (02, 'Green Vegetable Mix', 'Vegetables', '2022-01-23'),
	(04, 'Apples', 'Fruits', '2022-12-25'),
	(03, 'Beef', 'Meat', '2023-03-21'),
	(03, 'Chicken Drumsticks', 'Meat', '2023-04-28'),
	(04, 'Strawberries', 'Fruits', '2023-07-12'),
	(02, 'Carrots', 'Vegetables', '2023-01-12'),
	(01, 'Seeds', 'Seeds', '2026-01-12'),
	(05, 'Water', 'Water', '9999-12-31')
	
GO

INSERT INTO animal_category
VALUES ('Bird', 0),
	('Reptile', 0),
	('Mammal', 0),
	('Amphibian', 0)
GO

INSERT INTO animal_cat_food
VALUES (01,07, 820, 'g'),
	(01,08, 50, 'ltr'),
	(02,04, 80, 'kg'),
	(02,08, 100, 'ltr'),
	(03,01, 75, 'kg'),
	(03,03, 120, 'kg'),
	(03,04, 160, 'kg'),
	(03,05, 120, 'kg'),
	(03,08, 200, 'ltr'),
	(04,01, 50, 'kg'),
	(04,06, 60, 'kg'),
	(04,02, 35, 'kg'),
	(04,08, 50, 'ltr')
GO

INSERT INTO pet_type
VALUES (01, 'Parrot', 36),
	(04, 'Turtle', 12),
	(02, 'Komodo Dragon', 6),
	(02, 'Cobra', 4),
	(03, 'Dog', 59),
	(03, 'Chimp', 2),
	(03, 'Cat', 51)
GO

UPDATE animal_category
SET totalStock = (
	SELECT SUM(petTypeQty)
	FROM pet_type
	WHERE animal_category.animalCatID = pet_type.animalCatID
	)