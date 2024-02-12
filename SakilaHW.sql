SELECT actor_info.first_name, actor_info.last_name
FROM actor_info
JOIN film_actor ON actor_info.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'ACADEMY DINOSAUR';

SELECT category.name AS category_name, COUNT(film_category.film_id) AS film_count
FROM category
JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.name;

SELECT film.rating, AVG(rental.return_date - rental.rental_date) AS average_rental_duration
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.rating;

SELECT customer.first_name, customer.last_name, COUNT(rental.rental_id) AS total_rentals
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id;

SELECT i.store_id, COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i on r.inventory_id = i.inventory_id
GROUP BY i.store_id
ORDER BY total_rentals DESC
LIMIT 1;

SELECT category.name AS category_name, COUNT(rental.rental_id) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.category_id
ORDER BY rental_count DESC
LIMIT 1;

SELECT category.name AS category_name, AVG(film.rental_rate) AS average_rental_rate
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

SELECT film.title, MAX(rental.rental_date) AS last_rental_date
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_date IS NULL OR rental.rental_date < DATE_SUB(NOW(), INTERVAL 1 MONTH)
GROUP BY film.title;

SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name,
SUM(payment.amount) AS total_spending
FROM customer
JOIN payment on customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;

SELECT language.name AS language, AVG(film.length) AS average_length
FROM film
JOIN language ON film.language_id = language.language_id
GROUP BY language.name;