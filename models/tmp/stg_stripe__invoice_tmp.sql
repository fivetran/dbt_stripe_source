{{ config(enabled=var('using_invoices', True)) }}

select * 
from {{ var('invoice') }}

{{ livemode_predicate() }}
