{{ config(enabled=var('using_payment_method', True)) }}

with source as (

    select *
    from {{ ref('stg_stripe__payment_method_card_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__payment_method_card_tmp')),
                staging_columns=get_payment_method_card_columns()
            )
        }}

    from source

)

select * from renamed