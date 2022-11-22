{{ config(enabled=var('using_invoices', True)) }}

with base as (

    select * 
    from {{ ref('stg_stripe__invoice_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__invoice_tmp')),
                staging_columns=get_invoice_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as invoice_id,
        default_payment_method_id,
        payment_intent_id,
        subscription_id,
        amount_due,
        amount_paid,
        amount_remaining,
        post_payment_credit_notes_amount,
        pre_payment_credit_notes_amount,
        attempt_count,
        auto_advance,
        billing_reason,
        charge_id,
        created as created_at,
        currency,
        customer_id,
        description,
        due_date,
        metadata,
        number,
        paid as is_paid,
        receipt_number,
        status,
        subtotal,
        tax,
        tax_percent,
        total,
        subscription_id,
        period_start,
        period_end,
        status_transitions_*,

        {% if var('stripe__invoice_metadata',[]) %}
        , {{ fivetran_utils.pivot_json_extract(string = 'metadata', list_of_properties = var('stripe__invoice_metadata')) }}
        {% endif %}

    from fields
    where not coalesce(is_deleted, false)
)

select * 
from final
