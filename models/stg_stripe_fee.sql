with fee as (

    select *
    from {{ source('stripe', 'fee') }}

), fields as (

    select 
      balance_transaction_id,
      amount,
      application,
      currency,
      description,
      type
    from fee

)

select *
from fields