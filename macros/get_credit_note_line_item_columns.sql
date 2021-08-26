{% macro get_credit_note_line_item_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "credit_note_id", "datatype": dbt_utils.type_string()},
    {"name": "amount", "datatype": dbt_utils.type_int()},
    {"name": "discount_amount", "datatype": dbt_utils.type_int()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "livemode", "datatype": "boolean"},
    {"name": "quantity", "datatype": dbt_utils.type_int()},
    {"name": "type", "datatype": dbt_utils.type_string()},
    {"name": "unit_amount", "datatype": dbt_utils.type_int()},
    {"name": "unit_amount_decimal", "datatype": dbt_utils.type_int()},
] %}

{{ return(columns) }}

{% endmacro %}
