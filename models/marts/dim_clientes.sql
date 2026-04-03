{{ config(materialized='table') }}

select distinct
    id_cliente as cliente_key,
    id_cliente,
    id_cliente_unico,
    cep_cliente
from {{ ref('stg_clientes') }}