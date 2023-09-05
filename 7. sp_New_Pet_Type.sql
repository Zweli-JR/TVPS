/*
=============================================================
FileName: sp_New_Pet_Type.sql
Programmer: Zwelethu Jr. Nkosi
Description: This file is to create the sp_NewPetType stored procedure.
=============================================================
*/

USE tvps
GO

CREATE PROCEDURE sp_NewPetType
@category INT,
@type VARCHAR(30),
@qty INT
AS
BEGIN

	--Checks that no negative values are entered
	IF (@qty < 0)
	BEGIN
		RAISERROR ('Quantity can not be negative.',16,1)
		RETURN  -- Exits procedure immediately if quantity is negative
	END

	IF EXISTS (
	SELECT animalCatID
	FROM animal_category
	WHERE @category = animalCatID
	)
	INSERT INTO pet_type
	VALUES(@category, @type, @qty)
	ELSE
	RAISERROR ('Animal category not listed on database', 16,1)
END
GO

--Testing newly created procedure
EXEC sp_NewPetType 1, Ostrich, 23 
GO

--Testing if insert was successful
SELECT *
FROM pet_type