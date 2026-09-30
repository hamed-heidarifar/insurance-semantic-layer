select
    claim_id,
    policy_id,
    claim_number,
    cast(claim_date as date) as claim_date,
    claim_category,
    claim_amount,
    claim_status,
    cast(settlement_date as date) as settlement_date,
    settlement_amount,
    days_to_settlement
from {{ ref('raw_claims_2hr') }}