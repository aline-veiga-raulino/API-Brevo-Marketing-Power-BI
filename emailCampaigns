let

    // aqui estou chamando a API da Brevo para buscar as campanhas de email
    // usei o endpoint /emailCampaigns
    // o parâmetro limit=100 define que a API vai retornar no máximo 100 campanhas

    Source = Json.Document(
        Web.Contents(
            "https://api.brevo.com/v3/emailCampaigns?limit=100",
            [
                Headers = [
                    // aqui envio a chave da API para autenticação
                    // sem a api-key a requisição retorna erro de acesso
                    #"api-key"="DIGITE_SUA_CHAVE"
                ]
            ]
        )
    ),

    // a resposta da API vem em JSON
    // dentro desse JSON existe um campo chamado "campaigns"
    // que contém a lista de campanhas de email

    campaigns = Source[campaigns],

    // agora transformo essa lista em uma tabela no Power BI
    // cada item da lista vira uma linha da tabela

    #"Tabela" = Table.FromList(
        campaigns,
        Splitter.SplitByNothing(),
        {"Column1"},
        null,
        ExtraValues.Error
    ),

    // cada linha ainda é um "record" (estrutura com vários campos)
    // então aqui eu expando esses campos para virar colunas

    #"Expandido" = Table.ExpandRecordColumn(
        #"Tabela",
        "Column1",
        {"id","name","subject","type","status","scheduledAt","createdAt"},
        {"id","name","subject","type","status","scheduledAt","createdAt"}
    )

// resultado final: tabela com as informações das campanhas de email

in
    #"Expandido"
