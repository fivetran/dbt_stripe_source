select * 
from {{ var('customer') }}
where livemode
  and not is_deleted