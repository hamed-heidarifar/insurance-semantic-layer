select
    transaction_id,
    policy_id,
    cast(transaction_date as date) as transaction_date,
    transaction_type,
    transaction_amount,
    transaction_status
from {{ ref('raw_transactions_2hr') }}