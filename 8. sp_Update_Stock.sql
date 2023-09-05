/*
=============================================================
FileName: sp_Update_Stock.sql
Programmer: Zwelethu Jr. Nkosi
Description: This file is to create the sp_UpdateStock stored procedure.
=============================================================
*/

USE tvps
GO

CREATE PROCEDURE sp_UpdateStock
	@ID INT,
	@animalNo INT,
	@add_sub BIT
AS
BEGIN
	DECLARE @conversiona VARCHAR(5)
	DECLARE @conversionb VARCHAR(5)
	SET @conversiona = @ID
	SET @conversionb = @animalNo

	IF EXISTS ( -- Checking if id exists
		SELECT petTypeID
		FROM pet_type
		WHERE petTypeID = @ID
		)
		BEGIN
			IF (@add_sub =  1)
			BEGIN
			
				UPDATE pet_type
				SET petTypeQty = petTypeQty + @animalNo 
				WHERE petTypeID = @ID
				PRINT 'Successfully added ' + @conversionb + ' to pet type with ID ' + @conversiona
			END
			ELSE
			BEGIN
				UPDATE pet_type
				SET petTypeQty = petTypeQty - @animalNo 
				WHERE petTypeID = @ID
				PRINT 'Successfully subtracted ' + @conversionb + ' from pet type with ID ' + @conversiona
			END
		END
	ELSE
	RAISERROR ('Pet ID not listed on database',16,1)

END
GO

--Testing newly created procedure
EXEC sp_UpdateStock 2, 23, 1
GO

SELECT *
FROM pet_type