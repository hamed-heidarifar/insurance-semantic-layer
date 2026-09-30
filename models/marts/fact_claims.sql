select
    c.claim_id,
    c.policy_id,
    p.customer_id,
    c.claim_number,
    c.claim_date,
    c.claim_category,
    c.claim_amount,
    c.claim_status,
    c.settlement_date,
    c.settlement_amount,
    c.days_to_settlement
from {{ ref('stg_claims') }} as c
left join {{ ref('stg_policies') }} as p
    on c.policy_id = p.policy_id