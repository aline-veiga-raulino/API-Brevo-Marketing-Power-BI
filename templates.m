let

```
// aqui estou chamando a API da Brevo
// especificamente o endpoint /smtp/templates
// ele retorna a lista de templates de email configurados na conta

Source = Json.Document(

    // Web.Contents faz a requisição HTTP para a API

    Web.Contents(

        // endpoint da API
        "https://api.brevo.com/v3/smtp/templates",

        [
            // headers da requisição
            // a API da Brevo exige autenticação via api-key

            Headers = [

                // substitua pela sua chave da API da Brevo
                #"api-key" = "DIGITE_SUA_CHAVE",

                // define o formato da requisição
                #"Content-Type" = "application/json"

            ]
        ]
    )
),

// o retorno da API vem em formato JSON
// dentro dele existe o campo "templates"
// onde estão os templates de email

templates = Source[templates],

// aqui estou convertendo a lista de templates em uma tabela

#"Tabela" = Table.FromList(

    templates,
    Splitter.SplitByNothing(),
    null,
    null,
    ExtraValues.Error

),

// cada template é um registro contendo várias informações
// aqui estou expandindo os principais campos

#"Expandido" = Table.ExpandRecordColumn(

    #"Tabela",
    "Column1",
    {"id","name","subject","sender"},
    {"id","name","subject","sender"}

),

// o campo "sender" também é um registro
// por isso estou expandindo novamente para obter nome e email do remetente

#"Expandido Sender" = Table.ExpandRecordColumn(

    #"Expandido",
    "sender",
    {"name","email"},
    {"sender_name","sender_email"}

)
```

// "in" define o resultado final da consulta
// aqui estou retornando a tabela com os templates e informações do remetente

in
#"Expandido Sender"
