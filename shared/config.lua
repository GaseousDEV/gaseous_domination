
Config = {}

Config.PermAdmin = "suapermissao.permissao" -- PERMISSAO ADM PARA TER ACESSO AOS COMANDOS

Config.Domination = {
    ["Drogas"] = { 
        ['x'] = 97.35, ['y'] = -2022.05, ['z'] = 18.31, -- COODENADA DO BLIP PARA PEGAR OS ITENS
        ['quantity'] = 4,  -- QUANTIDADE DE ITENS POR BLIP
        ['item'] = {
            { name = "lancaperfume"} -- NOME DO ITEM
        },
        ['permission'] = "suapermissao.permissao", -- PERMISSAO PARA PODER PARTICIPAR DO DOMINAS
    },
    ["Armas"] = { 
        ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, 
        ['quantity'] = 4,  
        ['item'] = {
            { name = "armacaodeak"},
            { name = "armacaodeg3"},
            { name = "armacaodemp5"},
            { name = "armacaodetec"}
        },
        ['permission'] = "suapermissao.permissao", -- PERMISSAO PARA PODER PARTICIPAR DO DOMINAS
    },
    ["Muni"] = { 
        ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, 
        ['quantity'] = 4,  
        ['item'] = {
            { name = "m-armacaog3"},
            { name = "m-armacaoak"},
            { name = "m-armacaotec"},
            { name = "m-armacaomp5"}
        },
        ['permission'] = "suapermissao.permissao", -- PERMISSAO PARA PODER PARTICIPAR DO DOMINAS
    }
}
