use sakila;

-- Task 1 - Display the full names of actors available in the database
select concat(first_name,'',last_name) as Fullname
from actor; 

/*-- Task 2 - The management wants to know that if any actors name appearing frequently
a)display the number of times each first names of actors appears in the database
b)display the number of unique first name of the actors in the database*/

select first_name , count(first_name)
from actor
group by first_name
order by count(first_name) desc;
 
select distinct(first_name) from actor;
-- There are totally 128 unique firstname present in the database 

/*--Task 3 - The management is interested in unique lastnames of the actors
a)display the number of times each last names of actors appears in the database
b)display the number of unique first name of the actors in the database       */

select last_name ,count(last_name) from actor
group by last_name
order by count(last_name) desc;

select distinct(last_name) 
from actor;
-- There are totally 200 distinct lastname present in the database

/*--Task 4 - The managemnt wants to analyze the movies based on movie ratings
a) Display the record of movies with R rating
b) Display the record of movies that are not rated as R 
c) Display the record of movies That are for below age of 13 years old                    */

select title, rating from film
where rating='R';
-- Total record of 195 movies which has R rating

select title , rating from film
where rating not in ('R');
-- Total record of 200 movies that are not rated as R

select title , rating from film
where rating='G';
-- Total 178 records of movies which are rated as G

/* Task 5 - the board of members wants to understand the replacement cost of the movies
a) The replacement cost of movies which upto $11 
b) The replacement cost of movies between 11 to $20
c) All movies in descending order by replacement cost                   */

select title as Title , replacement_cost from film
where replacement_cost<=11
order by title;
-- Ther are totally 90 records where replacement cost is upto $11

select title as 'Title' , replacement_cost as 'Replacement_Cost' from film
where replacement_cost between 11 and 20;
-- There are totally 200 records where replacement_cost id between 11 to 20 $

select title as Title , replacement_cost as 'Replacement cost'
from film
order by replacement_cost desc; 
-- All movie records 


-- Task 6 - Display the name of the top 3 movies which has greatest number of actors

select film_id , title as Title , count(actor_id) as 'Number of actors'
from film 
join film_actor using(film_id)
group by film_id;


-- Task 7 - Movie starting with the letter K and Q 

select title from film 
where title like('K%')or
title like('Q%');


-- Task 8 - The actors present in the film "Agent Truman"

select concat(first_name,' ',last_name) as Fullname from actor
inner join film_actor using(actor_id)
inner join film using(film_id)
where film.title =('AGENT TRUMAN')
group by Fullname;


-- Task 9 - Identify and display all the family movies

select title as 'Family movies' from film
join film_category using(film_id)
join category using(category_id)
where category.name='Family'
order by title;
-- There are totally 69 family movies 


/* Task 10 - The managemnt wants to observe rental rates and rental frequencies
a) Display min,max,avg rental rates of the movies based on their Ratings,the output sort in descending order by avg(rental rates) 
b) Display the movies in descending order based on their rental frequencies												*/

select rating,max(rental_rate),min(rental_rate),avg(rental_rate) 
from film
group by rating
order by avg(rental_rate) desc;

select title,rental_duration from film
order by rental_duration desc;


/*Task 11  */

select category.name,count(film_id) as 'number of movies',avg(replacement_cost),avg(rental_rate) from category
inner join film_category using(category_id)
inner join film using(film_id)
group by category.name
having (avg(replacement_cost)-avg(rental_rate))>15;



-- Task 12 - Film categories in which the number of movies is greater than 70 movies

select category.name,count(film_id) as Total_movies  from category
inner join film_category using(category_id)
inner join film using(film_id)
group by category.name
having count(film_id)>70;

