/*
    How many copies of the film Hunchback Impossible exist in the inventory system?
*/

SELECT title from film
WHERE title LIKE '%Hunchback%'; /* Lists all film titles incl. Hunchback */

SELECT title, COUNT(inventory.inventory_id) AS film_copies FROM film
INNER JOIN inventory ON inventory.film_id = film.film_id
GROUP BY title
HAVING title LIKE 'Hunchback Impossible'; /* 6 */


/*
    List all films whose length is longer than the average of all the films.
*/

SELECT AVG(length) FROM film; /* 115 */

SELECT title, length FROM film 
WHERE length > (SELECT AVG(length) FROM film); /* Listing all films longer than 115 min */

/*
    Use subqueries to display all actors who appear in the film Alone Trip.
*/

SELECT title, actor.last_name FROM film
WHERE title LIKE 'ALONE TRIP');

/*
    Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
    Identify all movies categorized as family films.
*/

SELECT DISTINCT `name` FROM category; /* Family, Children, Animation */

SELECT title FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
WHERE (SELECT "FAMILY", "CHILDREN", "ANIMATION" FROM category) IN category.name;

/*
    Get name and email from customers from Canada using subqueries. 
    Do the same with joins. 
    Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
    that will help you get the relevant information.
*/

SELECT last_name, email FROM customer; /* Select all customers */
SELECT country from country WHERE country = "Canada"; /* Select Canada */ 

SELECT last_name, email FROM customer
INNER JOIN address ON address.address_id = customer.address_id /* Where do they match?*/
WHERE (SELECT country FROM country WHERE country = "Canada"); 

/*
    Which are films starred by the most prolific actor? 
    Most prolific actor is defined as the actor that has acted in the most number of films. 
    First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
*/

SELECT last_name, COUNT(SELECT film_id AS nbr_films_per_actor) FROM actor
ORDER BY nbr_films_per_actor DESC;

SELECT actor.last_name, COUNT(*) FROM actor
WHERE actor.actor_id = film.actor_id;


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

SELECT DISTINCT last_name, SUM(payment.amount) AS payment_customer FROM customer
INNER JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY customer_id
HAVING (SELECT AVG(payment_customer) FROM payment) > (SELECT AVG(amount) FROM payment);