{{
  config(
    materialized = 'table',
    )
}}


with product_information as (
    select
        product_id,
        brand_id,
        product_name as name,
        brand_name,
        product_type as type,
        product_category as category,
        product_sub_category as subcategory,
        product_highlights as highlights,
        product_size as size,
        product_ingredients as ingredients,
        parameter_type,
        parameter_value,
        parameter_description,
        product_price_usd as price_usd,
        coalesce(product_value_price_usd, 0) as value_price_usd,
        coalesce(product_sales_price_usd, 0) as sales_price_usd,
        is_product_limited_edition as is_limited_edition,
        is_product_new as is_new,
        is_product_online_only as is_online_only,
        is_product_out_of_stock as is_out_of_stock,
        is_product_sephora_exclusive as is_sephora_exclusice
    from {{ ref('stg_product_info') }}
    where
        type is not null
        and category is not null
        and subcategory is not null
        and size is not null
        and ingredients is not null
)

select
     *,
     to_timestamp_ntz(current_timestamp) as created_at
from product_information
