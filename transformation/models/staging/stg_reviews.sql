{{
  config(
    materialized = 'table',
    )
}}

with reviews as (
    select
        author_id as customer_id,
        rating,
        is_recommended::boolean as is_recommended,
        helpfulness::number(38,2) as is_helpfulness,
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
),

removed_duplicate_reviews as (
    select
        *,
    from reviews
    qualify row_number() over (
        partition by
            customer_id,
            total_feedback_count
        order by
        review_submission_time desc
    ) = 1
)

select
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'total_feedback_count'])}} as review_id,
    *,
    to_timestamp(current_timestamp) as ingested_at
from removed_duplicate_reviews
