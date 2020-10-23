{{ config(enabled=var('using_invoices', True)) }}

with source as (

    select *
    from {{ ref('stg_stripe__invoice_line_item_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__invoice_line_item_tmp')),
                staging_columns=get_invoice_line_item_columns()
            )
        }}

    from source

)

select * from renamed
where invoice_line_item_id not like 'sub%' -- ids starting with 'sub' are temporary and are replaced by permanent ids starting with 'sli' 
