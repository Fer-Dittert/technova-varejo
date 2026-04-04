{{ config(materialized='table') }}

with sequencia as (

    select
        row_number() over (order by relname) - 1 as n
    from pg_class
    limit 5000

),

datas as (

    select
        dateadd(day, n, cast('2016-01-01' as date)) as id_data
    from sequencia
    where dateadd(day, n, cast('2016-01-01' as date)) <= cast('2025-12-31' as date)

)

select
    id_data,
    date_part(year, id_data) as ano,
    date_part(month, id_data) as mes,
    date_part(day, id_data) as dia,
    date_part(quarter, id_data) as trimestre,
    date_part(dow, id_data) as dia_semana_numero,
    to_char(id_data, 'Month') as nome_mes,
    to_char(id_data, 'Day') as nome_dia_semana,
    case
        when date_part(dow, id_data) in (0, 6) then 1
        else 0
    end as fim_de_semana
from datas