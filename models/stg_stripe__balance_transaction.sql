
with base as (

    select * 
    from {{ ref('stg_stripe__balance_transaction_tmp') }}

),

fields as (

    select
        /*
        The below macro is used to generate the correct SQL for package staging models. It takes a list of columns 
        that are expected/needed (staging_columns from dbt_stripe_source/models/tmp/) and compares it with columns 
        in the source (source_columns from dbt_stripe_source/macros/).
        For more information refer to our dbt_fivetran_utils documentation (https://github.com/fivetran/dbt_fivetran_utils.git).
        */
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

        -- ensure that these are timestamps without timezones on postgres + redshift
        cast(available_on as {{ dbt_utils.type_timestamp() }}) as available_on,
        cast(created as {{ dbt_utils.type_timestamp() }}) as created_at,

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
