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
