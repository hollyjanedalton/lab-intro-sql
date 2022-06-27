use sakila;

#Activity 1
#1. Drop column picture from staff.
SELECT * from staff;

ALTER TABLE staff
DROP picture;

#2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. 
#Update the database accordingly.
SELECT * FROM staff;

INSERT INTO sakila.staff(staff_id, first_name, last_name, address_id, email, store_id, active, username) 
VALUES                    (3,      'Tammy',     'Sanders',      79,   'TAMMY.SANDERS@sakilacustomer.org',2, 1, 'Tammy' );

SELECT * from customer
WHERE first_name = "TAMMY" AND last_name = "SANDERS";

#3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
#You can use current date for the rental_date column in the rental table. 
#Hint: Check the columns in the table rental and see what information you would need to add there. 
#You can query those pieces of information. For eg., you would notice that you need customer_id 
#information as well. To get that you can use the following query:

#A customer named Charlotte Hunter has rented the movie "Academy Dinosaur" from Store 1, and the employee
#who rented it to her is Mike Hillyer. Add this rental to the database

#Where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
#Use similar method to get inventory_id, film_id, and staff_id.

SELECT * FROM sakila.customer 
WHERE first_name = 'CHARLOTTE' AND last_name= 'HUNTER';

SELECT * FROM sakila.staff;

SELECT * FROM inventory
WHERE film_id = 1 AND store_id = 1; 

SELECT * FROM film
WHERE title = 'ACADEMY DINOSAUR';

#FINAL ANSWER
INSERT INTO sakila.rental(rental_id,      inventory_id,   customer_id,       staff_id) 
VALUES                    (16050,            '1',           130,          		1);
#We find that the dates are automatically added 

SELECT * FROM sakila.rental
WHERE rental_id = 16050;
#checking to see if the rental exists, and it does!

#Activity 2
#1. Propose a new structure for the Sakila database.
-- Consolidate the tables Country and City into the Address table.
-- Consolidate the Language table with the film table


#2. Define primary keys and foreign keys for the new database.
#There are several tables that have the same primary keys
-- Keep the same Primary keys in the Address table and Film table
	