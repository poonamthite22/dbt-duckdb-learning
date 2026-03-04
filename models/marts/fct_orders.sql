-- REMOVING CANCELLED ORDERS AND ADDING TOTAL REVENUE 

{{config(materialized='table')}}

SELECT order_id,customer_id,product_id,quantity,unit_price,
quantity*unit_price as total_revenue,
order_date
from{{ref('stg_orders_dedup')}}
where status='completed'