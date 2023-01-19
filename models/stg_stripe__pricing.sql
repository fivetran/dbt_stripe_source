{{ config(enabled=var('stripe__using_subscriptions', True)) }}

{% if var('stripe__using_price', does_table_exist('price')) %}
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
        id as price_id,
        {{ dbt_utils.generate_surrogate_key(['id','source_relation']) }} as surrogate_key,
        active as is_active,
        unit_amount,
        currency,
        recurring_interval,
        recurring_interval_count,
        recurring_usage_type,
        recurring_aggregate_usage,
        metadata,
        nickname,
        product_id,
        billing_scheme,
        created,
        invoice_item_id,
        is_deleted,
        lookup_key,
        tiers_mode,
        transform_quantity_divide_by,
        transform_quantity_round,
        type as pricing_type,
        source_relation

        {% if var('stripe__price_metadata',[]) %}
        , {{ fivetran_utils.pivot_json_extract(string = 'metadata', list_of_properties = var('stripe__price_metadata')) }}
        {% endif %}
        
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
        {{ dbt_utils.generate_surrogate_key(['id','source_relation']) }} as surrogate_key,
        active as is_active,
        amount as unit_amount,
        currency,
        recurring_interval, -- Field is aliased within get_plan_columns macro
        interval_count as recurring_interval_count,
        usage_type as recurring_usage_type,
        aggregate_usage as recurring_aggregate_usage,
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



