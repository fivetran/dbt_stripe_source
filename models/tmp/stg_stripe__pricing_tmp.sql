{{ config(enabled=var('stripe__using_subscriptions', True)) }}

select * 
from {% if var('stripe__price', true) %}
{{ var('price') }}
{% else %}
{{ var('plan') }}
{% endif %}

{{ livemode_predicate() }}