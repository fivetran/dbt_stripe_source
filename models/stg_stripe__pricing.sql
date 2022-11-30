{{ config(enabled=var('stripe__using_subscriptions', True)) }}

{% if var('stripe__price', does_table_exist('price')) %}
with pricing as (

    select * 
    from {{ ref('stg_stripe__pricing_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__pricing_tmp')),
                staging_columns=get_pricing_columns()
            )
        }}

        {{ fivetran_utils.source_relation(
            union_schema_variable='stripe_union_schemas', 
            union_database_variable='stripe_union_databases') 
        }}

    from pricing
),

final as (

    select 
        _fivetran_synced,
        active,
        billing_scheme,
        created,
        currency,
        id,
        invoice_item_id,
        is_deleted,
        livemode,
        lookup_key,
        metadata,
        nickname,
        product_id,
        recurring_aggregate_usage,
        recurring_interval,
        recurring_interval_count,
        recurring_usage_type,
        tiers_mode,
        transform_quantity_divide_by,
        transform_quantity_round,
        type,
        unit_amount,
        unit_amount_decimal,
        source_relation
        
    from fields
)

select * 
from final

{% else %}

with plan as (

    select * 
    from {{ ref('stg_stripe__pricing_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__pricing_tmp')),
                staging_columns=get_pricing_columns()
            )
        }}

        {{ fivetran_utils.source_relation(
            union_schema_variable='stripe_union_schemas', 
            union_database_variable='stripe_union_databases') 
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
        product_id,
        source_relation

        {% if var('stripe__plan_metadata',[]) %}
        , {{ fivetran_utils.pivot_json_extract(string = 'metadata', list_of_properties = var('stripe__plan_metadata')) }}
        {% endif %}

    from fields
)

select * 
from final

{% endif %}



