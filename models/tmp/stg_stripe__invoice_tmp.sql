{{ config(enabled=var('using_invoices', True)) }}

select * 
from {{ var('invoice') }}

{{ predicate_by_config_livemode() }}
