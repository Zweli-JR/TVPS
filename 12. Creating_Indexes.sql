/*
=============================================================
FileName: Creating_Indexes.sql
Programmer: Zwelethu Jr. Nkosi
Description: This file is to create all the triggers for the database.
=============================================================
*/

USE tvps
GO

CREATE INDEX idx_supplier
ON supplier (suppID)
GO

CREATE INDEX idx_animalCat
ON animal_category (animalCatID)
GO

CREATE INDEX idx_animalFood
ON animal_cat_food (animalCategory, foodType)
GO

CREATE INDEX idx_food
ON food_type (foodID)
GO

CREATE INDEX idx_pet
ON pet_type (petTypeID)
GO