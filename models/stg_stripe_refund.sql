with refund as (

    select *
    from {{ var('refund') }}

), fields as (

    select 
      id as refund_id,
      amount,
      balance_transaction_id,
      charge_id,
      created as created_at,
      currency,
      description,
      reason,
      receipt_number,
      status
    from refund

)

select *
from fields