select * 
from {{ var('customer') }}

    {{ livemode_predicate() }}
    and 
    not coalesce(is_deleted, false)