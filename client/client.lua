local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

srr = {}
Tunnel.bindInterface(GetCurrentResourceName(), srr)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())


CreateThread(function()
    while true do
        local sleep = 1000
        for k,v in pairs(Config.Domination) do  
            local ped = PlayerPedId()
            local distance = #(GetEntityCoords(ped) - vec3(v.x,v.y,v.z))
            if distance <= 4 and GlobalState.Dominas then
                sleep = 4
                DrawText3D(v.x,v.y,v.z,"Pressione [~r~ E ~w~] Para Coletar")
                if IsControlJustPressed(0,38) then
                    if vSERVER.CheckStock(k,v) then
                        FreezeEntityPosition(ped, true)
                        TriggerEvent('progress',8000,'PEGANDO')
                        TriggerEvent('cancelando',true)
                        vRP.playAnim(false, {{"anim@heists@ornate_bank@grab_cash", "grab"}}, true)
                        Wait(8000)
                        vSERVER.GiveItem(k,v)
                        vRP._stopAnim(false)
                        TriggerEvent('cancelando',false)
                        FreezeEntityPosition(ped, false)
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

function DrawText3D(x,y,z,text)
    SetDrawOrigin(x, y, z, 0);
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.35,0.35)
    SetTextColour(255,255,255,255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end