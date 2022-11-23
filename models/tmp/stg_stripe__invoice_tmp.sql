{{ config(enabled=var('stripe__using_invoices', True)) }}

select * 
from {{ var('invoice') }}

{{ livemode_predicate() }}
