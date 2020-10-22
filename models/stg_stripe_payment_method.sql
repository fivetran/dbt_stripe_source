{{ config(enabled=var('using_payment_method', True)) }}

with payment_method as (

    select *
    from {{ var('payment_method') }}

), fields as (

    select 
      id as payment_method_id,
      created as created_at,
      customer_id,
      type
    from payment_method

)

select *
from fields