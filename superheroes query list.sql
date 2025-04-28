USE superhero
ALTER AUTHORIZATION ON DATABASE:: superhero TO sa;
GO

--Executing the following query will select every row from the superhero_name and full_name columns

SELECT * FROM superhero;

SELECT superhero_name, full_name FROM superhero;

SELECT superhero_name, full_name, (CAST(height_cm AS float) / 100) FROM superhero;

SELECT DISTINCT publisher_id FROM superhero;

SELECT superhero_name, full_name, (CAST(height_cm AS float) / 100) AS height_m FROM superhero;

SELECT ISNULL(superhero_name, '') + ' - ' + ISNULL(full_name, '') AS alias_and_name FROM superhero;

--This query selects the superhero name, and publisher_id columns, it then uses a CASE expression to rename the values in the publisher_id column, with the actual publisher name, using the 3 biggest publishers, and then other for the smaller ones
SELECT superhero_name, CASE publisher_id
	WHEN '13' THEN 'Marvel'
	WHEN '4' THEN 'DC'
	WHEN '10' THEN 'Image'
	ELSE 'Other'
	END AS Publisher
FROM superhero;

--This query selects the superhero name, and gender_id columns, it uses a CASE expression to rename those values with the gender that it refers to, using male, female and other, as the Gender column
SELECT superhero_name, CASE gender_id
	WHEN '1' THEN 'Male'
	WHEN '2' THEN 'Female'
	ELSE 'Other'
	END AS Gender
FROM superhero;

--This query selects the superhero name from the superhero table, and the genders from the gender table, and relates them using a join, where the superhero table gender id is equal to the gender table gender id
--This is similar to the case query from before, but using a join
SELECT superhero.superhero_name AS 'Name', gender.gender AS 'Gender'
FROM superhero
JOIN gender ON superhero.gender_id = gender.id