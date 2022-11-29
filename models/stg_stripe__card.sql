
with base as (

    select * 
    from {{ ref('stg_stripe__card_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__card_tmp')),
                staging_columns=get_card_columns()
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
        id as card_id,
        wallet_type,
        brand,
        country,
        created as created_at,
        customer_id,
        name,
        recipient,
        funding

        {{ fivetran_utils.source_relation() }}

    from fields
)

select * 
from final
