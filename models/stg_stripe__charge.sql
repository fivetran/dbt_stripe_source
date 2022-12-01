
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
        cast (created as {{ dbt_utils.type_timestamp() }})  as created_at,
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
        source_relation

        {% if var('stripe__charge_metadata',[]) %}
        , {{ fivetran_utils.pivot_json_extract(string = 'metadata', list_of_properties = var('stripe__charge_metadata')) }}
        {% endif %}

    from fields
)

select * 
from final
