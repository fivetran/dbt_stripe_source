{% macro livemode_predicate() %}

    where livemode = {{ var('using_livemode', true) }}

{% endmacro %}
