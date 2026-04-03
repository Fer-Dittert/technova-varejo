with source as (

    select * 
    from {{ source('raw_olist', 'order_items') }}

),

renamed as (

    select
        order_id as id_pedido,
        cast(order_item_id as integer) as id_item_pedido,
        product_id as id_produto,
        seller_id as id_vendedor,
        cast(shipping_limit_date as timestamp) as data_limite_envio,
        cast(price as numeric(12,2)) as valor_item,
        cast(freight_value as numeric(12,2)) as valor_frete
    from source

)

select * from renamed