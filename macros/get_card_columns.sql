{% macro get_card_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "address_city", "datatype": dbt_utils.type_string()},
    {"name": "address_country", "datatype": dbt_utils.type_string()},
    {"name": "address_line_1", "datatype": dbt_utils.type_string()},
    {"name": "address_line_1_check", "datatype": dbt_utils.type_string()},
    {"name": "address_line_2", "datatype": dbt_utils.type_string()},
    {"name": "address_state", "datatype": dbt_utils.type_string()},
    {"name": "address_zip", "datatype": dbt_utils.type_string()},
    {"name": "address_zip_check", "datatype": dbt_utils.type_string()},
    {"name": "brand", "datatype": dbt_utils.type_string()},
    {"name": "connected_account_id", "datatype": dbt_utils.type_string()},
    {"name": "country", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp()},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "customer_id", "datatype": dbt_utils.type_string()},
    {"name": "cvc_check", "datatype": dbt_utils.type_string()},
    {"name": "dynamic_last_4", "datatype": dbt_utils.type_string()},
    {"name": "exp_month", "datatype": dbt_utils.type_int()},
    {"name": "exp_year", "datatype": dbt_utils.type_int()},
    {"name": "fingerprint", "datatype": dbt_utils.type_string()},
    {"name": "funding", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "last_4", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "network", "datatype": dbt_utils.type_string()},
    {"name": "recipient", "datatype": dbt_utils.type_string()},
    {"name": "tokenization_method", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
