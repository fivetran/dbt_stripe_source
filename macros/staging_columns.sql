{% macro get_balance_transaction_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "amount", "datatype": dbt_utils.type_int()},
    {"name": "available_on", "datatype": dbt_utils.type_timestamp(), "alias": "available_at"},
    {"name": "connected_account_id", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp(), "alias": "created_at"},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "exchange_rate", "datatype": dbt_utils.type_float()},
    {"name": "fee", "datatype": dbt_utils.type_int()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "balance_transaction_id"},
    {"name": "net", "datatype": dbt_utils.type_int()},
    {"name": "payout_id", "datatype": dbt_utils.type_string()},
    {"name": "source", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

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
    {"name": "available_payout_methods", "datatype": dbt_utils.type_string()},
    {"name": "brand", "datatype": dbt_utils.type_string()},
    {"name": "connected_account_id", "datatype": dbt_utils.type_string()},
    {"name": "country", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp(), "alias": "created_at"},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "customer_id", "datatype": dbt_utils.type_string()},
    {"name": "cvc_check", "datatype": dbt_utils.type_string()},
    {"name": "dynamic_last_4", "datatype": dbt_utils.type_string()},
    {"name": "exp_month", "datatype": dbt_utils.type_int()},
    {"name": "exp_year", "datatype": dbt_utils.type_int()},
    {"name": "fingerprint", "datatype": dbt_utils.type_string()},
    {"name": "funding", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "card_id"},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "last_4", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "network", "datatype": dbt_utils.type_string()},
    {"name": "recipient", "datatype": dbt_utils.type_string()},
    {"name": "tokenization_method", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_charge_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "amount", "datatype": dbt_utils.type_int()},
    {"name": "amount_refunded", "datatype": dbt_utils.type_int()},
    {"name": "application", "datatype": dbt_utils.type_string()},
    {"name": "application_fee_amount", "datatype": dbt_utils.type_int()},
    {"name": "balance_transaction_id", "datatype": dbt_utils.type_string()},
    {"name": "bank_account_id", "datatype": dbt_utils.type_string()},
    {"name": "captured", "datatype": "boolean", "alias": "is_captured"},
    {"name": "card_id", "datatype": dbt_utils.type_string()},
    {"name": "connected_account_id", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp(), "alias": "created_at"},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "customer_id", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "destination", "datatype": dbt_utils.type_string()},
    {"name": "failure_code", "datatype": dbt_utils.type_string()},
    {"name": "failure_message", "datatype": dbt_utils.type_string()},
    {"name": "fraud_details_stripe_report", "datatype": dbt_utils.type_string()},
    {"name": "fraud_details_user_report", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "charge_id"},
    {"name": "invoice_id", "datatype": dbt_utils.type_string()},
    {"name": "livemode", "datatype": "boolean", "alias": "is_livemode"},
    {"name": "on_behalf_of", "datatype": dbt_utils.type_string()},
    {"name": "outcome_network_status", "datatype": dbt_utils.type_string()},
    {"name": "outcome_reason", "datatype": dbt_utils.type_string()},
    {"name": "outcome_risk_level", "datatype": dbt_utils.type_string()},
    {"name": "outcome_risk_score", "datatype": dbt_utils.type_int()},
    {"name": "outcome_seller_message", "datatype": dbt_utils.type_string()},
    {"name": "outcome_type", "datatype": dbt_utils.type_string()},
    {"name": "paid", "datatype": "boolean", "alias": "is_paid"},
    {"name": "payment_intent_id", "datatype": dbt_utils.type_string()},
    {"name": "receipt_email", "datatype": dbt_utils.type_string()},
    {"name": "receipt_number", "datatype": dbt_utils.type_string()},
    {"name": "receipt_url", "datatype": dbt_utils.type_string()},
    {"name": "refunded", "datatype": "boolean", "alias": "is_refunded"},
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
    {"name": "source_transfer", "datatype": dbt_utils.type_string()},
    {"name": "statement_descriptor", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "transfer_data_destination", "datatype": dbt_utils.type_string()},
    {"name": "transfer_group", "datatype": dbt_utils.type_string()},
    {"name": "transfer_id", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

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
    {"name": "created", "datatype": dbt_utils.type_timestamp(), "alias": "created_at"},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "default_card_id", "datatype": dbt_utils.type_string()},
    {"name": "delinquent", "datatype": "boolean", "alias": "is_delinquent"},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "email", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "customer_id"},
    {"name": "invoice_prefix", "datatype": dbt_utils.type_string()},
    {"name": "invoice_settings_default_payment_method", "datatype": dbt_utils.type_string()},
    {"name": "invoice_settings_footer", "datatype": dbt_utils.type_string()},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "livemode", "datatype": "boolean", "alias": "is_livemode"},
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

{% macro get_fee_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "amount", "datatype": dbt_utils.type_int()},
    {"name": "application", "datatype": dbt_utils.type_string()},
    {"name": "balance_transaction_id", "datatype": dbt_utils.type_string()},
    {"name": "connected_account_id", "datatype": dbt_utils.type_string()},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "index", "datatype": dbt_utils.type_int()},
    {"name": "type", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_invoice_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "amount_due", "datatype": dbt_utils.type_int()},
    {"name": "amount_paid", "datatype": dbt_utils.type_int()},
    {"name": "amount_remaining", "datatype": dbt_utils.type_int()},
    {"name": "application_fee_amount", "datatype": dbt_utils.type_int()},
    {"name": "attempt_count", "datatype": dbt_utils.type_int()},
    {"name": "attempted", "datatype": "boolean", "alias": "is_attempted"},
    {"name": "auto_advance", "datatype": "boolean", "alias": "is_auto_advance"},
    {"name": "billing", "datatype": dbt_utils.type_string()},
    {"name": "billing_reason", "datatype": dbt_utils.type_string()},
    {"name": "charge_id", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp(), "alias": "created_at"},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "customer_id", "datatype": dbt_utils.type_string()},
    {"name": "date", "datatype": dbt_utils.type_timestamp()},
    {"name": "default_source_id", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "due_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "ending_balance", "datatype": dbt_utils.type_int()},
    {"name": "finalized_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "footer", "datatype": dbt_utils.type_string()},
    {"name": "hosted_invoice_url", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "invoice_id"},
    {"name": "invoice_pdf", "datatype": dbt_utils.type_string()},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "livemode", "datatype": "boolean", "alias": "is_livemode"},
    {"name": "next_payment_attempt", "datatype": dbt_utils.type_timestamp()},
    {"name": "number", "datatype": dbt_utils.type_string()},
    {"name": "paid", "datatype": "boolean", "alias": "is_paid"},
    {"name": "period_end", "datatype": dbt_utils.type_timestamp()},
    {"name": "period_start", "datatype": dbt_utils.type_timestamp()},
    {"name": "receipt_number", "datatype": dbt_utils.type_string()},
    {"name": "starting_balance", "datatype": dbt_utils.type_int()},
    {"name": "statement_descriptor", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "subscription_proration_date", "datatype": dbt_utils.type_int()},
    {"name": "subtotal", "datatype": dbt_utils.type_int()},
    {"name": "tax", "datatype": dbt_utils.type_int()},
    {"name": "tax_percent", "datatype": dbt_utils.type_numeric()},
    {"name": "threshold_reason_amount_gte", "datatype": dbt_utils.type_int()},
    {"name": "total", "datatype": dbt_utils.type_int()},
    {"name": "webhooks_delivered_at", "datatype": dbt_utils.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_invoice_line_item_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "amount", "datatype": dbt_utils.type_int()},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "discountable", "datatype": "boolean", "alias": "is_discountable"},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "invoice_line_item_id"},
    {"name": "invoice_id", "datatype": dbt_utils.type_string()},
    {"name": "livemode", "datatype": "boolean", "alias": "is_livemode"},
    {"name": "period_end", "datatype": dbt_utils.type_timestamp(), "alias": "period_end_at"},
    {"name": "period_start", "datatype": dbt_utils.type_timestamp(), "alias": "period_start_at"},
    {"name": "plan_id", "datatype": dbt_utils.type_string()},
    {"name": "proration", "datatype": "boolean", "alias": "is_proration"},
    {"name": "quantity", "datatype": dbt_utils.type_int()},
    {"name": "subscription_id", "datatype": dbt_utils.type_string()},
    {"name": "subscription_item_id", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()},
    {"name": "unique_id", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

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
    {"name": "created", "datatype": dbt_utils.type_timestamp(), "alias": "created_at"},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "customer_id", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "payment_intent_id"},
    {"name": "last_payment_error_charge_id", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_code", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_decline_code", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_doc_url", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_message", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_param", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_source_id", "datatype": dbt_utils.type_string()},
    {"name": "last_payment_error_type", "datatype": dbt_utils.type_string()},
    {"name": "livemode", "datatype": "boolean", "alias": "is_livemode"},
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
    {"name": "created", "datatype": dbt_utils.type_timestamp(), "alias": "created_at"},
    {"name": "customer_id", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "payment_method_id"},
    {"name": "livemode", "datatype": "boolean", "alias": "is_livemode"},
    {"name": "type", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_payment_method_card_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "brand", "datatype": dbt_utils.type_string()},
    {"name": "charge_id", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "fingerprint", "datatype": dbt_utils.type_string()},
    {"name": "funding", "datatype": dbt_utils.type_string()},
    {"name": "payment_method_id", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()},
    {"name": "wallet_type", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_payout_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "amount", "datatype": dbt_utils.type_int()},
    {"name": "arrival_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "automatic", "datatype": "boolean", "alias": "is_automatic"},
    {"name": "balance_transaction_id", "datatype": dbt_utils.type_string()},
    {"name": "connected_account_id", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp(), "alias": "created_at"},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "destination_bank_account_id", "datatype": dbt_utils.type_string()},
    {"name": "destination_card_id", "datatype": dbt_utils.type_string()},
    {"name": "failure_balance_transaction_id", "datatype": dbt_utils.type_string()},
    {"name": "failure_code", "datatype": dbt_utils.type_string()},
    {"name": "failure_message", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "payout_id"},
    {"name": "livemode", "datatype": "boolean", "alias": "is_livemode"},
    {"name": "method", "datatype": dbt_utils.type_string()},
    {"name": "source_type", "datatype": dbt_utils.type_string()},
    {"name": "statement_descriptor", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_plan_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "active", "datatype": "boolean", "alias": "is_active"},
    {"name": "aggregate_usage", "datatype": dbt_utils.type_string()},
    {"name": "amount", "datatype": dbt_utils.type_int()},
    {"name": "billing_scheme", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp(), "alias": "created_at"},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "plan_id"},
    {"name": "'interval'", "datatype": dbt_utils.type_string(), "alias": "plan_interval"},
    {"name": "interval_count", "datatype": dbt_utils.type_int()},
    {"name": "is_deleted", "datatype": "boolean"},
    {"name": "livemode", "datatype": "boolean", "alias": "is_livemode"},
    {"name": "metadata_type", "datatype": dbt_utils.type_string()},
    {"name": "nickname", "datatype": dbt_utils.type_string()},
    {"name": "product_id", "datatype": dbt_utils.type_string()},
    {"name": "tiers_mode", "datatype": dbt_utils.type_string()},
    {"name": "transform_usage_divide_by", "datatype": dbt_utils.type_int()},
    {"name": "transform_usage_round", "datatype": dbt_utils.type_string()},
    {"name": "trial_period_days", "datatype": dbt_utils.type_int()},
    {"name": "usage_type", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_refund_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "amount", "datatype": dbt_utils.type_int()},
    {"name": "balance_transaction_id", "datatype": dbt_utils.type_string()},
    {"name": "charge_id", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp(), "alias": "created_at"},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "description", "datatype": dbt_utils.type_string()},
    {"name": "failure_balance_transaction_id", "datatype": dbt_utils.type_string()},
    {"name": "failure_reason", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "refund_id"},
    {"name": "reason", "datatype": dbt_utils.type_string()},
    {"name": "receipt_number", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_subscription_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "application_fee_percent", "datatype": dbt_utils.type_float()},
    {"name": "billing", "datatype": dbt_utils.type_string()},
    {"name": "billing_cycle_anchor", "datatype": dbt_utils.type_timestamp(), "alias": "billing_cycle_anchor_at"},
    {"name": "billing_threshold_amount_gte", "datatype": dbt_utils.type_int()},
    {"name": "billing_threshold_reset_billing_cycle_anchor", "datatype": "boolean", "alias": "is_billing_threshold_reset_billing_cycle_anchor"},
    {"name": "billing_threshold_usage_gte", "datatype": dbt_utils.type_int()},
    {"name": "cancel_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "cancel_at_period_end", "datatype": "boolean", "alias": "is_cancel_at_period_end"},
    {"name": "canceled_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "created", "datatype": dbt_utils.type_timestamp(), "alias": "created_at"},
    {"name": "current_period_end", "datatype": dbt_utils.type_timestamp(), "alias": "current_period_end_at"},
    {"name": "current_period_start", "datatype": dbt_utils.type_timestamp(), "alias": "current_period_start_at"},
    {"name": "customer_id", "datatype": dbt_utils.type_string()},
    {"name": "days_until_due", "datatype": dbt_utils.type_int()},
    {"name": "default_source_id", "datatype": dbt_utils.type_string()},
    {"name": "ended_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "subscription_id"},
    {"name": "livemode", "datatype": "boolean", "alias": "is_livemode"},
    {"name": "metadata_lease_end_date", "datatype": dbt_utils.type_string()},
    {"name": "metadata_origin", "datatype": dbt_utils.type_string()},
    {"name": "quantity", "datatype": dbt_utils.type_int()},
    {"name": "'start'", "datatype": dbt_utils.type_timestamp(), "alias": "start_at"},
    {"name": "start_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "tax_percent", "datatype": dbt_utils.type_float()},
    {"name": "trial_end", "datatype": dbt_utils.type_timestamp(), "alias": "trial_end_at"},
    {"name": "trial_start", "datatype": dbt_utils.type_timestamp(), "alias": "trial_start_at"}
] %}

{{ return(columns) }}

{% endmacro %}
