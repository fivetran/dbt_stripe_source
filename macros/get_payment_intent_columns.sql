{% macro get_payment_intent_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "amount", "datatype": dbt_utils.type_int()},
    {"name": "amount_capturable", "datatype": dbt_utils.type_int()},
    {"name": "amount_received", "datatype": dbt_utils.type_int()},
    {"name": "application", "datatype": dbt_utils.type_string()},
    {"name": "application_fee_amount", "datatype": dbt_utils.type_int()},
    {"name": "canceled_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "cancellation_reason", "datatype": dbt_utils.type_string()},
    {"name": "capture_method", "datatype": dbt_utils.type_string()},
    {"name": "confirmation_method", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp()},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "customer_id", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_charge_id", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_code", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_decline_code", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_doc_url", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_message", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_param", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_source_id", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_type", "datatype": dbt_utils.type_string()},
    {"name": "livemode", "datatype": "boolean"},
    {"name": "metadata", "datatype": dbt_utils.type_string()},
    {"name": "on_behalf_of", "datatype": dbt_utils.type_string()},
    {"name": "payment_method_id", "datatype": dbt_utils.type_string()},
    {"name": "receipt_email", "datatype": dbt_utils.type_string()},
    {"name": "source_id", "datatype": dbt_utils.type_string()},
    {"name": "statement_descriptor", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "transfer_data_destination", "datatype": dbt_utils.type_string()},
    {"name": "transfer_group", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
