with claims_by_policy as (

    select
        policy_id,
        count(*) as claim_count,
        sum(claim_amount) as total_claim_amount,
        sum(settlement_amount) as total_settlement_amount,
        avg(days_to_settlement) as avg_settlement_days
    from {{ ref('fact_claims') }}
    group by policy_id

),

premiums_by_policy as (

    select
        policy_id,
        sum(
            case
                when transaction_type = 'Premium Payment'
                     and transaction_status = 'Completed'
                then transaction_amount
                else 0
            end
        ) as total_premium
    from {{ ref('fact_transactions') }}
    group by policy_id

)

select
    p.policy_id,
    p.customer_id,
    p.policy_number,
    p.policy_type,
    p.policy_status,
    p.coverage_amount,
    p.annual_premium,

    coalesce(c.claim_count, 0) as claim_count,
    coalesce(c.total_claim_amount, 0) as total_claim_amount,
    coalesce(c.total_settlement_amount, 0) as total_settlement_amount,
    coalesce(pr.total_premium, 0) as total_premium,

    c.avg_settlement_days,

    case
        when coalesce(pr.total_premium, 0) > 0
        then coalesce(c.total_settlement_amount, 0) / pr.total_premium
        else null
    end as loss_ratio

from {{ ref('dim_policies') }} as p

left join claims_by_policy as c
    on p.policy_id = c.policy_id

left join premiums_by_policy as pr
    on p.policy_id = pr.policy_id