USE sakila;

#1 Select all the actors with the first name ‘Scarlett’.
SELECT * FROM sakila.actor
WHERE first_name = 'Scarlett';


#2 How many films (movies) are available for rent and how many films have been rented?
SELECT COUNT(*), 'rented_films' AS return_date 
  FROM sakila.rental
 WHERE return_date IS NULL 
UNION
SELECT COUNT(*), 'available_to_rent' AS return_date 
  FROM sakila.rental
 WHERE return_date IS NOT NULL;


#3 What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT MAX(length) AS 'max_duration_minutes', MIN(length) AS 'min_duration_minutes' FROM sakila.film;


#4 What's the average movie duration expressed in format (hours, minutes)?
SELECT AVG(length) AS 'avg length (minutes)', AVG(length)/60 AS 'avg length (hours)' FROM sakila.film;

#5 How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT(last_name)) AS 'count of distinct last names' FROM sakila.actor;


#6 Since how many days has the company been operating (check DATEDIFF() function)?
SELECT MIN(CONVERT(rental_date, DATE)) AS 'First Day of Operation' FROM sakila.rental;
#found the date to be 2005/05/24 by finding the minimum of the rental dates
SELECT MAX(CONVERT(rental_date, DATE)) AS 'Last Day of Operation' FROM sakila.rental;
#last day of operation 2006-02-14
SELECT DATEDIFF(day, '05/24/2005', '02-14-2006') AS 'Days company has been operating';
#This function isn't working, I tried for 20 minutes and with many different date formats..  I'll move on


#7 Show rental info with additional columns month and weekday. Get 20 results.
#rental_date column is in format YYYY-MM-DD HH-MM-SS, and needs to be in format YYMMDD to isolate month
#can't figure out how to do this, moving on..

SELECT rental_date FROM sakila.rental;
SELECT CONVERT(VARCHAR(8), rental_date, 112) AS [YYYYMMDD] FROM sakila.rental;


#8 Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
#Same issue as 7

#9 Get release years.
SELECT title, release_year FROM sakila.film;

#10 Get all films with ARMAGEDDON in the title.
SELECT * FROM sakila.film WHERE CONTAINS(title,'ARMAGEDDON');
SELECT * FROM sakila.film WHERE title = 'ARMAGEDDON';
SELECT * FROM sakila.film
WHERE title = 'ARMAGEDDON LOST';
##Can't figure out how to search for any title with Armageddon included 

#11 Get all films which title ends with APOLLO.
SELECT title, RIGHT(title,6) as last6_letters
FROM sakila.film
ORDER BY last6_letters ASC;
#put them in alphabetical order and looks like there are no films that end with "APOLLO"



#12 Get 10 the longest films.
SELECT * FROM sakila.film
ORDER BY length DESC
LIMIT 10;


#13 How many films include Behind the Scenes content?

SELECT COUNT(special_features) FROM sakila.film
WHERE special_features like '%Behind the Scenes';
#OK, got this far, ran out of time to figure out how to count (or maybe this is correct?)