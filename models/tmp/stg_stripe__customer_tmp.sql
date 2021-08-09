select * 
from {{ var('customer') }}

    {{ predicate_by_config_livemode() }}
    and 
    not coalesce(is_deleted, false)