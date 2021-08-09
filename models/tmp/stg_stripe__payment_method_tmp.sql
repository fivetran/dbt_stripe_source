{{ config(enabled=var('using_payment_method', True)) }}

select * 
from {{ var('payment_method') }}

{{ predicate_by_config_livemode() }}
