# API-Brevo-Marketing-Power-BI

Projeto de integração da **API Brevo Marketing** com **Power BI**, permitindo extrair, tratar e visualizar dados de campanhas de e-mail marketing.
O objetivo é transformar dados da API em **tabelas analíticas e dashboards**, facilitando o acompanhamento de métricas de campanhas, contatos e entregabilidade.

# 🚀 Objetivo do Projeto

Consumir dados da **API da Brevo** e transformá-los em **visualizações no Power BI** para análise de:

* 📧 campanhas de e-mail
* 👥 contatos
* 📋 listas de contatos
* 📊 relatórios de envio
* 📈 estatísticas de performance

Esse projeto demonstra como utilizar **Power Query (M Language)** para integração com APIs externas dentro do **Power BI**.

# 🛠 Tecnologias Utilizadas

* **Power BI**
* **Power Query (M Language)**
* **API REST**
* **JSON**
* **Brevo Marketing Platform**

# 🔌 Endpoints da API Utilizados

Os seguintes endpoints da API da Brevo são consumidos:

| Endpoint                   | Descrição            |
| -------------------------- | -------------------- |
| `/account`                 | Informações da conta |
| `/contacts`                | Lista de contatos    |
| `/contacts/lists`          | Listas de contatos   |
| `/emailCampaigns`          | Campanhas de e-mail  |
| `/smtp/statistics/reports` | Relatórios de envio  |
| `/smtp/blockedDomains`     | Domínios bloqueados  |

# 📂 Estrutura do Projeto

```
queries-pbix/
│
├── account
│   Informações da conta da Brevo
│
├── contacts
│   Extração paginada de contatos
│
├── emailcampaigns
│   Campanhas de e-mail
│
├── lists
│   Listas de contatos
│
└── reports
    Estatísticas de envio
```

# 🔄 Paginação da API

A API da Brevo limita o retorno de **contatos a 1000 registros por requisição**.
Para contornar essa limitação, foram criadas múltiplas queries:

```
contacts[1]
contacts[2]
contacts[3]
```

Essas queries são posteriormente combinadas em:

```
contacts[completo]
```

Assim é possível consolidar todos os contatos em uma única tabela no Power BI.

# 🔐 Segurança

A **API Key da Brevo não está incluída neste repositório** por questões de segurança.
Para executar o projeto:
1. Obtenha sua API Key na plataforma Brevo
2. Substitua a chave no código do **Power Query**

# 📊 Possíveis Análises no Power BI

Com os dados extraídos é possível criar dashboards como:
* Taxa de abertura de campanhas
* Taxa de cliques
* Performance por campanha
* Crescimento de base de contatos
* Domínios bloqueados
* Estatísticas de envio SMTP

# 💡 Possíveis Melhorias

* Automatizar paginação via função no Power Query
* Criar dashboard completo de marketing
* Implementar atualização automática via Power BI Service

# 📎 Autor

Projeto desenvolvido por **Aline Veiga Raulino**, Analista Jr.
