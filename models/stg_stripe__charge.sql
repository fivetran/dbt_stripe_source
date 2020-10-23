with source as (

    select *
    from {{ ref('stg_stripe__charge_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__charge_tmp')),
                staging_columns=get_charge_columns()
            )
        }}

    from source

)

select * from renamed