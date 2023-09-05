/*
=============================================================
FileName: Creating_Triggers.sql
Programmer: Zwelethu Jr. Nkosi
Description: This file is to create all the triggers for the database.
=============================================================
*/


USE tvps
GO

--This trigger displays a message after a record is deleted from the food type table
CREATE TRIGGER tr_Deleted
ON food_type
AFTER DELETE
AS
PRINT 'Food type successfully deleted.'
GO

--This trigger displays a message after a new record is added to the pet type table

CREATE TRIGGER tr_added
ON pet_type
AFTER INSERT
AS
PRINT 'New pet type successfully added.'
GO