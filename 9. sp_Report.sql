/*
=============================================================
FileName: sp_Report.sql
Programmer: Zwelethu Jr. Nkosi
Description: This file is to create the sp_Report stored procedure.
=============================================================
*/

USE tvps
GO


CREATE PROCEDURE sp_Report
@suppName VARCHAR(30)
AS
BEGIN
DECLARE @id VARCHAR(5)
DECLARE @name VARCHAR(30)
DECLARE @contactNo VARCHAR(14)
DECLARE @email VARCHAR(30)

DECLARE @foodID VARCHAR(5)
DECLARE @foodName VARCHAR(30)

DECLARE @count INT
SET @count = 0
DECLARE @countVar VARCHAR(5)



IF EXISTS ( -- Checks if supplier exists in expired food details view
	SELECT suppName
	FROM vw_ExpiredFoodDetails
	WHERE suppName = @suppName
	)
	BEGIN
		SET @id = ( 
			SELECT TOP 1 suppID
			FROM supplier
			WHERE suppName = @suppName
			)
		SET @name = (
			SELECT TOP 1 suppName
			FROM vw_ExpiredFoodDetails
			WHERE suppName = @suppName
			)
		SET @contactNo = (
			SELECT TOP 1 contactNo
			FROM vw_ExpiredFoodDetails
			WHERE suppName = @suppName
			)
		SET @email = (
			SELECT TOP 1 email
			FROM supplier
			WHERE suppName = @suppName
			)
	

		DECLARE detailCursor CURSOR
		FOR
		SELECT
		DISTINCT foodID, foodName
		FROM vw_ExpiredFoodDetails
		WHERE suppName = @suppName
		
		PRINT 'EXPIRED PRODUCTS:'
		PRINT '________________________________________________'
		PRINT ''
		PRINT 'Generated:'
		PRINT GETDATE()
		PRINT ''
		PRINT 'Company ID: ' + '            ' + @id
		PRINT 'Company Name: ' + '          ' + @name
		PRINT 'Company Contact No: ' + '    ' + @contactNo
		IF @email IS NULL
		PRINT 'Company Email: ' + '         ' + 'Not provided'
		ELSE
		PRINT 'Company Email: ' + '         ' + @email
		PRINT ''
		PRINT '________________________________________________'
		PRINT 'Food ID' + '      Food Type'
		PRINT '________________________________________________'
		
		OPEN detailCursor
		FETCH NEXT FROM detailCursor INTO @foodID, @foodName
		WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT ' '+ @foodID + '           ' + @foodName
			SET @count = @count + 1
			FETCH 
			NEXT 
			FROM detailCursor 
			INTO @foodID, @foodName

		END
		CLOSE detailCursor
		DEALLOCATE detailCursor
	SET @countVar = @count
	PRINT '_______________________'
	PRINT ' Total Records: ' + @countVar
	PRINT '_______________________'
	END
	
ELSE
BEGIN
	IF EXISTS (
		SELECT suppName
		FROM supplier
		WHERE suppName = @suppName
		)
		PRINT 'No products by this supplier have expired'
	ELSE 
	PRINT 'Supplier not listed on database'
END

END
GO

-- Testing newly created procedure
EXEC sp_Report 'veggie land'  --Correct
GO

--Below is a few test that you can uncommented and run separately by either selecting the lines and clicking
--EXEC sp_DisplayJob_Cursor 11  --Incorrect. Job number does not exist
--GO