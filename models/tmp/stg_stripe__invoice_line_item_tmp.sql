{{ config(enabled=var('using_invoices', True)) }}

select * 
from {{ var('invoice_line_item') }}

{{ livemode_predicate() }}