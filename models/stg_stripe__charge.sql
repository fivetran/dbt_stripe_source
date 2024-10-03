
with base as (

    select * 
    from {{ ref('stg_stripe__charge_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__charge_tmp')),
                staging_columns=get_charge_columns()
            )
        }}

        {{ fivetran_utils.source_relation(
            union_schema_variable='stripe_union_schemas', 
            union_database_variable='stripe_union_databases') 
        }}

    from base
),

final as (

    select 
        id as charge_id, 
        amount,
        amount_refunded,
        application_fee_amount,
        balance_transaction_id,
        captured as is_captured,
        card_id,
        cast(created as {{ dbt.type_timestamp() }}) as created_at,
        connected_account_id,
        customer_id,
        currency,
        description,
        failure_code,
        failure_message,
        metadata,
        paid as is_paid,
        payment_intent_id,
        payment_method_id,
        receipt_email,
        receipt_number,
        refunded as is_refunded,
        status,
        shipping_address_city,
        shipping_address_country,
        shipping_address_line_1,
        shipping_address_line_2,
        shipping_address_postal_code,
        shipping_address_state,
        shipping_carrier,
        shipping_name,
        shipping_phone,
        shipping_tracking_number,
        source_id,
        source_transfer,
        statement_descriptor,
        invoice_id,
        calculated_statement_descriptor,
        billing_detail_address_city,
        billing_detail_address_country,
        billing_detail_address_line1,
        billing_detail_address_line2,
        billing_detail_address_postal_code,
        billing_detail_address_state,
        billing_detail_email,
        billing_detail_name,
        billing_detail_phone,
        application,
        bank_account_id,
        destination,
        fraud_details_stripe_report,
        fraud_details_user_report,
        livemode,
        on_behalf_of,
        outcome_network_status,
        outcome_reason,
        outcome_risk_level,
        outcome_risk_score,
        outcome_seller_message,
        outcome_type,
        receipt_url,
        rule_rule,
        transfer_data_destination,
        transfer_group,
        transfer_id,
        source_relation

        {% if var('stripe__charge_metadata',[]) %}
        , {{ fivetran_utils.pivot_json_extract(string = 'metadata', list_of_properties = var('stripe__charge_metadata')) }}
        {% endif %}

    from fields
    {{ livemode_predicate() }}
)

select * 
from final
