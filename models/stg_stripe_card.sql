with card as (

    select *
    from {{ source('stripe', 'card') }}

), fields as (

    select 
      id as card_id,
      account_id,
      brand,
      country,
      created as created_at,
      currency,
      customer_id,
      name,
      network,
      recipient
    from card
    where not is_deleted

)

select *
from fields