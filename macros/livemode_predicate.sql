{% macro livemode_predicate() %}

    where livemode = {{ var('stripe__using_livemode', true) }}

{% endmacro %}
