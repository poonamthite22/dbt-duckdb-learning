-- REMOVING CANCELLED ORDERS AND ADDING TOTAL REVENUE

{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

SELECT
    order_id,
    customer_id,
    product_id,
    quantity,
    unit_price,
    quantity * unit_price AS total_revenue,
    order_date
FROM {{ ref('stg_orders_dedup') }}

WHERE status = 'completed'

{% if is_incremental() %}

AND order_date > (
    SELECT max(order_date) FROM {{ this }}
)

{% endif %}