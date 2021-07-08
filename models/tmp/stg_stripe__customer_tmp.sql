select * 
from {{ var('customer') }}
where 
{% if var('exclude_test_customers', true) %}
    coalesce(livemode, true) and 
{% endif %}
    not coalesce(is_deleted, false)