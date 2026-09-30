select
    customer_id,
    customer_name,
    state,
    age,
    customer_segment
from {{ ref('raw_customers_2hr') }}