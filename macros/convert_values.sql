{% macro convert_values(field_name, divide_by=100.0, divide_var='stripe__convert_values', alias=None) %}
    {% if var(divide_var, True) %}
        {{ field_name }} / {{ divide_by }} as {{ alias if alias else field_name }}
    {% else %}
        {{ field_name }} as {{ alias if alias else field_name }}
    {% endif %}
{% endmacro %}
