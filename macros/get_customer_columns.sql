{% macro get_customer_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_balance", "datatype": dbt_utils.type_int()},
    {"name": "address_city", "datatype": dbt_utils.type_string()},
    {"name": "address_country", "datatype": dbt_utils.type_string()},
    {"name": "address_line_1", "datatype": dbt_utils.type_string()},
    {"name": "address_line_2", "datatype": dbt_utils.type_string()},
    {"name": "address_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "address_state", "datatype": dbt_utils.type_string()},
    {"name": "balance", "datatype": dbt_utils.type_int()},
    {"name": "bank_account_id", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp()},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "default_card_id", "datatype": dbt_utils.type_string()},
    {"name": "delinquent", "datatype": "boolean"},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "email", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "invoice_prefix", "datatype": dbt_utils.type_string()},
    {"name": "invoice_settings_default_payment_method", "datatype": dbt_utils.type_string()},
    {"name": "invoice_settings_footer", "datatype": dbt_utils.type_string()},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "livemode", "datatype": "boolean"},
    {"name": "metadata", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "phone", "datatype": dbt_utils.type_string()},
    {"name": "shipping_address_city", "datatype": dbt_utils.type_string()},
    {"name": "shipping_address_country", "datatype": dbt_utils.type_string()},
    {"name": "shipping_address_line_1", "datatype": dbt_utils.type_string()},
    {"name": "shipping_address_line_2", "datatype": dbt_utils.type_string()},
    {"name": "shipping_address_postal_code", "datatype": dbt_utils.type_string()},
    {"name": "shipping_address_state", "datatype": dbt_utils.type_string()},
    {"name": "shipping_carrier", "datatype": dbt_utils.type_string()},
    {"name": "shipping_name", "datatype": dbt_utils.type_string()},
    {"name": "shipping_phone", "datatype": dbt_utils.type_string()},
    {"name": "shipping_tracking_number", "datatype": dbt_utils.type_string()},
    {"name": "source_id", "datatype": dbt_utils.type_string()},
    {"name": "tax_exempt", "datatype": dbt_utils.type_string()},
    {"name": "tax_info_tax_id", "datatype": dbt_utils.type_string()},
    {"name": "tax_info_type", "datatype": dbt_utils.type_string()},
    {"name": "tax_info_verification_status", "datatype": dbt_utils.type_string()},
    {"name": "tax_info_verification_verified_name", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
