{{ config(enabled=var('using_subscriptions', True)) }}

with base as (

    select * 
    from {{ ref('stg_stripe__plan_tmp') }}

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
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__plan_tmp')),
                staging_columns=get_plan_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        id as plan_id,
        active as is_active,
        amount,
        currency,
        {% if target.type == 'bigquery' %}
            `interval` as plan_interval,
        {% else %}
            interval as plan_interval,
        {% endif %}
        interval_count,
        metadata,
        nickname,
        product_id

        {% if var('stripe__plan_metadata',[]) %}
        , {{ fivetran_utils.pivot_json_extract(string = 'metadata', list_of_properties = var('stripe__plan_metadata')) }}
        {% endif %}

    from fields
)

select * 
from final
