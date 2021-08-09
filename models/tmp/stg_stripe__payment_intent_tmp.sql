select * 
from {{ var('payment_intent') }}

{{ predicate_by_config_livemode() }}
