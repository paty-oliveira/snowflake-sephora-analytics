{{
  config(
    materialized = 'table',
    )
}}

with reviews as (
    select
        author_id as customer_id,
        rating,
        is_recommended,
        helpfulness as is_helpfulness,
        total_feedback_count,
        total_neg_feedback_count,
        total_pos_feedback_count,
        review_title,
        review_text,
        submission_time as review_submission_time,
        skin_tone as customer_skin_tone,
        eye_color as customer_eye_color,
        skin_type as customer_skin_type,
        hair_color as customer_hair_color,
        product_id,
        product_name,
        brand_name,
        usd_price as product_price_usd
    from {{ source('sephora_online', 'reviews') }}
)

select
    *,
    to_timestamp(current_timestamp) as ingested_at
from reviews
