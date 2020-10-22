with card as (

    select *
    from {{ var('card') }}

), fields as (

    select 
      id as card_id,
      brand,
      country,
      created as created_at,
      customer_id,
      name,
      recipient,
      funding
    from card

)

select *
from fields