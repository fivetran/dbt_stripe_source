{{ config(enabled=var('stripe__using_subscriptions', True)) }}

{%- set price_or_plan = 'price' 
    if var('stripe__using_price', stripe_source.does_table_exist('price')=='exists') 
    else 'plan' -%}

{# DEBUG #}
{% if execute %}
    {{print('-------- FOR DEBUGGING --------')}}
    {{print('The value of stripe_source.does_table_exist(price) is: ' ~ stripe_source.does_table_exist('price'))}}
    {{print('The value of stripe_source.does_table_exist(plan) is: ' ~ stripe_source.does_table_exist('plan'))}}
    {{print('what is passed to union macro is: '~ price_or_plan)}}
    {{print('--------')}}
{% endif %}

{{
    fivetran_utils.union_data(
        table_identifier=price_or_plan, 
        database_variable='stripe_database', 
        schema_variable='stripe_schema', 
        default_database=target.database,
        default_schema='stripe',
        default_variable=price_or_plan,
        union_schema_variable='stripe_union_schemas',
        union_database_variable='stripe_union_databases'
    )

}}