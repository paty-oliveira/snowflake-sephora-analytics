{{
  config(
    materialized = 'table'
    )
}}

with products_information as (
    select
        product_id,
        brand_id,
        product_name,
        brand_name,
        loves_count as total_loves,
        rating::number(38,0) as rating,
        reviews as total_reviews,
        size as product_size,
        variation_type as parameter_type,
        variation_value as parameter_value,
        variation_desc as parameter_description,
        ingredients as product_ingredients,
        price_usd as product_price_usd,
        value_price_usd as product_value_price_usd,
        sale_price_usd as product_sales_price_usd,
        limited_edition as is_product_limited_edition,
        new as is_product_new,
        online_only as is_product_online_only,
        out_of_stock as is_product_out_of_stock,
        sephora_exclusive as is_product_sephora_exclusive,
        highlights as product_highlights,
        primary_category as product_type,
        secondary_category as product_category,
        tertiary_category as product_sub_category,
        child_count as total_product_variations,
        child_max_price as product_variation_max_price_usd,
        child_min_price as product_variation_min_price_usd
    from {{ source('sephora_online', 'product_info') }}
)

select
    *,
    to_timestamp(current_timestamp) as ingested_at
from products_information
