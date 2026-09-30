select
    policy_id,
    customer_id,
    policy_number,
    policy_type,
    coverage_amount,
    annual_premium,
    cast(policy_start_date as date) as policy_start_date,
    policy_status
from {{ ref('raw_policies_2hr') }}