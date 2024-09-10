{% macro get_card_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "account_id", "datatype": dbt.type_string()},
    {"name": "address_city", "datatype": dbt.type_string()},
    {"name": "address_country", "datatype": dbt.type_string()},
    {"name": "address_line_1", "datatype": dbt.type_string()},
    {"name": "address_line_1_check", "datatype": dbt.type_string()},
    {"name": "address_line_2", "datatype": dbt.type_string()},
    {"name": "address_state", "datatype": dbt.type_string()},
    {"name": "address_zip", "datatype": dbt.type_string()},
    {"name": "address_zip_check", "datatype": dbt.type_string()},
    {"name": "brand", "datatype": dbt.type_string()},
    {"name": "connected_account_id", "datatype": dbt.type_string()},
    {"name": "country", "datatype": dbt.type_string()},
    {"name": "created", "datatype": dbt.type_timestamp()},
    {"name": "currency", "datatype": dbt.type_string()},
    {"name": "customer_id", "datatype": dbt.type_string()},
    {"name": "cvc_check", "datatype": dbt.type_string()},
    {"name": "dynamic_last_4", "datatype": dbt.type_string()},
    {"name": "exp_month", "datatype": dbt.type_int()},
    {"name": "exp_year", "datatype": dbt.type_int()},
    {"name": "fingerprint", "datatype": dbt.type_string()},
    {"name": "funding", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_string()},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "last_4", "datatype": dbt.type_string()},
    {"name": "metadata", "datatype": dbt.type_string()},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "network", "datatype": dbt.type_string()},
    {"name": "recipient", "datatype": dbt.type_string()},
    {"name": "tokenization_method", "datatype": dbt.type_string()},
    {"name": "wallet_type", "datatype": dbt.type_string()},
] %}

{%- if var('stripe__card_using_description', false) %}
{{ columns.append({"name": "description", "datatype": dbt.type_string()}) }}
{%- endif %}

{%- if var('stripe__card_using_iin', false) %}
{{ columns.append({"name": "iin", "datatype": dbt.type_string()}) }}
{%- endif %}

{%- if var('stripe__card_using_issuer', false) %}
{{ columns.append({"name": "issuer", "datatype": dbt.type_string()}) }}
{%- endif %}

{{ return(columns) }}

{% endmacro %}
