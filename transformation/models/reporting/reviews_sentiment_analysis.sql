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

aggregated_reviews as (
    select
        product_id,
        array_agg(review_text) within group (order by submitted_at desc) as all_reviews,
        avg(review_rating)::number(38,2) as avg_rating,
        count(review_text)::number(38,0) as total_reviews,
        max(submitted_at) as last_submitted_at
    from removed_special_chars
    group by product_id
),

enriched_product_information as (
    select
        reviews.product_id,
        products.name as product_name,
        products.type as product_type,
        products.category as product_category,
        products.subcategory as product_sub_category,
        array_to_string(reviews.all_reviews, '<review>') as all_reviews,
        reviews.avg_rating,
        reviews.total_reviews,
        reviews.last_submitted_at
    from aggregated_reviews as reviews
    join {{ ref('dim_product') }} as products
        on reviews.product_id = products.product_id
)

select
    product_id,
    product_name,
    product_type,
    product_category,
    product_sub_category,
    snowflake.cortex.try_complete(
        'claude-3-5-sonnet',
        concat('You are a helpful assistant specialized in analyzing customer feedback. Below is a
        list of customer reviews for a product. Please read all the reviews carefully and provide
        a concise summary that captures the main sentiments, recurring themes (both positive and
        negative), and any common suggestions for improvement. Customer Reviews: ',
        all_reviews)
    ) as sentiment_summary,
    avg_rating,
    total_reviews,
    last_submitted_at,
    to_timestamp_ntz(current_timestamp) as created_at
from enriched_product_information
