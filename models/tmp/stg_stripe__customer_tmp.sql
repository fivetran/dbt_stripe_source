select * 
from {{ var('customer') }}
where livemode = TRUE
  and is_deleted = FALSE