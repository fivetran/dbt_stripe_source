{{ config(enabled=var('stripe__using_payment_method', True)) }}

{{
    fivetran_utils.union_data(
        table_identifier='payment_method_card', 
        database_variable='stripe_database', 
        schema_variable='stripe_schema', 
        default_database=target.database,
        default_schema='stripe',
        default_variable='payment_method_card_source',
        union_schema_variable='stripe_union_schemas',
        union_database_variable='stripe_union_databases'
    )
}}