{{ config(enabled=var('using_payment_method', True)) }}

select * 
from {{ var('payment_method') }}

{{ livemode_predicate() }}
