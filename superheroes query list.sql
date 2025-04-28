USE superhero
ALTER AUTHORIZATION ON DATABASE:: superhero TO sa;
GO

--Executing the following query will select every row from the superhero_name and full_name columns

SELECT superhero_name, full_name FROM superhero;

--Simple SELECT query with a calculated column
--Executing the following query will select every row from superhero_name, full_name and height_cm, it then divides height_cm (casted as a float from an int) by 100 to convert it to metres, the new column is not given a name.

SELECT superhero_name, full_name, (CAST(height_cm AS float) / 100) FROM superhero;

--Executing the following query will select the distinct publisher_ids
--This includes NULL values, if a row doesn’t have a publisher_id

SELECT DISTINCT publisher_id FROM superhero;

--This is the previous query from before, but now we give it a new alias
--Executing the following query will select every row from superhero_name, full_name and height_cm, it then divides height_cm (casted as a float from an int) by 100 to convert it to metres as before, but now the new column is given the alias “height_m”.

SELECT superhero_name, full_name, (CAST(height_cm AS float) / 100) AS height_m FROM superhero;

--This query combines the superhero_name and full_name columns into one column with the alias alias_and_name
--The query checks if the value is null using the ISNULL() function, and if it is null, simply uses an empty string instead

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

--This query selects the superhero name from the superhero table, and the publisher_ids from the publisher table, and relates them using a join, where the superhero table publisher id is equal to the publisher table id
--This is similar to the case query from before, but using a join instead
SELECT superhero.superhero_name AS 'Super Hero Name', publisher.publisher_name AS 'Publisher Name'
FROM superhero
JOIN publisher ON superhero.publisher_id = publisher.id

--This query selects the superhero name from the superhero table and the alignment from the alignment table, and then relates them with an inner join, where the alignment_id from superhero, is equal to the id from alignment
--The inner join in this case means that any superhero that does not have an alignment (as in NULL, not neutral) is then excluded from the table
SELECT superhero.superhero_name AS 'Super Hero Name', alignment.alignment AS 'Alignment' 
FROM superhero
INNER JOIN alignment
ON superhero.alignment_id = alignment.id

--This query selects the superhero name from the superhero table and the race from the race table, and then relates them with an inner join, where the race_id from superhero, is equal to the id from race
--The inner join in this case means that any superhero that does not have a race (as in NULL, not -) is then excluded from the table
SELECT superhero.superhero_name AS 'Super Hero Name', race.race AS 'Race' 
FROM superhero
INNER JOIN race
ON superhero.race_id = race.id

--This query selects the superhero name from the superhero table and the alignment from the alignment table, and then relates them with an inner join, where the alignment_id from superhero, is equal to the id from alignment
--The left join in this case means that any superhero that does not have an alignment (as in NULL, not neutral) is still included in the result, and all the others are named
SELECT superhero.superhero_name AS 'Super Hero Name', alignment.alignment AS 'Alignment' 
FROM superhero
LEFT JOIN alignment
ON superhero.alignment_id = alignment.id

--This query selects the superhero name from the superhero table and the alignment from the alignment table, and then relates them with an inner join, where the alignment_id from superhero, is equal to the id from alignment
--The right join in this case means that any superhero that does not have an alignment (as in NULL, not -) is then excluded from the table, as they do not have a value on the right table (alignment)
SELECT superhero.superhero_name AS 'Super Hero Name', alignment.alignment AS 'Alignment' 
FROM superhero
RIGHT JOIN alignment
ON superhero.alignment_id = alignment.id

--This query selects the superhero name from the superhero table and the alignment from the alignment table, and then relates them with an inner join, where the alignment_id from superhero, is equal to the id from alignment
--The full outer join in this case means that all rows are included, so even those that have a NULL alignment, are in the resulting table, as nothing is excluded.
SELECT superhero.superhero_name AS 'Super Hero Name', alignment.alignment AS 'Alignment' 
FROM superhero
FULL OUTER JOIN alignment
ON superhero.alignment_id = alignment.id

--This query selects two instances of superhero name from duplicates of the superhero table, a and b, it then for every superhero in table a, selects every other superhero in table b, that has the same haircolour id
--It is then also ordered by the table a's superhero names
SELECT a.superhero_name as 'Superhero 1', b.superhero_name AS 'Superhero 2'
FROM superhero a, superhero b
WHERE a.superhero_name <> b.superhero_name
AND a.hair_colour_id = b.hair_colour_id
ORDER BY a.superhero_name

--This query selects the superhero name from superhero and the superpower name from superpower, and then joins them together with a cross join on both hero_power and superpower
--The hero_power join gives the tables the connection between superhero and superpower, as it contains the ids for the powers that each hero has, so the cross join with hero_power, helps with the cross join for superhero and superpower.
SELECT superhero.superhero_name, superpower.power_name
FROM superhero
JOIN hero_power
ON hero_power.hero_id = superhero.id
JOIN superpower
ON superpower.id = hero_power.power_id

--This query selects all of the superhero names and the full names from superhero, and orders them by the full name ascending, removing any rows where full_name is null or -
SELECT superhero_name, full_name
FROM superhero
WHERE full_name IS NOT NULL AND full_name != '-'
ORDER BY full_name

--This query selects the superhero name and the height from superhero, filters them to only the rows where height is not null or 0, and then orders them by the height ascending
SELECT superhero_name, height_cm
FROM superhero
WHERE height_cm IS NOT NULL AND height_cm != 0
ORDER BY superhero.height_cm ASC

--This query selects the superhero name from the superhero table, and the publisher_ids from the publisher table, and relates them using a join, where the superhero table publisher id is equal to the publisher table id
--Then a predicate is used to select all of the rows that the publisher name column is distinct from "Marvel Comics" essentially selecting every row that is linked to a publisher that isn't "Marvel Comics"
SELECT superhero.superhero_name AS 'Super Hero Name', publisher.publisher_name AS 'Publisher Name'
FROM superhero
JOIN publisher ON superhero.publisher_id = publisher.id
WHERE publisher.publisher_name IS DISTINCT FROM 'Marvel Comics'

--This query does the same as the previous, except is uses IS NOT DISTINCT, so it selects only the rows where publisher name IS "Marvel Comics"
SELECT superhero.superhero_name AS 'Super Hero Name', publisher.publisher_name AS 'Publisher Name'
FROM superhero
JOIN publisher ON superhero.publisher_id = publisher.id
WHERE publisher.publisher_name IS NOT DISTINCT FROM 'Marvel Comics'

--This query selects the superhero name and the height from superhero, filters them to only the rows where height is not null or 0, and then orders them by the height ascending
--It then offsets the search by 5, to skip past the first 5 rows, which are below a height of 100cm
SELECT superhero_name, height_cm
FROM superhero
WHERE height_cm IS NOT NULL AND height_cm != 0
ORDER BY superhero.height_cm ASC
OFFSET 5 ROWS

--This query selects the superhero name and the height from superhero, filters them to only the rows where height is not null or 0, and then orders them by the height descending
--It then only selects the top 10 to show the 10 tallest characters
SELECT TOP 10 superhero_name, height_cm
FROM superhero
WHERE height_cm IS NOT NULL AND height_cm != 0
ORDER BY superhero.height_cm DESC

--This query selects the superhero name and the full name from superhero, and if it finds the full_name to be unknown/NULL it replaces it with "Unknown Name"
SELECT superhero_name, ISNULL(full_name, 'Unknown Name') AS full_name
FROM superhero

--This query selects the superhero name and the full name from superhero, and if it finds the full_name to be unknown/NULL it replaces it with "Unknown Real Name", and if it isn't it replaces it with "Known Real Name"
--This query differs from the last one, as it uses an IIF statement, alongside IS NOT NULL to check for NULL unknown values, and deal with them accordingly
SELECT superhero_name, IIF(full_name IS NOT NULL, 'Known Real Name', 'Unknown Real Name') AS full_name
FROM superhero

--This query creates a sum condition for each gender id, 1, 2 and 3, male, female and other respectively, it adds 1 to each column if it the row in the original table is equal to the gender id, it then casts that to a float, and divides it by the total number of rows in the table, then once that is completed it finally multiplies it by 100, to get the percentage that the gender takes up in the table
--This shows that when working with integer datatypes, sometimes you may have to cast to other numeric datatypes, such as floats
SELECT CAST(SUM(CASE WHEN gender_id = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100 AS MalePercentage,
CAST(SUM(CASE WHEN gender_id = 2 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100 AS FemalePercentage,
CAST(SUM(CASE WHEN gender_id = 3 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100 AS OtherPercentage
FROM superhero;

--This query concatenates 3 columns across 3 different tables, superhero name, gender and race, to create one column including all three
SELECT 'Superhero: ' + superhero_name + ' | Gender: ' + gender.gender + ' | Race: ' + race.race AS 'HeroName | Gender | Race'
FROM superhero
JOIN gender
ON superhero.gender_id = gender.id
JOIN race
ON superhero.race_id = race.id

--This query selects the superhero name and uses the character function REVERSE to reverse the superhero names
SELECT REVERSE(superhero_name) AS 'Reversed Superhero Name'
FROM superhero

--This query selects the current date and time, then the current day, month and year separately, and then finally the current time
SELECT GETDATE() AS 'Current Date & Time',
DAY(GETDATE()) AS 'Current Day', 
MONTH(GETDATE()) AS 'Current Month',
YEAR(GETDATE()) AS 'Current Year',
CONCAT(DATEPART(hour, SYSDATETIME()), ':' ,DATEPART(minute, SYSDATETIME())) AS 'Current Time'

--This query selects the current date and time, then the current day, month and year separately, but it also gets the name of the day and month
SELECT GETDATE() AS 'Current Date & Time',
DATENAME(weekday, GETDATE()) AS 'Current Day',
DAY(GETDATE()) AS 'Current Day Numeric',
DATENAME(month, GETDATE()) AS 'Current Month',
MONTH(GETDATE()) AS 'Current Month Numeric',
YEAR(GETDATE()) AS 'Current Year'

--This query selects the current date and time, and then compares it to 10 years from now, and then calculates the difference between them in seconds
SELECT DATEDIFF(second, GETDATE(), DATEADD(year, 10, GETDATE())) AS '10 Years In Seconds'

--This query inserts new rows into the race table, 'Viltrumite' with the id value 62, 'Human / Viltrumite' with the id 63 and 'Unopan' with the id 64
INSERT INTO race(id, race)
VALUES(62, 'Viltrumite'),
(63, 'Human / Viltrumite'),
(64, 'Unopan')

--This query inserts 5 new rows into the superhero table, each with the necessary data, outside of height and weight
INSERT INTO superhero(id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id)
VALUES (757, 'Invincible', 'Markus Sebastian Grayson', 1, 9, 4, 31, 63, 10, 1),
(758, 'Atom Eve', 'Samantha Eve Wilkins', 2, 14, 23, 31, 24, 10, 1),
(759, 'Omni-Man', 'Nolan Grayson', 1, 7, 4, 31, 62, 10, 2),
(760, 'Allen The Alien', 'Allen', 1, 4, 1, 19, 64, 10, 1),
(761, 'Rexsplode', 'Rex Sloan', 1, 14, 3, 9, 24, 10, 1)

--This query updates the row in superhero for 'Invincible' adding his height and weight
UPDATE superhero
SET height_cm = 180, weight_kg = 79
WHERE superhero_name = 'Invincible'

--This query deletes the row in superhero for 'Rexsplode'
DELETE FROM superhero
WHERE superhero_name = 'Rexsplode'

--This query creates a new table 'team' which contains an auto incrementing row, 'teamid', as well as 'TeamName'
CREATE TABLE team (
    teamid int IDENTITY(1,1) PRIMARY KEY,
    TeamName varchar(255) NOT NULL
);

--This query inserts new values into the team table, showing off the auto increment, as the teamid rows increment, without direct changes
INSERT INTO team (TeamName)
VALUES ('Justice League'),
('Avengers'),
('X-Men'),
('Teen Titans'),
('New Mutants'),
('Young Avengers'),
('Guardians Of The Galaxy'),
('Guardians Of The Globe'),
('Teen Team'),
('Fantastic Four')

--This query uses the in-built AVG (average) function to calculate the average height and weight of the superheroes in the table
SELECT AVG(height_cm) AS 'Average Height in CM', AVG(weight_kg) AS 'Average Weight in KG'
FROM superhero

--This query uses the in-built COUNT function to count the total amount of superheroes in the table that have their full name listed as something other than NULL or -
SELECT COUNT(*) AS 'Superheroes With Known Real Names'
FROM superhero
WHERE full_name IS NOT NULL OR full_name != '-'

--This query uses the in-built MAX function to get the superhero name and height of the tallest superheroes in the table
SELECT superhero_name, height_cm
FROM superhero
WHERE height_cm = (SELECT MAX(height_cm) FROM superhero)

--This query selects the superhero name, and then also the height, it then converts the height in centimetres to a float value, which allows it to become a decimal value, this is then divided by 100
--The resulting value is then converting to a varchar value, which is then concatenated together to create a varchar value of the name and the height in metres
SELECT superhero_name + ': ' + CONVERT(varchar, (CONVERT(float, height_cm)/100)) + 'm' AS 'Superhero and Height in metres'
FROM superhero
 
--This query selects the top 10 highest values in the weight_kg column, using the CAST function to convert weight_kg to a varchar and concatenate it with the superhero name, to create a table with the top 10 heaviest characters
SELECT TOP 10 superhero_name + ': ' + CAST(weight_kg as varchar) + 'kg' AS 'Top 10 Heaviest Characters'
FROM superhero
ORDER BY weight_kg DESC

--This query selects the top 10 smallest values in the weight_kg column, it then also uses the logical operators NOT, and AND, to filter out any results that are either NULL, or 0, to get the lightest characters that have weight
SELECT TOP 10 superhero_name + ': ' + CAST(weight_kg as varchar) + 'kg' AS 'Top 10 Lightest Characters'
FROM superhero
WHERE weight_kg IS NOT NULL AND NOT weight_kg = 0
ORDER BY weight_kg ASC

--This query selects the superhero name and the respective publisher using a join, and then only selects the rows, using the BETWEEN and AND logical operators, where the publisher id is between 5 and 8
SELECT superhero_name, publisher_id, publisher.publisher_name
FROM superhero
LEFT JOIN publisher
ON superhero.publisher_id = publisher.id
WHERE publisher.id BETWEEN 5 AND 8
ORDER BY publisher.id

 --This query uses the NULL function COALESCE to select the first result that isn't NULL, therefore if full_name is NULL, it returns superhero_name instead
--In this case, an IIF function also needed to be used to filter out cases where full_name is '-' and therefore not NULL, but also not actually the name
SELECT superhero_name AS 'Alias', IIF(COALESCE(full_name, superhero_name) = '-', superhero_name, COALESCE(full_name, superhero_name)) AS 'Known Name'
FROM superhero

--This query selects the superhero name as well as their corresponding race using a left join, it then checks if race is NULL using the ISNULL function, then if that returns true, it replaces NULL with 'Unknown Race'
SELECT superhero.superhero_name AS 'Super Hero Name', ISNULL(race.race, 'Unknown Race') AS 'Race' 
FROM superhero
LEFT JOIN race
ON superhero.race_id = race.id
ORDER BY race
