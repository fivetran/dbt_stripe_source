{{ config(enabled=var('using_subscriptions', True)) }}

select * 
from {{ var('subscription_history') }}

{{ livemode_predicate() }}
