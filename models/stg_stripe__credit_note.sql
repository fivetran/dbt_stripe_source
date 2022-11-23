{{ config(enabled=var('stripe__using_credit_notes', False)) }}

with base as (

    select * 
    from {{ ref('stg_stripe__credit_note_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__credit_note_tmp')),
                staging_columns=get_credit_note_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as credit_note_id,
        amount,
        created as created_at,
        currency,
        discount_amount,
        subtotal,
        total,
        memo,
        metadata,
        number,
        pdf,
        reason,
        status,
        type,
        voided_at,
        customer_balance_transaction,
        invoice_id,
        refund_id
    from fields
)

select * 
from final
