{% macro get_discount_columns() %}

{% set columns = [
    {"name": "id", "datatype": dbt.type_string() },
    {"name": "type", "datatype": dbt.type_string() },
    {"name": "type_id", "datatype": dbt.type_string() },
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp() },
    {"name": "amount", "datatype": dbt.type_int() },
    {"name": "checkout_session_id", "datatype": dbt.type_string() },
    {"name": "checkout_session_line_item_id", "datatype": dbt.type_string() },
    {"name": "coupon_id", "datatype": dbt.type_string() },
    {"name": "credit_note_line_item_id", "datatype": dbt.type_string() },
    {"name": "customer_id", "datatype": dbt.type_string() },
    {"name": "end", "datatype": dbt.type_timestamp(), "alias": "end_at" },
    {"name": "invoice_id", "datatype": dbt.type_string() },
    {"name": "invoice_item_id", "datatype": dbt.type_string() },
    {"name": "promotion_code", "datatype": dbt.type_string() },
    {"name": "start", "datatype": dbt.type_timestamp(), "alias": "start_at" },
    {"name": "subscription_id", "datatype": dbt.type_string() }
] %}

{{ return(columns) }}

{% endmacro %}