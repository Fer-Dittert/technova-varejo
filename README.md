# 📊 Data Lakehouse com AWS + dbt + Redshift

## ⚠️ Status do Projeto

Este projeto está em desenvolvimento e tem como objetivo principal explorar a integração entre serviços da AWS e ferramentas de engenharia de dados, incluindo Amazon S3, AWS Glue, Lake Formation, Amazon Redshift e dbt.

O foco foi a construção de uma arquitetura de dados e entendimento do fluxo ponta a ponta, desde ingestão até modelagem analítica, não sendo o objetivo principal a realização de maior limpeza ou tratamento avançado da qualidade dos dados.


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

## 📊 Modelo Dimensional

### 📌 Tabela Fato

**fct_vendas**

- granularidade: item de pedido
- métricas:
  - valor_item
  - valor_frete
  - valor_total_item
- indicadores:
  - indicador_entregue
  - indicador_atraso
  - dias_entrega

---

### 📌 Dimensões

- dim_clientes  
- dim_produtos  
- dim_vendedores  
- dim_status_pedido  
- dim_data  

A dimensão de data foi construída considerando todos os dias do período, permitindo análises temporais contínuas.
A dimensão de status do pedido foi criada para transformar o campo textual de status em uma chave numérica, seguindo boas práticas de modelagem dimensional. Essa abordagem melhora a performance das consultas, padroniza os valores e facilita a análise por status de forma consistente.
---

## 🔗 Fontes de Dados

As fontes foram definidas no dbt (`sources.yml`), apontando para as tabelas brutas disponibilizadas no Amazon Redshift.

Esses dados têm origem no Data Lake (Amazon S3), previamente catalogados pelo AWS Glue Data Catalog.

---

## ⚙️ Tecnologias Utilizadas

- Amazon S3  
- AWS Glue  
- AWS Lake Formation  
- Amazon Redshift (Serverless)  
- dbt Cloud  
- SQL  


---

## 🧪 Qualidade de Dados

Foram implementados testes de qualidade de dados utilizando dbt, garantindo a integridade das informações ao longo do pipeline.

Foram aplicados testes como:

- `not_null`: garante ausência de valores nulos em colunas críticas  
- `unique`: assegura unicidade de chaves nas dimensões  
- `relationships`: valida integridade referencial entre fato e dimensões  

Esses testes permitem identificar inconsistências automaticamente, aumentando a confiabilidade dos dados disponíveis para análise.

---

## 🔁 Padronização de Transformações com Macros

Para evitar repetição de código e garantir consistência nas transformações, foram utilizadas macros no dbt.

Foi criada uma macro para padronização de campos textuais, aplicando limpeza e normalização de strings (remoção de espaços e padronização de caixa).

Essa abordagem melhora a legibilidade do código, facilita manutenção e garante consistência nas transformações ao longo das camadas de dados.

---

## 🌉 Arquitetura Híbrida com Redshift Spectrum

Foi utilizada uma abordagem híbrida de dados com Redshift Spectrum, permitindo a consulta de dados diretamente no Amazon S3 sem necessidade de carregamento físico no Redshift.

Os dados armazenados no Data Lake foram previamente catalogados pelo AWS Glue Data Catalog, possibilitando a criação de um external schema no Redshift.

Com isso, foi possível consultar a tabela externa `olist` diretamente via SQL.

