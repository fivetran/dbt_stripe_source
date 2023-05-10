{{ config(enabled=var('stripe__using_subscriptions', True)) }}

{{
    fivetran_utils.union_data(
        table_identifier='price' if var('stripe__using_price', does_table_exist('price')) else 'plan', 
        database_variable='stripe_database', 
        schema_variable='stripe_schema', 
        default_database=target.database,
        default_schema='stripe',
        default_variable='price' if var('stripe__using_price', does_table_exist('price')) else 'plan',
        union_schema_variable='stripe_union_schemas',
        union_database_variable='stripe_union_databases'
    )

}}