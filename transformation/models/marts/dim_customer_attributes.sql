{{
  config(
    materialized = 'table',
    )
}}

with customer_personal_attributes as (
    select distinct
        customer_id,
        customer_skin_tone as skin_tone,
        customer_skin_type as skin_type,
        customer_eye_color as eye_color,
        customer_hair_color as hair_color,
        review_submission_time
    from {{ ref('stg_reviews') }}
),

tracking_attributes_changes as (
    select
        customer_id,
        skin_tone,
        skin_type,
        eye_color,
        hair_color,
        review_submission_time as valid_from,
        lead(review_submission_time) over(partition by customer_id order by review_submission_time) as valid_to
    from customer_personal_attributes
)

select
    *,
    to_timestamp_ntz(current_timestamp) as created_at
from tracking_attributes_changes
