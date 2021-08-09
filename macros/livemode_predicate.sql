{% macro livemode_predicate() %}

where 
{% if var('test_data_only', false) %} not {% endif %}
    coalesce(livemode, true) 

{% endmacro %}
