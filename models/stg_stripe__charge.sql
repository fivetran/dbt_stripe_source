
with base as (

    select * 
    from {{ ref('stg_stripe__charge_tmp') }}

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
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__charge_tmp')),
                staging_columns=get_charge_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        id as charge_id, 
        amount,
        amount_refunded,
        application_fee_amount,
        balance_transaction_id,
        captured as is_captured,
        card_id,
        created as created_at,
        customer_id,
        currency,
        description,
        failure_code,
        failure_message,
        metadata,
        paid as is_paid,
        payment_intent_id,
        receipt_email,
        receipt_number,
        refunded as is_refunded,
        status,
        invoice_id

        {% if var('stripe__charge_metadata',[]) %}
        , {{ fivetran_utils.pivot_json_extract(string = 'metadata', list_of_properties = var('stripe__charge_metadata')) }}
        {% endif %}

    from fields
)

select * 
from final
