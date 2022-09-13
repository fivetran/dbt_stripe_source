{{ config(enabled=var('using_subscriptions', True)) }}

with base as (

    select * 
    from {{ ref('stg_stripe__subscription_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__subscription_tmp')),
                staging_columns=get_subscription_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as subscription_id,
        status,
        billing,
        billing_cycle_anchor,
        cancel_at,
        cancel_at_period_end as is_cancel_at_period_end,
        canceled_at,
        created as created_at,
        current_period_start,
        current_period_end,
        customer_id,
        days_until_due,
        metadata,
        start_date,
        ended_at

        {% if var('stripe__subscription_metadata',[]) %}
        , {{ fivetran_utils.pivot_json_extract(string = 'metadata', list_of_properties = var('stripe__subscription_metadata')) }}
        {% endif %}

    from fields
)

select * 
from final
