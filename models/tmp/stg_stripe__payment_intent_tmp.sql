select * 
from {{ var('payment_intent') }}

{{ livemode_predicate() }}
