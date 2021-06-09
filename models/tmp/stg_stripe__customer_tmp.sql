select * 
from {{ var('customer') }}
where coalesce(livemode, true)
    and not coalesce(is_deleted, false)