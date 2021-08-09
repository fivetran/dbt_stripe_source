select * 
from {{ var('payout') }}

{{ predicate_by_config_livemode() }}
