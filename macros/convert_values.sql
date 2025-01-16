{% macro convert_values(field_name, divide_by=100.0, divide_var=var('stripe__convert_values',false), alias=None) %}
    {% if divide_var %}
        {{ field_name }} / {{ divide_by }} as {{ alias if alias else field_name }}
    {% else %}
        {{ field_name }} as {{ alias if alias else field_name }}
    {% endif %}
{% endmacro %}
