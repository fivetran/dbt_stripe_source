{{ config(enabled=var('stripe__using_payment_method', True)) }}

select * 
from {{ var('payment_method_card') }}


