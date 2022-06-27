#Sub-queries
use sakila;

#1 How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT COUNT(inventory_id) as number_of_copies, f.title 
FROM sakila.film f
JOIN sakila.inventory i USING (film_id)
WHERE f.title='Hunchback Impossible';

#2 List all films whose length is longer than the average of all the films.

SELECT title, length FROM sakila.film
WHERE length > (
SELECT avg(length)
FROM sakila.film)
ORDER BY length DESC;

#3 Use subqueries to display all actors who appear in the film Alone Trip.
SELECT * FROM sakila.film
WHERE title = "Alone Trip";  #can see the film_id is 17
SELECT COUNT(film_id) FROM film_actor
WHERE film_id = 17; #Can see there are 8 actors who appeared in the film 

SELECT CONCAT (first_name, ' ', last_name) AS "Actors_in_Alone_Trip" 
FROM  actor
WHERE actor_id IN
(SELECT actor_id FROM film_actor WHERE film_id=
(SELECT film_id FROM film where title = "Alone Trip"));



#4 Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
#Identify all movies categorized as family films.
SELECT * FROM film_category, category
WHERE name = "Family";


SELECT title AS movie_title FROM film 
WHERE film_id IN 
(SELECT film_id FROM film_category WHERE category_id =
(SELECT category_id FROM sakila.category WHERE name = "Family"));


#5 Get name and email from customers from Canada using subqueries. 
#Do the same with joins. 
#Note that to create a join, you will have to identify the correct tables
# with their primary keys and foreign keys, that will help you get the relevant information.



#6 Which are films starred by the most prolific actor? 
#Most prolific actor is defined as the actor that has acted in the most number of films.
#First you will have to find the most prolific actor and then use that actor_id to 
#find the different films that he/she starred.


#7 Films rented by most profitable customer. You can use the customer table and payment
# table to find the most profitable customer ie the customer that has made the largest sum of payments


#8 Customers who spent more than the average payments.

SELECT p.amount, CONCAT(first_name, ' ', last_name) AS customer_name
FROM sakila.payment p
JOIN sakila.customer c
ON c.customer_id = p.customer_id
WHERE amount > (
SELECT avg(amount)
FROM payment p)
ORDER BY amount DESC;