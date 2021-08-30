
with base as (

    select * 
    from {{ ref('stg_stripe__refund_tmp') }}

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
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__refund_tmp')),
                staging_columns=get_refund_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        id as refund_id,
        amount,
        balance_transaction_id,
        charge_id,
        created as created_at,
        currency,
        description,
        metadata,
        reason,
        receipt_number,
        status

        {% if var('stripe__refund_metadata',[]) %}
        , {{ fivetran_utils.pivot_json_extract(string = 'metadata', list_of_properties = var('stripe__refund_metadata')) }}
        {% endif %}

    from fields
)

select * 
from final
