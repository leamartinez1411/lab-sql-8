--  Lab | SQL Queries 7


--  Which last names are not repeated?
SELECT `first_name`
FROM `customer`
GROUP BY `first_name`
HAVING COUNT(*) = 1

--  Which last names appear more than once?
SELECT `first_name`
FROM `customer`
GROUP BY `first_name`
HAVING COUNT(*) > 1

--  Rentals by employee.
select staff_id, count(*) as number_rental
from rental
group by staff_id ; 

--  Films by year.
select release_year, count(*) as number_film
from film
group by release_year
UNION
select release_year, count(*) as number_film
from film_update
group by release_year ; 

--  Films by rating.
select rating, count(*) as number_film
from film
group by rating
UNION
select rating, count(*) as number_film
from film_update
group by rating ; 

--  Mean length by rating.
select rating, avg(length) as avg_length
from film
group by rating
UNION
select rating, avg(length) as avg_length
from film_update
group by rating ; 

--  Which kind of movies (rating) have a mean duration of more than two hours?
select rating, avg(length) as avg_length
from film
group by rating
having avg(length)>120
UNION
select rating, avg(length) as avg_length
from film_update
group by rating
having avg(length)>120 ;

--  List movies and add information of average duration for their rating and original language.
select title, rating, avg(length) over (partition by title) as avg_duration from film;

--  Which rentals are longer than expected?
select rental_id, inventory_id, DATEDIFF(return_date, rental_date) as rental_duration_calc from rental ; 

******************************

--  Lab | SQL Queries 8

--  Rank films by length.
select title, rank() over(order by length asc) as 'Rank_length'
from film ;

--  Rank films by length within the rating category.
select film_id, title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, replacement_cost, special_features, rank() over(order by length asc) as 'Rank_length' from film ; 

--  Rank languages by the number of films (as original language).
select original_language_id, count(*) as number_films
from film
group by original_language_id
order by original_language_id asc; 

--  Rank categories by the number of films.
select category_id, count(*) as number_films
from film_category
group by category_id
order by category_id asc ; 

-- with rank
select category_id, count(*) as number_films, rank() over(order by count(film_id) asc) as 'rank'
from film_category
group by category_id
order by number_films asc ; 

--  Which actor has appeared in the most films?
select actor_id, count(actor_id) as number
from film_actor
group by actor_id
order by number desc
limit 1; 

--  Most active customer.
select customer_id, count(customer_id) as number
from rental
group by customer_id
order by number desc
limit 1; 

--  Most rented film.
select rental.inventory_id, count(rental.inventory_id) as number, inventory.film_id, film.title
from rental, inventory, film
where rental.inventory_id=inventory.inventory_id
and inventory.film_id=film.film_id
group by rental.inventory_id
order by number desc
limit 1 ; 

-- It's Zorro Ark

