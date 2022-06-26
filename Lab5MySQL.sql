USE sakila;
#1 Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country
FROM sakila.store s
JOIN sakila.address a
ON s.address_id = a.address_id
JOIN sakila.city c
ON a.city_id = c.city_id 
JOIN sakila.country co
ON c.country_id = co.country_id;

#2 Which film categories are longest?
#Meaning... which film category has the most films? 

SELECT c.name, COUNT(f.film_id) as number_of_films
FROM sakila.film_category fc
JOIN sakila.category c
ON c.category_id = fc.category_id
JOIN sakila.film f
ON f.film_id = fc.film_id
GROUP BY name
ORDER BY COUNT(f.film_id) DESC;

#3 Display the most frequently rented movies in descending order.
SELECT title, COUNT(r.rental_id) as frequency_of_rental
FROM sakila.film f
JOIN sakila.inventory i
ON f.film_id = i.film_id
JOIN sakila.rental r
ON r.inventory_id = i.inventory_id
GROUP BY title
ORDER BY COUNT(r.rental_id) DESC;

#4 List the top five genres in gross revenue in descending order.
SELECT name AS genre, SUM(p.amount) as gross_revenue_$
FROM sakila.film f
JOIN sakila.inventory i
ON f.film_id = i.film_id
JOIN sakila.rental r
ON r.inventory_id = i.inventory_id
JOIN sakila.payment p
ON p.rental_id = r.rental_id
JOIN sakila.film_category fc
ON fc.film_id = f.film_id
JOIN sakila.category c
ON c.category_id = fc.category_id
GROUP BY name
ORDER BY SUM(amount) DESC
LIMIT 5;

#5 Is "Academy Dinosaur" available for rent from Store 1?
#how do I figure out how many copies of Academy Dinosaur Store 1 has? If there are multiple copies, one copy could be rented
#but still other copies are available to rent.

SELECT return_date, rental_date, store_id, film_id AS academy_dinosaur
FROM sakila.inventory i
JOIN sakila.rental r
ON r.inventory_id = i.inventory_id
WHERE store_id = 1 AND film_id = 1;
#it looks like it was last returned on 2005-08-30 22:26:43, so yes, it's available to rent?
# if there were no return_date, i could possibly assume it hasn't been returned yet


SELECT title, inventory_id
FROM sakila.film, sakila.inventory
WHERE title = "Academy Dinosaur" AND inventory.store_id = 1;

#6 Get all pairs of actors that worked together.
#can't figure this one out. think i need to do a self join on film_actor table and then join it with the actor table
#to get the names of the actors, through their actor_ids

SELECT CONCAT(a.first_name, ' ', a.last_name) AS actor_name, a.actor_id, COUNT(DISTINCT(film_id))
FROM sakila.actor a
JOIN sakila.film_actor fa
ON fa.actor_id = a.actor_id
GROUP BY CONCAT(a.first_name, ' ', a.last_name), a.actor_id;

SELECT CONCAT(a.first_name, ' ', a.last_name) as actor_name, fa1.actor_id, fa2.actor_id, fa2.film_id
FROM sakila.film_actor fa1
JOIN sakila.film_actor fa2
ON (fa1.actor_id <> fa2.actor_id) AND (fa1.film_id = fa2.film_id) #self-join where film_id is the same, but actor_is is diff
JOIN sakila.actor a 
ON a.actor_id = fa1.actor_id
GROUP BY CONCAT(a.first_name, ' ', a.last_name), fa1.actor_id, fa2.actor_id, fa1.film_id;

SELECT * 
FROM sakila.actor a
JOIN sakila.film_actor fa1
ON fa1.actor_id = a.actor_id
JOIN sakila.film_actor fa2
ON (fa2.actor_id <> fa1.actor_id) AND (fa2.film_id = fa1.film_id)
GROUP BY fa1.film_id;


#7 Get all pairs of customers that have rented the same film more than 3 times.
#(skip 7 and 8 for now)
#8 For each film, list actor that has acted in more films.