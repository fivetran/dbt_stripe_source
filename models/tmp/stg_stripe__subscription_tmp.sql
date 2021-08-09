{{ config(enabled=var('using_subscriptions', True)) }}

select * 
from {{ var('subscription') }}

{{ predicate_by_config_livemode() }}
