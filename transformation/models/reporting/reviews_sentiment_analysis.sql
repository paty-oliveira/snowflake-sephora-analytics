{{
  config(
    materialized = 'table',
    )
}}

with removed_special_chars as (
    select
        product_id,
        regexp_replace(review_text, '["''`''""]') as cleaned_review,
        review_rating,
        review_text,
        submitted_at
    from {{ ref('fct_customer_reviews') }}
),

aggreated_reviews as (
    select
        product_id,
        array_agg(review_text) within group (order by submitted_at desc) as all_reviews,
        avg(review_rating)::number(38,2) as avg_rating,
        count(review_text)::number(38,0) as total_reviews,
        max(submitted_at) as last_submitted_at
    from removed_special_chars
    group by product_id
)

select
    product_id,
    snowflake.cortex.try_complete(
        'claude-3-5-sonnet',
        concat('You are a helpful assistant specialized in analyzing customer feedback. Below is a
        list of customer reviews for a product. Please read all the reviews carefully and provide
        a concise summary that captures the main sentiments, recurring themes (both positive and
        negative), and any common suggestions for improvement. Customer Reviews: ',
        array_to_string(all_reviews, '<review>'))
    ) as sentiment_summary,
    avg_rating,
    total_reviews,
    last_submitted_at,
    to_timestamp_ntz(current_timestamp) as created_at
from reviews_aggregated
