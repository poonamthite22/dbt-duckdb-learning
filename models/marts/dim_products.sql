{{config(materialized='table')}}

SELECT DISTINCT
     product_id,unit_price
FROM{{ref('stg_orders_dedup')}}     