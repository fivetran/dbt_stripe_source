{{ config(enabled=var('using_subscriptions', True)) }}

select * 
from {{ var('subscription_history') }}

{{ livemode_predicate() }}
{% if not var('stripe__keep_subscription_history', false) %}
    and coalesce(_fivetran_active, true)
{% endif %}