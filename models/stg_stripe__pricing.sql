{{ config(enabled=var('stripe__using_subscriptions', True)) }}

{% if var('stripe__price', does_table_exist('price')) %}
with pricing as (

    select * 
    from {{ var('price') }}

),

fields as (




)

final as (


)

select * 
from fields


{% else %}

with plan as (

    select * 
    from {{ var('plan') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__plan_tmp')),
                staging_columns=get_plan_columns()
            )
        }}
    from plan
),

final as (

    select 
        id as plan_id,
        active as is_active,
        amount,
        currency,
        plan_interval, -- Field is aliased within get_plan_columns macro
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

{% endif %}
