/* Write a query to display for each store its store ID, city, and country. */

SELECT store_id, city, country FROM store
INNER JOIN address ON address.address_id=store.address_id
INNER JOIN city ON city.city_id=address.city_id
INNER JOIN country ON country.country_id=city.country_id
GROUP BY store_id; 		/* Displays list with store_id, city, country */

/* Write a query to display how much business, in dollars, each store brought in. */

SELECT store.store_id, SUM(payment.amount) AS revenue FROM store
INNER JOIN customer ON store.store_id=customer.store_id
INNER JOIN payment ON customer.customer_id=payment.customer_id
GROUP BY store_id;		/* 1: 37001,52; 2: 30414,99 */

/* What is the average running time of films by category? */

SELECT DISTINCT category.name AS category_name, AVG(film.length) AS average_length FROM film_category
INNER JOIN category ON film_category.category_id=category.category_id
INNER JOIN film ON film.film_id=film_category.film_id
GROUP BY category_name;		/* lists average film duration of the respective categories */

/* Which film categories are longest? */

SELECT DISTINCT category.name AS category_name, AVG(film.length) AS average_length FROM film_category
INNER JOIN category ON film_category.category_id=category.category_id
INNER JOIN film ON film.film_id=film_category.film_id
GROUP BY category_name
ORDER BY average_length DESC LIMIT 3;		/* Sports, Games, Foreign */

/* Display the most frequently rented movies in descending order. */

SELECT film.title, COUNT(rental.rental_id) as rentals FROM film
INNER JOIN inventory ON film.film_id=inventory.film_id
INNER JOIN rental ON inventory.inventory_id=rental.inventory_id
GROUP BY film.title
ORDER BY rentals DESC LIMIT 3; /* Bucket Brotherhood, Rocketeer Mother, Grit Clockwork */

/* List the top five genres in gross revenue in descending order. */

SELECT category.name AS category_name, SUM(amount) AS revenue FROM payment
INNER JOIN rental ON rental.rental_id=payment.rental_id
INNER JOIN inventory ON inventory.inventory_id=rental.inventory_id
INNER JOIN film ON film.film_id=inventory.film_id
INNER JOIN film_category ON film_category.film_id=film.film_id
INNER JOIN category ON category.category_id=film_category.category_id
GROUP BY category_name
ORDER BY revenue DESC LIMIT 5;		/* returns result list */

/* Is "Academy Dinosaur" available for rent from Store 1? */

SELECT film.film_id, film.title, store.store_id, inventory.inventory_id FROM inventory
INNER JOIN store ON store.store_id=inventory.store_id
INNER JOIN film ON film.film_id=inventory.film_id
WHERE title="ACADEMY DINOSAUR" and store.store_id="1"; /* Four copies in store 1 */