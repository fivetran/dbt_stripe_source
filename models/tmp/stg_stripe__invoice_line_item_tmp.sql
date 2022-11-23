{{ config(enabled=var('stripe__using_invoices', True)) }}

select * 
from {{ var('invoice_line_item') }}

{{ livemode_predicate() }}