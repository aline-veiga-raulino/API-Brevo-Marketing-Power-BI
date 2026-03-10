let

    // aqui eu estou chamando a API da Brevo
    // especificamente o endpoint /account, que retorna informações da conta

    Source = Json.Document(

        // Web.Contents é a função que faz a requisição para uma API ou site
        // basicamente o Power BI vai acessar essa URL

        Web.Contents(

            // endpoint da API
            "https://api.brevo.com/v3/account",

            [
                // aqui eu passo os headers da requisição
                // nesse caso estou enviando a chave da API para autenticar

                Headers = [

                    // api-key é o método de autenticação da API da Brevo
                    // sem isso a API não retorna os dados

                    #"api-key"="DIGITE_SUA_CHAVE"

                ]
            ]
        )
    )

// "in" define o resultado final da consulta
// aqui estou retornando o conteúdo que veio da API
// o Json.Document transforma o JSON em estrutura que o Power BI consegue ler

in
    Source
