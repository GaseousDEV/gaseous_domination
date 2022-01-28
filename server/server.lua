local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

srr = {}
Tunnel.bindInterface(GetCurrentResourceName(), srr)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

GlobalState.Dominas = false

function CheckStats(source)   
    if not GlobalState.Dominas then
        GlobalState.Dominas = true
        vCLIENT.SetStatus(-1)
        TriggerClientEvent("Notify", source,  "sucesso","Dominas On") -- SE QUISER COLOCAR A MENSAGEM PARA TODOS SO TROCAR DE SOURCE PARA -1
    else 
        GlobalState.Dominas = false
        vCLIENT.SetStatus(-1)
        TriggerClientEvent("Notify", source,  "negado","Dominas Off") -- SE QUISER COLOCAR A MENSAGEM PARA TODOS SO TROCAR DE SOURCE PARA -1
    end
end

function srr.CheckStock(fac,v)
    local source = source
    local user_id = vRP.getUserId(source)
    local value = vRP.getSData('EstoqueFarm:'..fac)
    local balance = value or 0
    local camount = v.quantity
    
    if not tonumber(balance) or tonumber(balance) == 0 then TriggerClientEvent("Notify", source, "negado","Sem Estoque") return end

    if vRP.hasPermission(user_id, v.permission) then
        if tonumber(balance) >= camount then
            vRP.setSData('EstoqueFarm:'..fac,(tonumber(balance)-camount))
            return true 
        end
    else
        TriggerClientEvent("Notify", source, "negado","Você Não Tem Permissão")
    end
end

function GetStock(fac)
    local source = source
    local value = vRP.getSData('EstoqueFarm:'..fac) or 0
    return value
end

function SetStock(fac,amount) 
    local source = source
    vRP.setSData('EstoqueFarm:'..fac,amount)
end

function srr.GiveItem(k,v)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, v.permission) then
        for s,r in pairs(Config.Domination[k].item) do
            vRP.giveInventoryItem(user_id,r.name,parseInt(v.quantity))
        end
    end
end

RegisterCommand('dominas',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local info = args[1]
    local type = args[2]
    local value = args[3]
    
    if not info then TriggerClientEvent("Notify", source, "negado","Coloque Um Argumento") return end

    if not vRP.hasPermission(user_id, Config.PermAdmin) then TriggerClientEvent("Notify", source, "negado","Você Não tem permissão") return end
        
        local message = "Tipos Disponiveis: "

        for k,v in pairs(Config.Domination) do
            message = message.. k..", "
        end
        
        if info == "stats" then    
            CheckStats(source)
        end

        if info == "info" then
            if type then
                if Config.Domination[type] then
                    TriggerClientEvent("Notify", source, "aviso","Estoque " ..type.. ": " ..GetStock(type))
                else 
                    TriggerClientEvent("Notify", source, "aviso",message)
                end
            end
        end
            
        if info == "add" then
            if type then
                if Config.Domination[type] then
                    if value then
                        if value ~= "" then
                        value = tonumber(parseInt(value))
                        if not value then return end
                        if value < 0 then value = 1 end

                        SetStock(type,value)
                        TriggerClientEvent("Notify", source, "sucesso","Adicionado Estoque "..type)
                        end
                    else 
                    TriggerClientEvent("Notify", source, "negado","Coloque a Quantidade")
                    end
                else 
                TriggerClientEvent("Notify", source, "aviso",message)
            end
            else 
            TriggerClientEvent("Notify", source, "aviso",message)
            end
        end
          
end)
