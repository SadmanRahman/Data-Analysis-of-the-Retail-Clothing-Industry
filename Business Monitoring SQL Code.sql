-- Business Productivity Monitoring 

-- Fastetst Delivery in Day
with delivery_analysis as(
select 
	order_id,
    customer_id, 
    payment, 
    order_date, 
    delivery_date, 
	datediff(order_date, delivery_date)	Delivery_Days
 from orders)
 select 
		max(delivery_days) as fastest_delivery_in_day
    from delivery_analysis
 ;

-- Slowest Delivery in Days
with delivery_analysis as(
select 
	order_id,
    customer_id, 
    payment, 
    order_date, 
    delivery_date, 
	datediff(order_date, delivery_date)	Delivery_Days
 from orders)
 select 
		min(delivery_days) as slowest_delivery_in_day
    from delivery_analysis
 ;
 
 -- Average Delay in Days
with delivery_analysis as(
select 
	order_id,
    customer_id, 
    payment, 
    order_date, 
    delivery_date, 
	datediff(order_date, delivery_date)	Delivery_Days
 from orders)
 select 
		avg(delivery_days) average_delay
    from delivery_analysis
 ;
 
 -- Month Wise Average Delay
with delivery_analysis as(
select 
	order_id,
    customer_id, 
    payment, 
    order_date, 
    delivery_date, 
	datediff(order_date, delivery_date)	Delivery_Days
 from orders)
 select 
		month(order_date) Month_Number	,
		round(avg(delivery_days),2)	 as Avg_Delay
        from delivery_analysis
group by Month_Number
order by Month_number asc
 ;
 
 -- Average Delay By State
with delay_analysis as (
SELECT 
	c. customer_id,
    c. state,
    o. order_id, 
    o. order_date, 
    o. delivery_date,
	datediff(order_date, delivery_date) as Delay_Days
from
	customers c
inner join
	orders o
on
	c. customer_id = o. customer_id)

select 
	STATE, 
	round(avg(delay_days),2) avg_delay_days	 
    from delay_analysis    
group by state
order by avg_delay_days asc
    ;
    
-- Month Wise Sales and Average Delay Comparison
with sales_delay_comparison as (
select 
	o. order_id,
    o. order_date,
    o. delivery_date,
    s. total_price,
    datediff(order_date, delivery_date) as avg_delay_days
from
	orders o
join
	sales s
on
	o. order_id = s. order_id)
select 
	month(order_date) as month_number,
	round(avg(avg_delay_days),2) as avg_delay, 
    sum(total_price) as total_sales
 from sales_delay_comparison
 group by month_number
 order by month_number
    ;