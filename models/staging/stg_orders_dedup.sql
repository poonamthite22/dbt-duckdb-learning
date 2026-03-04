{{config(materialized='table')}}

with ranked_orders As(
    SELECT 
         order_id,customer_id,product_id,quantity,unit_price,order_date,status,
         ROW_NUMBER() over (partition by order_id 
         order by order_date DESC) As rn

         FROM {{ref('stg_orders')}}
)
SELECT* from ranked_orders
where rn = 1
