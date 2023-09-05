/*
=============================================================
FileName: vw_Pets_Per_Type.sql
Programmer: Zwelethu Jr. Nkosi
Description: This file is to create the Pets_Per_Type view.
=============================================================
*/

USE tvps
GO

--First check if the view exists, if it does, we drop it
IF EXISTS (SELECT Table_Name FROM Information_Schema.Views
	       WHERE Table_Name = 'vw_PetsPerType')
BEGIN
	DROP VIEW vw_PetsPerType
	PRINT 'vw_PetsPerType has been deleted'
END
GO

CREATE VIEW vw_PetsPerType
AS
SELECT pet_type.petType, pet_type.petTypeQty, pet_type.animalCatID, animal_category.animalCat
FROM pet_type
JOIN animal_category --Joining tables using primary key and foreign key
ON pet_type.animalCatID = animal_category.animalCatID
GO

-- Testing if the view works correctly

SELECT *
FROM vw_PetsPerType
GO