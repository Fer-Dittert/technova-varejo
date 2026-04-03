{{ config(materialized='table') }}

with datas as (

    select distinct
        cast(data_compra as date) as data
    from {{ ref('stg_pedidos') }}
    where data_compra is not null

)

select
    cast(to_char(data, 'YYYYMMDD') as integer) as data_key,
    data,
    extract(year from data) as ano,
    extract(quarter from data) as trimestre,
    extract(month from data) as mes,
    extract(day from data) as dia,
    extract(dow from data) as numero_dia_semana,
    to_char(data, 'Month') as nome_mes,
    to_char(data, 'Day') as nome_dia_semana
from datas