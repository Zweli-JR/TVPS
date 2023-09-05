/*
=============================================================
FileName: vw_Expired_Food_Details.sql
Programmer: Zwelethu Jr. Nkosi
Description: This file is to create the vw_ExpiredFoodDetails view.
=============================================================
*/

USE tvps
GO

--First check if the view exists, if it does, it is dropped

IF EXISTS (SELECT Table_Name FROM Information_Schema.Views
	       WHERE Table_Name = 'vw_ExpiredFoodDetails')
BEGIN
	DROP VIEW vw_ExpiredFoodDetails
	PRINT 'vw_ExpiredFoodDetails has been deleted'
END
GO

CREATE VIEW vw_ExpiredFoodDetails
AS
SELECT supplier.suppName, supplier.contactNo, food_type.foodID, food_type.foodName, food_type.expDate, animal_cat_food.amount, animal_cat_food.unit, animal_category.animalCat
FROM supplier
JOIN food_type --Joining tables using primary key and foreign key
ON supplier.suppID = food_type.supplier
JOIN animal_cat_food --Joining tables using primary key and foreign key
ON food_type.foodID = animal_cat_food.foodType
JOIN animal_category --Joining tables using primary key and foreign key
ON animal_cat_food.animalCategory = animal_category.animalCatID
WHERE GETDATE() >= food_type.expDate -- compares current date with expiry date
GO

-- Testing if the view works correctly

SELECT *
FROM vw_ExpiredFoodDetails
GO