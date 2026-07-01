select * from restaurant_analysis


-- Task 1: Top cuisines
-- Top 3 cuisines
-- % share

CREATE TABLE Top_cuisines AS
select 
	cuisines ,
	count(*) as total , 
	round(count(*)*100/sum(count(*))over(),2) as pct_share
from restaurant_analysis
group by 1
order by 2 desc
limit 3


-- Task 2: City analysis
-- Do:
-- Most restaurants by city

create table res_by_city as
select city , count( distinct restaurant_id) as total
from restaurant_analysis
group by 1
order by total desc
limit 5

-- Average rating by city

create table avg_rating_by_city as
select city ,round(avg(aggregate_rating)::numeric,2) as rating
from restaurant_analysis
group by 1

-- Highest rated city

create table highest_rated_city as
select city ,round(avg(aggregate_rating)::numeric,2) as rating
from restaurant_analysis
group by 1
order by 2 desc
limit 5


-- Task 4: Online delivery
-- Do:
-- % offering online delivery
-- Ratings comparison

create table offer_online_delivery as
select
	has_online_delivery,
	count(*) as total,
	round(count(*)*100/sum(count(*))over(),2) as pct
from restaurant_analysis
group by 1


create table online_res_Rate_comparison as
select
	has_online_delivery,
	count(*) as total,
	round(avg(aggregate_rating)::numeric,2) as delivery_online_avg_rate_restaurant
from restaurant_analysis
group by 1


-- Level 2 SQL
-- Task 1: Restaurant Ratings

create table rating_range as
select count(distinct restaurant_id) as total,
	  case 
	   	when aggregate_rating >= 0 and aggregate_rating <= 1 then '0-1'
		when aggregate_rating > 1 and aggregate_rating <= 2 then '1-2'
		when aggregate_rating > 2 and aggregate_rating <= 3 then '2-3'
		when aggregate_rating > 3 and aggregate_rating <= 4 then '3-4'
		else '4-5'
		end rating_range
from restaurant_analysis
group by rating_range
order by 2 desc



-- Average number of votes

SELECT ROUND(AVG(votes),2) AS avg_votes
FROM restaurant_analysis;


--restaurent chain 

select restaurant_name , count(restaurant_name) as total
from restaurant_analysis
group by 1
having count(restaurant_name)>1
order by 2 desc


select restaurant_name , count(restaurant_name) as total , ROUND(AVG(aggregate_rating)::numeric,2) AS avg_rating
from restaurant_analysis
group by 1
having count(restaurant_name)>1
order by 2 desc


SELECT 
    restaurant_name,
    SUM(votes) AS total_votes
FROM public.restaurant_analysis
GROUP BY restaurant_name
HAVING COUNT(*) > 1
ORDER BY total_votes DESC;
