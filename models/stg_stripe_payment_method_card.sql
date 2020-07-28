{{ config(enabled=var('using_payment_method', True)) }}

with payment_method_card as (

    select *
    from {{ var('payment_method_card') }}

), fields as (

    select 
      payment_method_id,
      brand,
      funding
    from payment_method_card

)

select *
from fields