
with base as (

    select * 
    from {{ ref('stg_stripe__payout_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__payout_tmp')),
                staging_columns=get_payout_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as payout_id,
        amount,
        arrival_date,
        automatic as is_automatic,
        balance_transaction_id,
        created as created_at,
        currency,
        description,
        metadata,
        method,
        source_type,
        status,
        type

        {% if var('stripe__payout_metadata',[]) %}
        , {{ fivetran_utils.pivot_json_extract(string = 'metadata', list_of_properties = var('stripe__payout_metadata')) }}
        {% endif %}

    from fields
)

select * 
from final
