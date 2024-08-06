{{ config(enabled=var('stripe__using_subscriptions', True) and var('customer360__using_stripe', true)) }}

{{
    fivetran_utils.union_data(
        table_identifier='subscription_history' if var('stripe__using_subscription_history', does_table_exist('subscription_history')) else 'subscription', 
        database_variable='stripe_database', 
        schema_variable='stripe_schema', 
        default_database=target.database,
        default_schema='stripe',
        default_variable='subscription_history' if var('stripe__using_subscription_history', does_table_exist('subscription_history')) else 'subscription',
        union_schema_variable='stripe_union_schemas',
        union_database_variable='stripe_union_databases'
    )
}}