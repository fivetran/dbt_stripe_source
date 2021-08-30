{{ config(enabled=var('using_invoices', True)) }}

with base as (

    select * 
    from {{ ref('stg_stripe__invoice_tmp') }}

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
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__invoice_tmp')),
                staging_columns=get_invoice_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        id as invoice_id,
        amount_due,
        amount_paid,
        amount_remaining,
        attempt_count,
        auto_advance,
        billing_reason,
        charge_id,
        created as created_at,
        currency,
        customer_id,
        description,
        due_date,
        metadata,
        number,
        paid as is_paid,
        receipt_number,
        status,
        subtotal,
        tax,
        tax_percent,
        total

        {% if var('stripe__invoice_metadata',[]) %}
        , {{ fivetran_utils.pivot_json_extract(string = 'metadata', list_of_properties = var('stripe__invoice_metadata')) }}
        {% endif %}

    from fields
    where not coalesce(is_deleted, false)
)

select * 
from final
