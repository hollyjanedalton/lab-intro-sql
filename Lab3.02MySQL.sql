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
 
SELECT * FROM sakila.address; #can see that address ID of Alberta store is 1, city id is 300
SELECT * FROM country
WHERE country = "Canada"; #can see that the country ID for canada is 20

SELECT email 
FROM sakila.customer c
WHERE address_id IN 
(SELECT address_id FROM sakila.address WHERE city_id =
(SELECT city_id FROM sakila.city WHERE country_id = 20));
##this doesn't work, get error that it returns more than one row.
#to me it makes sense to do it this way, to specify the country id instead of the city id, because it asks
#for all customers from Canada, not Alberta
#upon further digging, looks like the country table isn't very helpful

SELECT CONCAT(first_name, ' ', last_name) as customer_name, store_id, email
FROM sakila.customer
WHERE customer_id IN 
(SELECT customer_id FROM customer WHERE store_id =
(SELECT store_id FROM sakila.store WHERE address_id = 1));
# we know there are only 2 stores, so easier (for now) to select the store_id, although ideally
#I'd like to select for all of canada, in case more stores would open

#Do the same with joins. 
#Note that to create a join, you will have to identify the correct tables
# with their primary keys and foreign keys, that will help you get the relevant information.

SELECT CONCAT(first_name, ' ', last_name) as customer_name,  email, c.store_id AS alberta_store_id
FROM sakila.customer c
JOIN sakila.store s
ON s.store_id = c.store_id
WHERE c.store_id = 1;

#6 Which are films starred by the most prolific actor? 
#Most prolific actor is defined as the actor that has acted in the most number of films.
#First you will have to find the most prolific actor and then use that actor_id to 
#find the different films that he/she starred.

SELECT COUNT(film_id), actor_id
 FROM film_actor
 GROUP BY actor_id
 ORDER BY COUNT(film_id) DESC;
 #from this we see that actor with actor_id 107 has starred in the most films (42)
##didn't finish this lab yet

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