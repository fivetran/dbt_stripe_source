{% macro get_payment_method_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "billing_detail_address_city", "datatype": dbt_utils.type_string()},
    {"name": "billing_detail_address_country", "datatype": dbt_utils.type_string()},
    {"name": "billing_detail_address_line_1", "datatype": dbt_utils.type_string()},
    {"name": "billing_detail_address_line_2", "datatype": dbt_utils.type_string()},
    {"name": "billing_detail_address_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "billing_detail_address_state", "datatype": dbt_utils.type_string()},
    {"name": "billing_detail_email", "datatype": dbt_utils.type_string()},
    {"name": "billing_detail_name", "datatype": dbt_utils.type_string()},
    {"name": "billing_detail_phone", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp()},
    {"name": "customer_id", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "livemode", "datatype": "boolean"},
    {"name": "metadata", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
