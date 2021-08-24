
    /*
    How many films are there for each of the categories in the category table. 
    Use appropriate join to write this query.
    */
     
		/* Check again */
SELECT `name`, COUNT(film_category.category_id) AS films_by_genre FROM category
INNER JOIN film_category ON film.film_id = film_category.film_id
GROUP BY category.category_id;

    /*
    Which actor has appeared in the most films?
    */
    
		/* Check again */
SELECT actor.last_name, COUNT(film.film_id) AS films_per_actor FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id;

    
    /*
    Most active customer (the customer that has rented the most number of films)
    */
    
SELECT customer.last_name, COUNT(rental.rental_id) AS nbr_rental FROM customer
INNER JOIN rental ON rental.customer_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY nbr_rental DESC LIMIT 1;
    
    
    /*
    List number of films per category.
    */
    
			/* s. Number 1. */
    
    /*
    Display the first and last names, as well as the address, of each staff member.
    */
    
SELECT first_name, last_name, address.address FROM staff
INNER JOIN address ON staff.address_id = address.address_id
GROUP BY staff_id;
    
    /*
    Display the total amount rung up by each staff member in August of 2005.
    */
    
    /* Check again */
SELECT staff.last_name, SUM(payment.amount) FROM staff
INNER JOIN payment ON payment.staff_id = staff.staff_id
GROUP BY staff.staff_id
HAVING payment.payment_date = "2005-08-%";
    
    /*
    List each film and the number of actors who are listed for that film.
    */
    
SELECT film.title, COUNT(film_actor.actor_id) AS nbr_actors FROM film
INNER JOIN film_actor ON film_actor.film_id=film.film_id
GROUP BY film.title
ORDER BY COUNT(nbr_actors) DESC;

    /*
    Using the tables payment and customer and the JOIN command, 
    list the total paid by each customer. 
    List the customers alphabetically by last name. 
*/

SELECT customer.first_name, customer.last_name, SUM(payment.amount) FROM customer
INNER JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY customer.last_name;
  
  /*
  Bonus: Which is the most rented film? 
    The answer is Bucket Brotherhood. 
    This query might require using more than one join statement. Give it a try.
    */

SELECT film.title, COUNT(rental.rental_id) AS most_rented FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
ORDER BY most_rented DESC LIMIT 1;