with source as (

    select *
    from {{ ref('stg_stripe__payment_intent_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__payment_intent_tmp')),
                staging_columns=get_payment_intent_columns()
            )
        }}

    from source

)

select * from renamed