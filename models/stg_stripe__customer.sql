
with base as (

    select * 
    from {{ ref('stg_stripe__customer_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__customer_tmp')),
                staging_columns=get_customer_columns()
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
        id as customer_id,
        account_balance,
        address_city as customer_address_city,
        address_country as customer_address_country,
        address_line_1 as customer_address_line_1,
        address_line_2 as customer_address_line_2,
        address_postal_code as customer_address_postal_code,
        address_state as customer_address_state,
        balance as customer_balance,
        bank_account_id,
        cast(created as {{ dbt.type_timestamp() }}) as created_at,
        currency,
        default_card_id,
        delinquent as is_delinquent,
        description,
        email,
        metadata,
        name as customer_name,
        phone,
        shipping_address_city,
        shipping_address_country,
        shipping_address_line_1,
        shipping_address_line_2,
        shipping_address_postal_code,
        shipping_address_state,
        shipping_name,
        shipping_phone,
        source_relation,
        coalesce(is_deleted, false) as is_deleted

        {%- set metadata_list = var('stripe__customer_metadata', []) -%}
        {%- set unique_metadata_list = [] -%}
        {%- for field in metadata_list %}
            {%- do unique_metadata_list.append(field.alias if field.alias else field.name) %}
        {% endfor -%}

        {%- if var('customer360_internal_match_ids') %}
            {%- for match_set in var('customer360_internal_match_ids') %}
                {%- if match_set.stripe %}
                    {%- if match_set.stripe.map_table %}
                        {%- if match_set.stripe.join_with_map_on not in unique_metadata_list -%}
                            {% do metadata_list.append({"name": match_set.stripe.join_with_map_on}) -%}
                        {% endif -%}
                    {%- else %}
                        {%- if match_set.stripe.match_key not in unique_metadata_list -%}
                            {% do metadata_list.append({"name": match_set.stripe.match_key}) -%}
                        {% endif -%}
                    {%- endif %}
                {%- endif %}
            {%- endfor %}
        {%- endif %}
        
        {% if metadata_list %}
        , {{ fivetran_utils.pivot_json_extract(string = 'metadata', list_of_properties = metadata_list) }}
        {% endif %}

    from fields
    {{ livemode_predicate() }}
)

select * 
from final
