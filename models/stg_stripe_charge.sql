with charge as (

    select *
    from {{ source('stripe', 'charge') }}

), fields as (

    select 
      id as charge_id, 
      amount,
      amount_refunded,
      application_fee_amount,
      balance_transaction_id,
      captured as is_captured,
      card_id,
      created as created_at,
      currency,
      customer_id,
      description,
      destination,
      failure_code,
      failure_message,
      invoice_id,
      paid as is_paid,
      payment_intent_id,
      receipt_email,
      receipt_number,
      refunded as is_refunded,
      status
    from charge
    
)

select *
from fields