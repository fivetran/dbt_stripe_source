
with base as (

    select * 
    from {{ ref('stg_stripe__transfer_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__transfer_tmp')),
                staging_columns=get_transfer_columns()
            )
        }}
    from base
),

final as (
    
    select 
[0m16:26:05          _fivetran_synced,
        amount,
        amount_reversed,
        balance_transaction_id,
        created,
        currency,
        description,
        destination,
        destination_payment,
        destination_payment_id,
        id,
        livemode,
        metadata,
        reversed,
        source_transaction,
        source_transaction_id,
        source_type,
        transfer_group
    from fields
)

select *
from final
