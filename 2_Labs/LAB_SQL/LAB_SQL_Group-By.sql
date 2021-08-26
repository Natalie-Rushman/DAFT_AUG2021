/* In the table actor, what last names are not repeated? 
For example if you would sort the data in the table actor by last_name, 
you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. 
These three actors have the same last name. So we do not want to include this last name in our output. 
Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.*/

SELECT last_name, first_name FROM sakila.actor
ORDER BY last_name; /* Akroyd (3), Allen (3), Bailey (2), Berry (3) ... */ 

SELECT last_name FROM sakila.actor
GROUP BY last_name
HAVING COUNT(DISTINCT first_name) = 1;

/* Which last names appear more than once? 
We would use the same logic as in the previous question but this time 
we want to include the last names of the actors where the last name was present more than once. */

SELECT last_name FROM sakila.actor
GROUP BY last_name
HAVING COUNT(DISTINCT first_name) > 1;

/* Using the rental table, find out how many rentals were processed by each employee. */

SELECT rental.staff_id, CONCAT(staff.first_name, " ", staff.last_name), COUNT(rental.rental_id) FROM sakila.rental
INNER JOIN staff ON rental.staff_id=staff.staff_id
GROUP BY rental.staff_id;  	/* 8040; 8004 */

/* Using the film table, find out how many films were released. */

SELECT COUNT(release_year) AS nbr_films FROM sakila.film; /* not sure about the output of question */

/* Using the film table, find out how many films there are of each rating.*/

SELECT DISTINCT rating, COUNT(*) AS nbr_ratings FROM sakila.film
GROUP BY rating;

/* What is the mean length of the film for each rating type. Round off the average lengths to two decimal places*/

SELECT DISTINCT rating, ROUND(AVG(length),2) AS average_length FROM sakila.film
GROUP BY rating;

/* Which kind of movies (rating) have a mean duration of more than two hours? */

SELECT DISTINCT rating, ROUND(AVG(length),2) AS average_length FROM sakila.film
GROUP BY rating
HAVING average_length > 120;  /* PG-13: 120,44 min) */