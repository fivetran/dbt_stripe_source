{% macro get_payment_method_card_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "brand", "datatype": dbt.type_string()},
    {"name": "charge_id", "datatype": dbt.type_string()},
    {"name": "funding", "datatype": dbt.type_string()},
    {"name": "payment_method_id", "datatype": dbt.type_string()},
    {"name": "type", "datatype": dbt.type_string()},
    {"name": "wallet_type", "datatype": dbt.type_string()}
    {"name": "authentication_flow", "datatype": dbt.type_string()},
    {"name": "result", "datatype": dbt.type_string()},
    {"name": "result_reason", "datatype": dbt.type_string()},
    {"name": "version", "datatype": dbt.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
