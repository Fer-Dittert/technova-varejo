{{ config(materialized='table') }}

select distinct
    id_vendedor as vendedor_key,
    id_vendedor,
    cep_vendedor,
    cidade_vendedor,
    estado_vendedor
from {{ ref('stg_vendedores') }}