USE sakila;

SELECT * FROM actor; 
SELECT * FROM film;
SELECT * FROM customer;

SELECT title FROM film;
#returns a list of films in the results grid

SELECT name FROM language;
#there are 6 languages: 'English', 'Italian', 'Japanese', 'Mandarin', 'French','German'

#5.1 Find out how many stores does the company have?
SELECT store_id FROM store;
#there are 2 stores 

#5.2 Find out how many employees staff does the company have?
SELECT * FROM staff;
#appears to be 2 employee staff 

#5.3 Return a list of employee first names only?
SELECT first_name FROM staff;
#Mike and Jon