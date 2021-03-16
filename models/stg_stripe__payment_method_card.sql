{{ config(enabled=var('using_payment_method', True)) }}

with base as (

    select * 
    from {{ ref('stg_stripe__payment_method_card_tmp') }}

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
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__payment_method_card_tmp')),
                staging_columns=get_payment_method_card_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        payment_method_id,
        brand,
        funding
    from fields
)

select * 
from final
