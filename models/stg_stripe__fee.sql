
with base as (

    select * 
    from {{ ref('stg_stripe__fee_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__fee_tmp')),
                staging_columns=get_fee_columns()
            )
        }}
    from base
),

final as (
    
    select 
        balance_transaction_id,
        amount,
        application,
        currency,
        description,
        type
    from fields
)

select * 
from final
