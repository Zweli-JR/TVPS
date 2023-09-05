 /*
=============================================================
FileName: vw_Manufacturer_Details.sql
Programmer: Zwelethu Jr. Nkosi
Description: This file is to create the vw_ManufacturerDetails view.
=============================================================
*/

USE tvps
GO

--First check if the view exists, if it does, we drop it
IF EXISTS (SELECT Table_Name FROM Information_Schema.Views
	       WHERE Table_Name = 'vw_ManufacturerDetails')
BEGIN
	DROP VIEW vw_ManufacturerDetails
	PRINT 'vw_ManufacturerDetails has been deleted'
END
GO

CREATE VIEW  vw_ManufacturerDetails
AS
SELECT supplier.suppID, food_type.foodType, food_type.foodName, animal_cat_food.amount
FROM supplier
JOIN food_type --Joining tables using primary key and foreign key
ON supplier.suppID = food_type.supplier
JOIN animal_cat_food --Joining tables using primary key and foreign key
ON food_type.foodID = animal_cat_food.foodType
GO

-- Testing if the view works correctly

SELECT *
FROM vw_ManufacturerDetails
GO