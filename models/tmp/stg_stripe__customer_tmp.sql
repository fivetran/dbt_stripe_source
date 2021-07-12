select * 
from {{ var('customer') }}
where 
{% if var('run_on_test_customers_only', false) %} not {% endif %}
    coalesce(livemode, true) and 
    not coalesce(is_deleted, false)