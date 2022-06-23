 #Lab 2 from Wednesday Sakila/MySQl 
USE sakila;
#1 In the table actor, which are the actors whose last names are not repeated? 
#For example if you would sort the data in the table actor by last_name, you would 
#see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. 
#These three actors have the same last name. So we do not want to include this last name in our output. 
#Last name "Astaire" is present only one time with actor "Angelina Astaire", 
#hence we would want this in our output list.

#In other words, from the actor's table, show all the actor's that have a unique last name
SELECT  last_name, COUNT(last_name) AS frequency
FROM sakila.actor
GROUP BY  last_name
HAVING COUNT(last_name) = 1;
##Can't figure out how to have last name and first name shown. Will move on


#2 Which last names appear more than once? We would use the same logic as in the 
#previous question but this time we want to include the last names of the actors 
#where the last name was present more than once
SELECT  last_name, COUNT(last_name) AS frequency
FROM sakila.actor
GROUP BY  last_name
HAVING COUNT(last_name) > 1;


#3 Using the rental table, find out how many rentals were processed by each employee.
#count the total number of staff ids per staff member
SELECT staff_id, SUM(staff_id) AS 'rentals processed by employee'
FROM sakila.rental
GROUP BY staff_id;

#4 Using the film table, find out how many films were released each year.
SELECT release_year, SUM(release_year) as "movies per year" #columns you want to display
FROM sakila.film #tables you need
GROUP BY release_year; #group them by release year


#5 Using the film table, find out for each rating how many films were there.
SELECT rating, SUM(rating) as "number of films"  #columns to display
FROM sakila.film #table you need
GROUP BY rating; #group by rating

#6 What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
#The average running time per film for each rating type
SELECT rating, ROUND(AVG(length),2) as "avg length in minutes"
FROM sakila.film
GROUP BY rating;

#7 Which kind of movies (rating) have a mean duration of more than two hours?
SELECT rating, ROUND(AVG(length),2) as "avg length in minutes"
FROM sakila.film
GROUP BY rating
HAVING ROUND(AVG(length),2) > 120;

#8 Rank films by length (filter out the rows that have nulls or 0s in length column). 
#In your output, only select the columns title, length, and the rank.

SELECT title as film_title, length as length_in_minutes
FROM sakila.film
WHERE length <> 0 OR null
ORDER BY length ASC;


SELECT *
FROM sakila.film;