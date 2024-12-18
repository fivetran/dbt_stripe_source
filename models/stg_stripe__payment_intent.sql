
with base as (

    select * 
    from {{ ref('stg_stripe__payment_intent_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__payment_intent_tmp')),
                staging_columns=get_payment_intent_columns()
            )
        }}

        {{ fivetran_utils.source_relation(
            union_schema_variable='stripe_union_schemas',
            union_database_variable='stripe_union_databases')
        }}
        
    from base
),

final as (
    
    select 
        id as payment_intent_id,
        amount/100.0 as amount,
        amount_capturable/100.0 as amount_capturable,
        amount_received/100.0 as amount_received,
        application,
        application_fee_amount/100.0 as application_fee_amount,
        cast(canceled_at as {{ dbt.type_timestamp() }}) as canceled_at,
        cancellation_reason,
        capture_method,
        confirmation_method,
        cast(created as {{ dbt.type_timestamp() }}) as created_at,
        currency,
        customer_id,
        description,
        metadata,
        payment_method_id,
        receipt_email,
        statement_descriptor,
        status,
        source_relation

        {% if var('stripe__payment_intent_metadata',[]) %}
        , {{ fivetran_utils.pivot_json_extract(string = 'metadata', list_of_properties = var('stripe__payment_intent_metadata')) }}
        {% endif %}

    from fields
    {{ livemode_predicate() }}
)

select * 
from final
