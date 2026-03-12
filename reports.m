let

```
// aqui estou chamando a API da Brevo
// especificamente o endpoint /reports
// ele retorna relatórios de estatísticas de envio de emails

Source = Json.Document(

    // Web.Contents faz a requisição HTTP para a API

    Web.Contents(

        // endpoint da API
        "https://api.brevo.com/v3/smtp/statistics/reports",

        [
            // headers da requisição
            // a API da Brevo exige autenticação via api-key

            Headers = [

                // substitua pela sua chave da API
                #"api-key" = "DIGITE_SUA_CHAVE",

                // define o formato da requisição
                #"Content-Type" = "application/json"

            ]
        ]
    )
),

// o retorno da API vem em formato JSON
// dentro desse JSON existe o campo "reports"
// nele estão os relatórios de estatísticas de envio

reports = Source[reports],

// aqui estou transformando a lista de relatórios em uma tabela

#"Tabela" = Table.FromList(

    reports,
    Splitter.SplitByNothing(),
    null,
    null,
    ExtraValues.Error

),

// cada item da lista é um registro contendo as métricas
// aqui estou expandindo esses campos para virar colunas

#"Expandido" = Table.ExpandRecordColumn(

    #"Tabela",
    "Column1",
    {"date","requests","delivered","opens","clicks","bounces","spam"},
    {"date","requests","delivered","opens","clicks","bounces","spam"}

),

// aqui estou definindo os tipos das colunas
// isso ajuda na organização e evita erros no Power BI

#"Tipo Alterado" = Table.TransformColumnTypes(

    #"Expandido",
    {
        {"date", type date},
        {"requests", Int64.Type},
        {"delivered", Int64.Type},
        {"opens", Int64.Type},
        {"clicks", Int64.Type},
        {"bounces", Int64.Type},
        {"spam", Int64.Type}
    }

)
```

// "in" define o resultado final da consulta
// nesse caso estou retornando a tabela com as estatísticas tratadas

in
#"Tipo Alterado"
