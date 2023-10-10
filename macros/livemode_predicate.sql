{% macro livemode_predicate() %}

    where cast(livemode as boolean) = {{ var('stripe__using_livemode', true) }}

{% endmacro %}
