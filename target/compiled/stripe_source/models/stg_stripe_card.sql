with card as (

    select *
    from `dbt-package-testing`.`stripe`.`card`

), fields as (

    select 
      id as card_id,
      brand,
      country,
      created as created_at,
      customer_id,
      name,
      recipient
    from card
    where not is_deleted

)

select *
from fields