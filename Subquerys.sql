USE sakila;

#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system
SELECT * FROM inventory;
SELECT * FROM film;

SELECT COUNT(*) AS copies
FROM inventory i
JOIN film f
ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';

#List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length FROM film
WHERE length > (SELECT AVG(length) FROM film);

#Use a subquery to display all actors who appear in the film "Alone Trip".
#SELECT * FROM film_actor;
#SELECT * FROM film;
#SELECT * FROM actor;
#SELECT a.actor_id
#FROM actor a
#JOIN film_actor  fa
#USING (actor_id)
#JOIN film f
#USING (film_id)
#WHERE f.title = 'Alone Trip';
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film 
    USING (film_id)
    WHERE film.title = 'Alone Trip'
);
#Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT * FROM category;
SELECT f.title
FROM film f
WHERE f.film_id IN (
	SELECT fc.film_id
    FROM film_category fc
    JOIN category c
    USING (category_id)
    WHERE c.name = 'Family'
    );
    
#Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT * FROM customer;
SELECT * FROM country;
SELECT * FROM city;
SELECT cu.first_name, cu.email
FROM customer cu
WHERE cu.address_id IN (
	SELECT ad.address_id
    FROM address ad
    JOIN city ci
    USING (city_id)
    JOIN country co
    USING (country_id)
    WHERE co.country = 'Canada'
    );

#Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
SELECT film_id, title
FROM film f
WHERE f.film_id IN (
	SELECT film_id
	FROM film_actor fa
	WHERE actor_id = (
			SELECT actor_id
			FROM (
				SELECT actor_id, COUNT(*) AS film_count
				FROM film_actor
				GROUP BY actor_id
				ORDER BY film_count DESC
				LIMIT 1
	) AS mas_plata
		)
    );


    
    
