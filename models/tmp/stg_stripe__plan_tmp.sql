{{ config(enabled=var('using_subscriptions', True)) }}

select * 
from {{ var('plan') }}

{{ predicate_by_config_livemode() }}
