

with invoice_line_item as (

    select *
    from `dbt-package-testing`.`stripe`.`invoice_line_item`

), fields as (

    select
      id,
      invoice_id,
      amount,
      currency,
      description,
      discountable,
      plan_id,
      proration,
      quantity,
      subscription_id,
      subscription_item_id,
      type,
      unique_id
    from invoice_line_item

)

select * from fields