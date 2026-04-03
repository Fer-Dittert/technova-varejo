# 📊 Data Lakehouse com AWS + dbt + Redshift

## 📌 Objetivo

Este projeto tem como objetivo construir uma arquitetura moderna de dados utilizando o conceito de Data Lakehouse, transformando dados brutos em informações analíticas organizadas e prontas para consumo.

A solução abrange desde a ingestão de dados até a modelagem dimensional, permitindo análises eficientes e estruturadas.

---

## 🏗️ Arquitetura da Solução

O pipeline de dados foi estruturado da seguinte forma:

- Os dados brutos (CSV e JSON) são armazenados no Amazon S3
- O AWS Glue Data Catalog é utilizado para catalogar os dados e registrar schemas
- O AWS Lake Formation gerencia permissões e governança de acesso
- Os dados são organizados no Data Lake seguindo o conceito de camadas (Silver)
- O Amazon Redshift é utilizado como camada analítica
- O dbt é responsável pelas transformações e organização em camadas (staging, intermediate e marts)
- Os dados finais são disponibilizados para consumo analítico

---

## 🧱 Arquitetura em Camadas (dbt)

### 🔹 Staging
Responsável por:
- leitura das fontes brutas
- padronização de nomes
- conversão de tipos de dados

### 🔹 Intermediate
Responsável por:
- aplicação de joins entre entidades
- consolidação dos dados
- aplicação de regras de negócio

### 🔹 Marts
Responsável por:
- modelagem dimensional (Kimball)
- criação de tabela fato e dimensões
- estrutura final para consumo analítico

---

## 📂 Estrutura do Projeto

```bash
models/
  staging/
  intermediate/
  marts/

``` 

📊 Modelo Dimensional
📌 Tabela Fato

fct_vendas

granularidade: item de pedido
métricas:
valor_item
valor_frete
valor_total_item
indicadores:
indicador_entregue
indicador_atraso
dias_entrega
📌 Dimensões
dim_clientes
dim_produtos
dim_vendedores
dim_status_pedido
dim_data

A dimensão de data foi construída considerando todos os dias do período, permitindo análises temporais contínuas.

🔗 Fontes de Dados

As fontes foram definidas no dbt (sources.yml), apontando para as tabelas brutas disponibilizadas no Amazon Redshift.

Esses dados têm origem no Data Lake (Amazon S3), previamente catalogados pelo AWS Glue Data Catalog.

⚙️ Tecnologias Utilizadas
Amazon S3
AWS Glue
AWS Lake Formation
Amazon Redshift (Serverless)
dbt Cloud
SQL
