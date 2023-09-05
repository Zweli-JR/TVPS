/*
=============================================================
FileName: sp_Delete_Food_Type.sql
Programmer: Zwelethu Jr. Nkosi
Description: This file is to create the sp_DeleteFoodType stored procedure.
=============================================================
*/

USE tvps
GO




CREATE PROCEDURE sp_DeleteFoodType
@foodType VARCHAR(30)
AS
BEGIN
	IF EXISTS( -- Checking if the food type is expired
	SELECT foodName
	FROM vw_ExpiredFoodDetails
	WHERE vw_ExpiredFoodDetails.foodName = @foodType
	)
BEGIN

DELETE FROM animal_cat_food 
WHERE animal_cat_food.foodType = (
	SELECT TOP 1 foodID
	FROM vw_ExpiredFoodDetails
	WHERE @foodType = vw_ExpiredFoodDetails.foodName
	)

DELETE FROM food_type 
WHERE foodName = @foodType
END
ELSE -- runs if food type not expired
BEGIN
	IF EXISTS ( -- checking if the food type exists on database
		SELECT foodName
		FROM food_type
		WHERE foodName = @foodType
		)
		PRINT 'Food type not expired' 
	ELSE
	PRINT 'Food type not listed on database'
END
END
GO

-- Testing newly created procedure
EXEC sp_DeleteFoodType 'Apples'
GO
