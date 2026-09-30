-- ============================================================
-- Sample Business Queries
-- Semantic Layer Implementation Project
-- ============================================================


-- 1. Loss Ratio by Policy Type
-- Definition:
-- Total Settlement Amount / Total Completed Premium Payments

select
    policy_type,
    sum(total_settlement_amount) as total_settlement_amount,
    sum(total_premium) as total_premium,
    sum(total_settlement_amount)
        / nullif(sum(total_premium), 0) as loss_ratio
from {{ ref('insurance_metrics') }}
group by policy_type
order by policy_type;


-- 2. Active Policy Count
-- Definition:
-- Number of policies whose current status is Active

select
    count(*) as active_policy_count
from {{ ref('insurance_metrics') }}
where policy_status = 'Active';


-- 3. Average Claim Settlement Time
-- Definition:
-- Average number of days to settlement for settled claims

select
    avg(days_to_settlement) as avg_settlement_days
from {{ ref('fact_claims') }}
where claim_status = 'Settled'
  and days_to_settlement is not null;