
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

        {{ fivetran_utils.source_relation(
            union_schema_variable='stripe_union_schemas', 
            union_database_variable='stripe_union_databases') 
        }}

    from base
),

final as (
    
    select
        id as transfer_id,
        amount as transfer_amount,
        amount_reversed as transfer_amount_reversed,
        balance_transaction_id,
        created as created_at,
        currency as transfer_currency,
        description as transfer_description,
        destination as transfer_destination,
        destination_payment,
        destination_payment_id,
        livemode,
        metadata as transfer_metadata,
        reversed as transfer_reversed,
        source_transaction,
        source_transaction_id,
        source_type,
        transfer_group,
        source_relation

    from fields
    -- remember to add livemode predicate
)

select *
from final