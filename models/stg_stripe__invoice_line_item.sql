{{ config(enabled=var('using_invoices', True)) }}

with base as (

    select * 
    from {{ ref('stg_stripe__invoice_line_item_tmp') }}

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
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__invoice_line_item_tmp')),
                staging_columns=get_invoice_line_item_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        id as invoice_line_item_id,
        invoice_id,
        amount,
        currency,
        description,
        discountable as is_discountable,
        plan_id,
        proration,
        quantity,
        subscription_id,
        subscription_item_id,
        type,
        unique_id,
        period_start,
        period_end
    from fields

    {% if var('using_invoice_line_sub_filter', true) %}
    where id not like 'sub%' -- ids starting with 'sub' are temporary and are replaced by permanent ids starting with 'sli' 
    {% endif %}
)

select * 
from final
