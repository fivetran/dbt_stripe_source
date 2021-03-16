{% macro get_invoice_line_item_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "amount", "datatype": dbt_utils.type_int()},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "discountable", "datatype": "boolean"},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "invoice_id", "datatype": dbt_utils.type_string()},
    {"name": "livemode", "datatype": "boolean"},
    {"name": "period_end", "datatype": dbt_utils.type_timestamp()},
    {"name": "period_start", "datatype": dbt_utils.type_timestamp()},
    {"name": "plan_id", "datatype": dbt_utils.type_string()},
    {"name": "proration", "datatype": "boolean"},
    {"name": "quantity", "datatype": dbt_utils.type_int()},
    {"name": "subscription_id", "datatype": dbt_utils.type_string()},
    {"name": "subscription_item_id", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()},
    {"name": "unique_id", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
