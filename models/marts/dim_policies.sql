select
    policy_id,
    customer_id,
    policy_number,
    policy_type,
    coverage_amount,
    annual_premium,
    policy_start_date,
    policy_status
from {{ ref('stg_policies') }}