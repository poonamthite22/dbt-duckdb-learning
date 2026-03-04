{{config(materialized='table')}}

SELECT 
order_date, 
sum(total_revenue)as daily_revenue,
count(order_id) as total_orders

from{{ref('fct_orders')}}
group by order_date