/* Get release years.*/

SELECT DISTINCT release_year FROM sakila.film; /* All from 2006 */

/* Get all films with ARMAGEDDON in the title.*/

SELECT title FROM sakila.film
WHERE title LIKE "%ARMAGEDDON%";

/* Get all films which title ends with APOLLO.*/

SELECT title FROM sakila.film
WHERE title LIKE "%ARMAGEDDON";

/* Get 10 the longest films.*/

SELECT title, length FROM sakila.film
ORDER BY length DESC LIMIT 10;

/* How many films include Behind the Scenes content?*/

SELECT title, special_features FROM sakila.film
GROUP BY title;

/* Drop column picture from staff.*/

ALTER TABLE staff DROP COLUMN picture;

/* A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.*/

INSERT INTO staff (first_name, last_name)
VALUES ("Tammy", "Sanders"); 

SELECT * FROM staff;

/* Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
You can use current date for the rental_date column in the rental table. 
Hint: Check the columns in the table rental and see what information you would need to add there. 
You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
To get that you can use the following query:

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

/* Use similar method to get inventory_id, film_id, and staff_id.*/

/*  Delete non-active users, but first, create a backup table deleted_users to store 
customer_id, email, and the date for the users that would be deleted. 
        - Check if there are any non-active users
        - Create a table backup table as suggested
        - Insert the non active users in the table backup table
        - Delete the non active users from the table customer
*/