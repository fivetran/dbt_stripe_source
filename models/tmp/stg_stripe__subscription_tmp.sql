{{ config(enabled=var('stripe__using_subscriptions', True)) }}

select * 
from {% if var('stripe__subscription_history', false) %}
{{ var('subscription_history') }}
{% else %}
{{ var('subscription') }}
{% endif %}

{{ livemode_predicate() }}
{% if var('stripe__subscription_history', false) %}
    and coalesce(_fivetran_active, true)
{% endif %}