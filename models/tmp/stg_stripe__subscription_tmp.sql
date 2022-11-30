{{ config(enabled=var('stripe__using_subscriptions', True)) }}

select * from (

{% if var('stripe__subscription_history', true) %}

{{
    fivetran_utils.union_data(
        table_identifier='subscription_history', 
        database_variable='stripe_database', 
        schema_variable='stripe_schema', 
        default_database=target.database,
        default_schema='stripe',
        default_variable='subscription_history',
        union_schema_variable='stripe_union_schemas',
        union_database_variable='stripe_union_databases'
    )
}}

{% else %}

{{
    fivetran_utils.union_data(
        table_identifier='subscription', 
        database_variable='stripe_database', 
        schema_variable='stripe_schema', 
        default_database=target.database,
        default_schema='stripe',
        default_variable='subscription',
        union_schema_variable='stripe_union_schemas',
        union_database_variable='stripe_union_databases'
    )
}}

{% endif %}

)

{{ livemode_predicate() }}
{% if var('stripe__subscription_history', true) %}
    and coalesce(_fivetran_active, true)
{% endif %}

