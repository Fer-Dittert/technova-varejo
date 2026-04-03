with source as (

    select *
    from {{ ref('stg_vendedores') }}

)

select
    id_vendedor,
    cep_vendedor,
    cidade_vendedor,
    estado_vendedor

from source