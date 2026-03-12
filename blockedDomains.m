let

```
// aqui estou chamando a API da Brevo
// especificamente o endpoint /blockedDomains
// ele retorna a lista de domínios bloqueados para envio de email

Source = Json.Document(

    // Web.Contents é a função que faz a requisição HTTP para a API

    Web.Contents(

        // endpoint da API
        "https://api.brevo.com/v3/smtp/blockedDomains",

        [
            // aqui estou enviando os headers da requisição
            // a API da Brevo exige a api-key para autenticação

            Headers = [

                // substitua pela sua chave da API da Brevo
                #"api-key" = "DIGITE_SUA_CHAVE",

                // define o formato da requisição como JSON
                #"Content-Type" = "application/json"

            ]
        ]
    )
),

// o retorno da API vem em formato JSON
// dentro da resposta existe o campo "domains"
// esse campo contém a lista de domínios bloqueados

domains = Source[domains],

// aqui estou convertendo a lista de domínios em uma tabela
// isso permite que o Power BI trate os dados em formato tabular

#"Tabela" = Table.FromList(

    domains,
    Splitter.SplitByNothing(),
    {"blocked_domain"}

)
```

// "in" define qual será o resultado final da consulta
// nesse caso estou retornando a tabela com os domínios bloqueados

in
#"Tabela"
