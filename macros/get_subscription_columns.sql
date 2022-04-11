{% macro get_subscription_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "_fivetran_active", "datatype": "boolean"},
    {"name": "application_fee_percent", "datatype": dbt_utils.type_float()},
    {"name": "billing", "datatype": dbt_utils.type_string()},
    {"name": "billing_cycle_anchor", "datatype": dbt_utils.type_timestamp()},
    {"name": "billing_threshold_amount_gte", "datatype": dbt_utils.type_int()},
    {"name": "billing_threshold_reset_billing_cycle_anchor", "datatype": "boolean"},
    {"name": "cancel_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "cancel_at_period_end", "datatype": "boolean"},
    {"name": "canceled_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "created", "datatype": dbt_utils.type_timestamp()},
    {"name": "current_period_end", "datatype": dbt_utils.type_timestamp()},
    {"name": "current_period_start", "datatype": dbt_utils.type_timestamp()},
    {"name": "customer_id", "datatype": dbt_utils.type_string()},
    {"name": "days_until_due", "datatype": dbt_utils.type_int()},
    {"name": "default_source_id", "datatype": dbt_utils.type_string()},
    {"name": "ended_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "livemode", "datatype": "boolean"},
    {"name": "metadata", "datatype": dbt_utils.type_string()},
    {"name": "quantity", "datatype": dbt_utils.type_int()},
    {"name": "start_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "tax_percent", "datatype": dbt_utils.type_float()},
    {"name": "trial_end", "datatype": dbt_utils.type_timestamp()},
    {"name": "trial_start", "datatype": dbt_utils.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}
