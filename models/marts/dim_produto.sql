with source as (

    select *
    from {{ ref('stg_produtos') }}

)

select
    id_produto,
    categoria_produto,
    tamanho_nome_produto,
    tamanho_descricao_produto,
    quantidade_fotos_produto,
    peso_produto_g

from source