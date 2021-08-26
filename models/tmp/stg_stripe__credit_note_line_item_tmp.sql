{{ config(enabled=var('using_credit_notes', True)) }}

select * 
from {{ var('credit_note_line_item') }}
{{ livemode_predicate() }}