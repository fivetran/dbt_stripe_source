{{ config(enabled=var('stripe__using_payment_method', True)) }}

with base as (

    select * 
    from {{ ref('stg_stripe__payment_method_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__payment_method_tmp')),
                staging_columns=get_payment_method_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        id as payment_method_id,
        created as created_at,
        customer_id,
        metadata,
        type

        {% if var('stripe__payment_method_metadata',[]) %}
        , {{ fivetran_utils.pivot_json_extract(string = 'metadata', list_of_properties = var('stripe__payment_method_metadata')) }}
        {% endif %}

    from fields
)

select * 
from final
