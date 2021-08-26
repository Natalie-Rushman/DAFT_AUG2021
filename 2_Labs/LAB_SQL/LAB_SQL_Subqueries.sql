/*
    How many copies of the film Hunchback Impossible exist in the inventory system?
*/

SELECT title, COUNT(inventory.inventory_id) AS film_copies FROM film
INNER JOIN inventory ON inventory.film_id = film.film_id
GROUP BY title
HAVING title LIKE 'Hunchback Impossible'; /* 6 */

SELECT COUNT(film_id) AS nbr_copies FROM inventory
WHERE film_id = (
SELECT film_id FROM film
WHERE title = 'Hunchback Impossible'
); /* 6 */

/*
    List all films whose length is longer than the average of all the films.
*/

SELECT AVG(length) FROM film; /* 115 */

SELECT title, length FROM film 
WHERE length > (SELECT AVG(length) FROM film); /* Listing all films longer than 115 min */

/*
    Use subqueries to display all actors who appear in the film Alone Trip.
*/

SELECT last_name, film.title FROM actor
INNER JOIN film_actor ON film_actor.actor_id=actor.actor_id
INNER JOIN film ON film_actor.film_id=film.film_id
WHERE title = 'ALONE TRIP';

SELECT CONCAT(first_name , ' ' , last_name) AS Actor
FROM sakila.actor
WHERE actor_id in (
	SELECT actor_id
	FROM film_actor
	WHERE film_id = (
		SELECT film_id
		FROM film
		WHERE title = 'ALONE TRIP'
		)
	);

/*
    Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
    Identify all movies categorized as family films.
*/

SELECT DISTINCT `name` FROM category; /* Family, Children, Animation */

SELECT title as Title FROM sakila.film
WHERE film_id IN (
	SELECT film_id FROM sakila.film_category
	WHERE category_id IN (
		SELECT category_id FROM sakila.category
		WHERE name = 'Family'
		)
	);

/*
    Get name and email from customers from Canada using subqueries. 
    Do the same with joins. 
    Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
    that will help you get the relevant information.
*/

SELECT last_name, email FROM customer; /* Select all customers */
SELECT country from country WHERE country = "Canada"; /* Select Canada */ 

SELECT last_name, email, country.country FROM customer
INNER JOIN address ON address.address_id = customer.address_id
INNER JOIN city ON city.city_id=address.city_id
INNER JOIN country ON country.country_id=city.country_id
WHERE country = "Canada"; 

SELECT CONCAT(first_name , ' ' , last_name) AS Customer, email FROM sakila.customer
WHERE address_id in (
	SELECT address_id FROM sakila.address
	WHERE city_id in (
		SELECT city_id FROM sakila.city
		WHERE country_id in (
			SELECT country_id FROM sakila.country
			WHERE country = 'Canada'
			)
		)
	);

/*
    Which are films starred by the most prolific actor? 
    Most prolific actor is defined as the actor that has acted in the most number of films. 
    First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
*/

SELECT CONCAT(first_name, ' ', last_name), COUNT(actor.actor_id) AS actors_films FROM sakila.actor
INNER JOIN sakila.film_actor ON actor.actor_id=film_actor.actor_id
INNER JOIN sakila.film ON film_actor.film_id=film.film_id
GROUP BY actor.actor_id
ORDER BY COUNT(film.film_id) DESC LIMIT 1;

SELECT CONCAT(first_name, ' ', last_name) AS actor_name, film.title, film.release_year FROM sakila.actor
INNER JOIN sakila.film_actor USING (actor_id)
INNER JOIN film USING (film_id)
WHERE actor_id = (
	SELECT actor_id FROM sakila.actor
	INNER JOIN sakila.film_actor USING (actor_id)
	INNER JOIN sakila.film USING (film_id)
	GROUP BY actor_id
	ORDER BY COUNT(film_id) DESC LIMIT 1
	)
	ORDER BY release_year DESC;

/*
    Films rented by most profitable customer (FROM customer and payment the largest sum of payments)
    Customers who spent more than the average payments. 
    Probably the customers' average amount, I guess, not simply the average of a single payment...
*/

SELECT AVG(amount) FROM payment; /* 4,20 individual payment */

SELECT DISTINCT last_name, SUM(payment.amount) AS payment_customer FROM customer
INNER JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY last_name
HAVING payment_customer > (SELECT AVG(amount) FROM payment)
ORDER BY payment_customer DESC LIMIT 1; /* SEAL: 221.55,- */

SELECT DISTINCT last_name, SUM(payment.amount) AS payment_customer FROM customer
INNER JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY last_name
HAVING payment_customer > (SELECT AVG(amount) FROM payment); /* List of all Customers and the sum of their payments */

SELECT film_id, title, rental_date, amount FROM sakila.film
INNER JOIN inventory USING (film_id)
INNER JOIN rental USING (inventory_id)
INNER JOIN payment USING (rental_id)
WHERE rental.customer_id = (
	SELECT customer_id FROM customer
	INNER JOIN payment USING (customer_id)
	GROUP BY customer_id
	ORDER BY SUM(amount) DESC LIMIT 1
	)
ORDER BY rental_date DESC; /* List of films rented by Customer Seal */

/* SELECT DISTINCT last_name, SUM(payment.amount) AS payment_customer FROM customer
INNER JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY customer_id
HAVING (SELECT AVG(payment_customer) FROM payment) > (SELECT AVG(amount) FROM payment); */

SELECT customer_id, SUM(amount) AS payment FROM sakila.customer
INNER JOIN payment USING (customer_id)
GROUP BY customer_id
HAVING SUM(amount) > (
	SELECT AVG(total_payment) FROM (
		SELECT customer_id, SUM(amount) total_payment FROM payment
		GROUP BY customer_id
		) t
	)
ORDER BY payment DESC;

