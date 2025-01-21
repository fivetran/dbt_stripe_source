{% macro convert_values(field_name, divide_by=100.0, divide_var=var('stripe__convert_values',false), alias=None) %}

{{ adapter.dispatch('convert_values', 'stripe_source')(field_name=field_name, divide_by=divide_by, divide_var=divide_var, alias=alias ) }}

{%- endmacro %}

{% macro default__convert_values(field_name, divide_by=100.0, divide_var=var('stripe__convert_values',false), alias=None) %}

    {% if divide_var %}
        {{ field_name }} / {{ divide_by }} as {{ alias if alias else field_name }}
    {% else %}
        {{ field_name }} as {{ alias if alias else field_name }}
    {% endif %}

{% endmacro %}
