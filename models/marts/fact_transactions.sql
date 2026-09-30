select
    t.transaction_id,
    t.policy_id,
    p.customer_id,
    t.transaction_date,
    t.transaction_type,
    t.transaction_amount,
    t.transaction_status
from {{ ref('stg_transactions') }} as t
left join {{ ref('stg_policies') }} as p
    on t.policy_id = p.policy_id