{{ config(enabled=var('using_credit_notes', False)) }}

select * 
from {{ var('credit_note_line_item') }}
{{ livemode_predicate() }}