/*Question 1: Which city corresponds to the best customers(customer who spent the most money)?*/
select  city, sum(total) as invoice_total
from customer as c
left join Invoice as i1 
using(CustomerId)
Group by city
order by invoice_total desc
limit 1;
/* Question 2: Which countries have the most Invoices?*/
SELECT Billingcountry ,COUNT( Billingcountry) AS Invoice_Number
FROM Invoice
GROUP BY Billingcountry
ORDER BY Invoice_Number DESC
limit 8;
/* Question 3 :Name the best customer (customer who spent the most money).*/
select  firstname, lastname,  sum(total) as invoice_total_per_person
from customer as c
left join Invoice as i1 
using(CustomerId)
Group by firstname, lastname
order by invoice_total_per_person desc
limit 1;
/*Question 4: You want to host a rock concert in a country and want to know which location should host it. I find out the city with the most rock-music listeners(it's was the location we need).*/
select *
from genre as g
where g.name = "Rock" /* we find genreid for "Rock" = 1*/;
Select count( distinct customerid) as total_person, Billingcountry
from Invoice as i1
inner join InvoiceLine as i2
using(InvoiceId)
inner join Track as t 
Using(trackid)
where genreid = "1"
group by Billingcountry
order by total_person desc;

/* Question 5: We want to find out the most popular music Genre for each country and the highest amount if count person same*/

With number_amount_per_country_genre as ( 
Select Billingcountry, g.name, count(customerid)  as total_person
from Invoice as i1
inner join InvoiceLine as i2
Using(InvoiceId)
inner join track as t 
using(trackid)
inner join genre as g 
using(genreid)
Group by 1,2
order by 1,3 desc),
max_person_genre_country as (
Select max(total_person) as max_genre_country, Billingcountry
from number_amount_per_country_genre
Group by 2
order by 2)
 SELECT nacg.* 
FROM number_amount_per_country_genre as nacg
JOIN max_person_genre_country as mpgc ON nacg.Billingcountry = mpgc.Billingcountry
where nacg.total_person = mpgc.max_genre_country;


