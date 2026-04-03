with source as (

    select *
    from {{ ref('stg_clientes') }}

)

select
    id_cliente,
    id_cliente_unico,
    cep_cliente,
    cidade_cliente,
    estado_cliente

from source