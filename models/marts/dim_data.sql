with limites as (

    select
        min(cast(data_compra as date)) as data_min,
        max(cast(data_compra as date)) as data_max
    from {{ ref('int_vendas_enriquecidas') }}

),

sequencia as (


    select row_number() over () - 1 as n
    from {{ ref('int_vendas_enriquecidas') }}
    limit 5000

),

datas as (

    select
        dateadd(day, n, data_min) as id_data
    from sequencia
    cross join limites
    where dateadd(day, n, data_min) <= data_max

)

select
    id_data,
    extract(year from id_data) as ano,
    extract(month from id_data) as mes,
    extract(day from id_data) as dia,
    extract(quarter from id_data) as trimestre,
    extract(dow from id_data) as dia_semana_numero
from datas