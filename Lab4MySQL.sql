#Lab | SQL Join (DAY 4 Part I)
USE sakila;
#with aggregate functions in "from", need a "group by" clause?
#everything under select should be called in group by

#1 How many films are there for each of the categories in the category table? 
#Join the category table and film category table, then count the number of movies per category
#Use appropriate join to write this query.
#Every film has a category, but every category doensn't necessarily have a film

SELECT * FROM sakila.film_category;

SELECT * FROM sakila.category;

SELECT COUNT(film_id) AS number_of_films, name AS movie_category  #columns to display
FROM sakila.film_category fc #tables we need
JOIN sakila.category c #tables we need
ON fc.category_id = c.category_id #column the tables have in common
GROUP BY name; #group them by


#2 Display the total amount rung up by each staff member in August of 2005. 
SELECT SUM(p.amount) as "total $ rung up", CONCAT(s.first_name, ' ', s.last_name) AS employee_name  #columns we want to display
FROM sakila.payment p #table we need
JOIN sakila.staff s #table we need
ON p.staff_id = s.staff_id #columns that are the same
WHERE DATE(payment_date) BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY s.staff_id;

#tip use this  WHERE DATE(put where date is here) BETWEEN '2005-08-01' AND '2005-08-31'


#3 Which actor has appeared in the most films?
#difference between actor table and film actor table?
#Susan Davis seems right
#this question is buggy, you can skip it

SELECT COUNT(fa.actor_id) AS frequency_of_films, (CONCAT(first_name, ' ', last_name)) AS actor_name
FROM film_actor fa
JOIN actor a
ON fa.actor_id = a.actor_id
GROUP BY fa.actor_id
ORDER BY COUNT(fa.actor_id) DESC
LIMIT 1;


#4 Most active customer (the customer that has rented the most number of films)
#Answer is Eleanor Hunt


SELECT  r.customer_id, CONCAT(first_name, ' ', last_name) AS customer_name, COUNT(r.customer_id) AS rental_frequency
FROM sakila.rental r
JOIN sakila.customer c
ON r.customer_id = c.customer_id
GROUP BY customer_id
ORDER BY COUNT(r.customer_id) DESC
LIMIT 1;

#Inside the rental table, I want to count the number of rentals(rental_id) to each customer
#Then, I want to join the rental table with the customer table (by customer_id) to get the customers name


#5 Display the first and last names, as well as the address, of each staff member.
#select, from, join, using

SELECT CONCAT(first_name, ' ',last_name) AS employee_name, a.address, district
FROM sakila.staff s
JOIN sakila.address a
ON s.address_id = a.address_id;

#6 List each film and the number of actors who are listed for that film.

SELECT title FROM sakila.film;
SELECT * FROM sakila.film_actor;

SELECT COUNT(fa.actor_id) AS number_of_actors, f.title as movie_title #columns to show
FROM sakila.film_actor fa #table we need
JOIN sakila.film f #table we need
ON fa.film_id = f.film_id #column they have in common
GROUP BY f.title; 


#7 Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
#List the customers alphabetically by last name.


SELECT SUM(p.amount) as total_paid_$, c.first_name, c.last_name
FROM sakila.payment p
JOIN sakila.customer c
ON p.customer_id = c.customer_id
GROUP BY c.last_name, c.first_name
ORDER BY c.last_name ASC;


#8 List number of films per category. #same question as number 1, ignore

