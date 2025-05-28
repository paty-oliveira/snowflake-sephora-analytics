{{
  config(
    materialized = 'table',
    )
}}

{% set composite_key = ['review_id', 'customer_id', 'product_id'] %}

with reviews as (
    select
        review_id,
        customer_id,
        product_id,
        review_title,
        review_text,
        rating as review_rating,
        total_feedback_count,
        review_submission_time as submitted_at
    from {{ ref('stg_reviews') }}
    where
        review_text is not null
)

select
    {{ dbt_utils.generate_surrogate_key(composite_key)}} as customer_review_id,
    *,
    to_timestamp_ntz(current_timestamp) as created_at
from reviews
