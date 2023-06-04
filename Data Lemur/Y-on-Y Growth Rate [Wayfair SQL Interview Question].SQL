/*
Question
Assume you are given the table below containing information on user transactions for particular products. 
Write a query to obtain the year-on-year growth rate for the total spend of each product for each year.

Output the year (in ascending order) partitioned by product id, current year's spend, previous year's spend and year-on-year growth rate 
(percentage rounded to 2 decimal places).

user_transactions Table 

transaction_id	product_id	spend	transaction_date
1341	123424	1500.60	12/31/2019 12:00:00
1423	123424	1000.20	12/31/2020 12:00:00
1623	123424	1246.44	12/31/2021 12:00:00
1322	123424	2145.32	12/31/2022 12:00:00
1344	234412	1800.00	12/31/2019 12:00:00
1435	234412	1234.00	12/31/2020 12:00:00
4325	234412	889.50	12/31/2021 12:00:00
5233	234412	2900.00	12/31/2022 12:00:00
2134	543623	6450.00	12/31/2019 12:00:00
1234	543623	5348.12	12/31/2020 12:00:00
2423	543623	2345.00	12/31/2021 12:00:00
1245	543623	5680.00	12/31/2022 12:00:00
/*

-- QUERY BELOW


select 
year,
product_id,
totalspend as curr_year_spend,
lag(totalspend) over (PARTITION BY product_id order by product_id,year ) as prev_year_spend,
round(((totalspend- lag(totalspend) over (PARTITION BY product_id order by product_id,year))/
lag(totalspend) over (order by product_id,year))*100,2) as yoy_rate


from
(SELECT 
product_id,
extract (year from transaction_date) as year,
sum(spend) as totalspend

FROM user_transactions

group by 
product_id,
extract (year from transaction_date)

order by 
product_id,
extract (year from transaction_date)) as sub

;
