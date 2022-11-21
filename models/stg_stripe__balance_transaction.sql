
with base as (

    select * 
    from {{ ref('stg_stripe__balance_transaction_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__balance_transaction_tmp')),
                staging_columns=get_balance_transaction_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as balance_transaction_id,
        amount,
        cast(available_on as {{ dbt.type_timestamp() }}) as available_on,
        cast(created as {{ dbt.type_timestamp() }}) as created_at,
        currency,
        description,
        exchange_rate,
        fee,
        net,
        source,
        status,
        type
    from fields
)

select * 
from final
