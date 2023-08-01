/*
The Business requirement of the project;
1. What are the top 3 ratings for movies released in the United States?
2. What are the Top 10 companies based on the number of movies?
3. What are the Top 10 companies in the United Kingdom based on movie revenue? (released 
country)
4. What are the Top 10 companies in the countries that begin with “I” based on the movie?
revenue?
5. What is the average movie time for movies in France and any country that contains Germany?
(released country)?
6. As a single analyst, what is the average movie time for movies with titles that contain ‘love’?
7. Which company has generated the most revenue? How much did they make in 2018?
8. Which star has been featured in the most movies? What are the top 3 movies in which he or she has acted?
in?
9. Which movie genre is most popular in India? What is the average revenue generated for this
movie genre in India? (country of origin)
10. How many movies start with a consonant letter?
*/

SELECT TOP (1000) [name]
      ,[rating]
      ,[genre]
      ,[year]
      ,[released]
      ,[score]
      ,[votes]
      ,[director]
      ,[writer]
      ,[star]
      ,[country]
      ,[budget]
      ,[gross]
      ,[company]
      ,[runtime]
  FROM [Summer LearnCamp].[dbo].[movies3]

--Getting Date released only
SELECT 
SUBSTRING(released,1,CHARINDEX('(', released) -1) AS Date_released
FROM movies3


--Getting the Country that released the movie
SELECT 
SUBSTRING(released,CHARINDEX('(', released) + 1, CHARINDEX(')', released) - CHARINDEX('(', released) - 1) AS Country_Released
FROM movies3

--Combining all the columns and Creating a new table Movies_Update
SELECT *,
	SUBSTRING(released,CHARINDEX('(', released) + 1, CHARINDEX(')', released) - CHARINDEX('(', released) - 1) AS Country_Released
INTO Movies_Update
FROM movies3

--No.1
-- Top 3 ratings for movies released in the United States
SELECT TOP 3 rating, COUNT(rating) AS Top_Rating
FROM Movies_Update
WHERE Country_Released = 'United States'
GROUP BY rating
ORDER BY Top_Rating DESC

--No.2
--Top 10 companies based on Number of movies
SELECT Top 10 company, COUNT(name) AS Total_Movies
FROM Movies_Update
GROUP BY company
ORDER BY Total_Movies DESC

--No.3
--Top 10 companies in United Kingdom based on movie revenue
SELECT Top 10 company, SUM(gross) AS Total_Revenue
FROM Movies_Update
WHERE Country_Released = 'United Kingdom'
GROUP BY company
ORDER BY Total_Revenue DESC

--No.4
--Top 10 companies in the countries that begins with letter "I" based on movie
SELECT Top 10 company, Country_Released, SUM(gross) AS Total_Revenue
FROM Movies_Update
WHERE Country_Released LIKE 'I%'
GROUP BY company, Country_Released
ORDER BY Total_Revenue DESC


--No.5
--Average movie time for movies in France and any Germany
SELECT AVG(runtime) AS Average_movie_time
INTO France_Germanymovies
FROM Movies_Update
WHERE Country_Released = 'France' OR Country_Released LIKE '%Germany%'

--No.6
--Average movie time for movies with title 'love'
SELECT AVG(runtime) AS Average_movie_time
INTO Single_Analyst
FROM Movies_Update
WHERE name LIKE '%love%'

--No.7
----Company by Highest Revenue
SELECT company, SUM(gross) AS Total_Revenue
FROM Movies_Update
GROUP BY company
ORDER BY Total_Revenue DESC

SELECT SUM(gross) AS Warner Bros. Revenue in 2018
FROM Movies_Update
WHERE company = 'Warner Bros.' AND year = 2018


--No.8
--Star that has featured in most movies
SELECT Top 1 star, COUNT(*) AS Total_Movies
FROM Movies_update
GROUP BY star
ORDER BY Total_Movies DESC

--Top 3 genres he/she featured in
SELECT Top 3 genre, star, COUNT(*) AS Total_Genre
FROM Movies_update
WHERE star = 'Nicolas Cage'
GROUP BY genre, star
ORDER BY Total_Genre DESC


--No.9
--Most popular genre in India
SELECT Top 1 genre, COUNT(*) AS Total_Genre
FROM Movies_update
WHERE country = 'India'
GROUP BY genre
ORDER BY Total_Genre DESC

SELECT genre,AVG(gross) AS Average_Revenue
FROM Movies_update
WHERE country = 'India' AND genre = 'Action'
GROUP BY genre


--No.10
--The movies name that start with a consonant
SELECT COUNT(*) AS Total_Movies
From Movies_Update
WHERE UPPER(LEFT(name,1)) NOT IN ('A','E','I','O','U')

