{{ config(enabled=var('stripe__using_subscriptions', True)) }}

select * 
from {{ var('plan') }}

{{ livemode_predicate() }}
