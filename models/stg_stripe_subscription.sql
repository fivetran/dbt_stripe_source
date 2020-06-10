{{ config(enabled=var('using_invoices', True)) }}

with subscription as (

    select *
    from {{ source('stripe', 'subscription') }}

), fields as (

    select
      id as subscription_id,
      status,
      billing,
      billing_cycle_anchor,
      cancel_at,
      cancel_at_period_end,
      canceled_at,
      created as created_at,
      current_period_start,
      current_period_end,
      customer_id,
      days_until_due,
      start_date,
      ended_at
    from subscription

)

select * from fields