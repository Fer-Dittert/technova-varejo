with vendas as (

    select *
    from {{ ref('int_vendas_enriquecidas') }}

),

status as (

    select *
    from {{ ref('dim_status_pedido') }}

)

select
    v.id_pedido,
    v.id_item_pedido,
    v.id_cliente,
    v.id_produto,
    v.id_vendedor,

    cast(v.data_compra as date) as id_data,
    s.id_status_pedido,

    v.valor_item,
    v.valor_frete,
    v.valor_total_item,
    v.indicador_entregue,
    v.indicador_atraso,
    v.dias_entrega

from vendas v
left join status s
    on v.status_pedido = s.status_pedido