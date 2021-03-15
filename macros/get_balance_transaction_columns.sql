{% macro get_balance_transaction_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "amount", "datatype": dbt_utils.type_int()},
    {"name": "available_on", "datatype": dbt_utils.type_timestamp()},
    {"name": "connected_account_id", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp()},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "exchange_rate", "datatype": dbt_utils.type_float()},
    {"name": "fee", "datatype": dbt_utils.type_int()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "net", "datatype": dbt_utils.type_int()},
    {"name": "payout_id", "datatype": dbt_utils.type_string()},
    {"name": "source", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
