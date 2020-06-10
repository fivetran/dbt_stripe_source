

with subscription as (

    select *
    from `dbt-package-testing`.`stripe`.`subscription`

), fields as (

    select
      id,
      status,
      billing,
      billing_cycle_anchor,
      cancel_at,
      cancel_at_period_end,
      canceled_at,
      created,
      current_period_start,
      current_period_end,
      customer_id,
      days_until_due,
      start_date,
      ended_at
    from subscription

)

select * from fields