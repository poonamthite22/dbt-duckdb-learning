{{ config(materialized='table') }}

WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        amount,
        order_date,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY order_date DESC
        ) AS rn
    FROM {{ ref('stg_orders') }}
)

SELECT
    order_id,
    customer_id,
    amount,
    order_date
FROM ranked_orders
WHERE rn = 1
