let

    // aqui eu estou chamando a API da Brevo
    // especificamente o endpoint /contacts/lists, que retorna as listas de contatos

    Source = Json.Document(

        // Web.Contents é a função que faz a requisição para uma API ou site
        // basicamente o Power BI vai acessar essa URL

        Web.Contents(

            // endpoint da API
            "https://api.brevo.com/v3/contacts/lists",

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
    ),

    // o retorno da API vem em formato JSON
    // dentro desse JSON existe o campo "lists", onde estão as listas de contatos

    lists = Source[lists],

    // aqui estou transformando a lista de registros em uma tabela
    // isso permite que o Power BI trabalhe com os dados de forma tabular

    #"Tabela" = Table.FromList(

        lists,
        Splitter.SplitByNothing(),
        {"Column1"},
        null,
        ExtraValues.Error

    ),

    // agora estou expandindo os campos do registro que veio da API
    // cada lista possui informações como id, nome e quantidade de inscritos

    #"Expandido" = Table.ExpandRecordColumn(

        #"Tabela",
        "Column1",
        {"id","name","totalSubscribers","uniqueSubscribers","folderId","createdAt"},
        {"id","name","totalSubscribers","uniqueSubscribers","folderId","createdAt"}

    ),

    // aqui estou definindo os tipos das colunas
    // isso melhora a organização e evita erros no Power BI

    #"Tipo Alterado" = Table.TransformColumnTypes(

        Expandido,
        {
            {"id", Int64.Type},
            {"name", type text},
            {"totalSubscribers", Int64.Type},
            {"uniqueSubscribers", Int64.Type},
            {"folderId", Int64.Type},
            {"createdAt", type datetime}
        }

    )

// "in" define o resultado final da consulta
// nesse caso estou retornando a tabela já tratada com as listas de contatos

in
    #"Tipo Alterado"
