{{ config(enabled=var('using_invoices', True)) }}

with source as (

    select *
    from {{ ref('stg_stripe__invoice_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__invoice_tmp')),
                staging_columns=get_invoice_columns()
            )
        }}

    from source

)

select * from renamed
where not coalesce(is_deleted, false)
