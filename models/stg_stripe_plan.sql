{{ config(enabled=var('using_subscriptions', True)) }}

with plan as (

    select *
    from {{ var('plan') }}

), fields as (

    select
      id as plan_id,
      active as is_active,
      amount,
      currency,
      "interval" as plan_interval,
      interval_count,
      nickname,
      product_id
    from plan

)

select * from fields