{{ config(enabled=var('stripe__using_subscriptions', True)) }}

select * 
from {% if var('stripe__subscription_history', true) %}
{{ var('subscription_history') }}
{% else %}
{{ var('subscription') }}
{% endif %}

{{ livemode_predicate() }}
{% if var('stripe__subscription_history', true) %}
    and coalesce(_fivetran_active, true)
{% endif %}