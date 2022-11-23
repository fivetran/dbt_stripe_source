{{ config(enabled=var('stripe__using_credit_notes', False)) }}

select * 
from {{ var('credit_note') }}
{{ livemode_predicate() }}