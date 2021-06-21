{% macro get_payout_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "amount", "datatype": dbt_utils.type_int()},
    {"name": "arrival_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "automatic", "datatype": "boolean"},
    {"name": "balance_transaction_id", "datatype": dbt_utils.type_string()},
    {"name": "connected_account_id", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp()},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "destination_bank_account_id", "datatype": dbt_utils.type_string()},
    {"name": "destination_card_id", "datatype": dbt_utils.type_string()},
    {"name": "failure_balance_transaction_id", "datatype": dbt_utils.type_string()},
    {"name": "failure_code", "datatype": dbt_utils.type_string()},
    {"name": "failure_message", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "livemode", "datatype": "boolean"},
    {"name": "metadata", "datatype": dbt_utils.type_string()},
    {"name": "method", "datatype": dbt_utils.type_string()},
    {"name": "source_type", "datatype": dbt_utils.type_string()},
    {"name": "statement_descriptor", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
