local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

srr = {}
Tunnel.bindInterface("srr_domination", srr)
vSERVER = Tunnel.getInterface("srr_domination")


CreateThread(function()
    while true do
        local sleep = 1000
        for k,v in pairs(Config.Domination) do  
            local ped = PlayerPedId()
            local distance = #(GetEntityCoords(ped) - vec3(v.x,v.y,v.z))
            if distance <= 4 and GlobalState.Dominas then
                sleep = 4
                DrawText3D(v.x,v.y,v.z,"Pressione [~r~E~w~] Para Coletar")
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

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end