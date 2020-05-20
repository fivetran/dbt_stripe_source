with balance_transaction as (

    select *
    from {{ source('stripe', 'balance_transaction') }}

), fields as (

    select 
      id as balance_transaction_id,
      amount,
      available_on,
      created,
      currency,
      description,
      exchange_rate,
      fee,
      net,
      payout_id,
      source,
      status,
      type
    from balance_transaction
)

select *
from fields