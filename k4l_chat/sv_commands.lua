RegisterCommand("ooc", function(player, args,rawCommand )
    local user_id = vRP.getUserId({player})
    if args[1] ~= nil then 
        TriggerClientEvent('chatMessage', -1, "[OOC]", { 83, 129, 196 }, "["..user_id.."] "..GetPlayerName(player)..": "..rawCommand:sub(5))
    else
        TriggerClientEvent('chatMessage', player, "^4Syntax: /ooc <message>")
    end
end)

RegisterCommand("advert", function(player, args,rawCommand )
    local user_id = vRP.getUserId({player})
    if args[1] ~= nil then 
        TriggerClientEvent('chatMessage', -1, "[ADVERT]", { 100,200,100 }, "["..user_id.."] "..GetPlayerName(player)..": "..rawCommand:sub(5))
    else
        TriggerClientEvent('chatMessage', player, "^4Syntax: /advert <message>")
    end
end)

--NOCLIP
RegisterCommand("noclip", function(player)
    local user_id = vRP.getUserId({player})
    if vRP.hasGroup({user_id,"adminroyale"}) or vRP.hasGroup({user_id,"superadminroyale"}) or vRP.hasGroup({user_id,"hosroyale"}) or vRP.hasGroup({user_id,"cofondatorroyale"}) or vRP.hasGroup({user_id,"devroyale"}) or vRP.hasGroup({user_id,"fondatorroyale"}) then
        vRPclient.toggleNoclip(player, {})
        --TriggerClientEvent("chatMessage", player, "^0Ti-ai activat ^4Noclip-ul ^0cu ^2Succes")
        
        local embed = {
                        {
                          ["color"] = 1234521,
                          ["title"] = "__".. "NOCLIP".."__",
                          ["description"] = "[ "..GetPlayerName(player).." ] ( "..user_id.." ) a folosit [ /noclip ]",
                          ["thumbnail"] = {
                            ["url"] = "https://i.imgur.com/Bi2iC6K.png",
                          },
                          ["footer"] = {
                          ["text"] = "",
                          },
                        }
  }
  PerformHttpRequest('DISCORD_WEBHOOK', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })

        
    else
        TriggerClientEvent("chatMessage", source, "^1Eroare^0: Nu ai acces la aceasta comanda sefule.")
    end
end)

--STATS
RegisterCommand('stats', function(source, args)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local banicash = vRP.getMoney1337({user_id})
    local nume = GetPlayerName(player)
    local banibanca = vRP.getBankMoney({user_id})
    local orejucate = vRP.getUserHoursPlayed({user_id})
    local aur = vRP.getAur({user_id})
    local giftbox = vRP.getPuncte({user_id})
    local locdemunca = vRP.getUserGroupByType({user_id,"job"})
    local warnuri = vRP.getUserWarns({user_id})
    local VIP = "Nu"
    if vRP.hasPermission({user_id,"vip1.masini"}) then
        VIP = "Da"
    else
        VIP = "Nu"
    end
    CancelEvent()
        TriggerClientEvent('chatMessage', player, "[STATS]", {255, 0, 0}, "=============== ^0NUME: ^2"..nume.."^0 ====== ^0ID: ^5"..user_id.."^0 ===============")
        TriggerClientEvent('chatMessage', player, "[STATS]", {255, 0, 0}, "^0Ai bani cash: ^2" ..banicash.." $^0 , Bani Banca: ^2"..banibanca.."^0, Gifbotxuri: ^8"..giftbox.."^0, Warn : ^5"..warnuri)
        TriggerClientEvent('chatMessage', player, "[STATS]", {255, 0, 0}, "^0Lucrezi ca si^6: "..locdemunca.."^0, VIP: ^3"..VIP.."^0, Ore jucate: ^5"..orejucate.."^0, Aur: ^3"..aur)
        TriggerClientEvent('chatMessage', player, "[STATS]", {255, 0, 0}, "========================================================")
end)

--TP
RegisterCommand("tp", function(player, args)
    local user_id = vRP.getUserId({player})
    if(vRP.hasPermission({user_id,"admin.tickets"})) then -- permisiunea ``admin.tickets``
        vRP.prompt({player,"Unde vrei sa mergi:","[1] - Showroom , [2] - Primarie",function(player,numar)
            if numar ~= nil and numar == "1" then 
                vRPclient.teleport(player,{COORDONATE})
            end
            if numar ~= nil and numar == "2" then 
                vRPclient.teleport(player,{COORDONATE})
            end
        end})
    else
        vRPclient.notify(player,{"Nu ai introdus numarul corect"})
    end
end)

--CLEAR
RegisterCommand('clear', function(source)
    local user_id = vRP.getUserId({source});
    if user_id ~= nil then
         if vRP.hasPermission({user_id, "admin.spawnveh"}) then
            TriggerClientEvent("chat:clear", -1);
            TriggerClientEvent("chatMessage", -1, "^1Server^7: Adminul ^1".. GetPlayerName(source) .."^7 a sters tot chat-ul.");
        else
            TriggerClientEvent("chatMessage", source, "^1Eroare^7: nu ai acces la aceasta comanda.");
        end
    end
end)

--AREVIVE
RegisterCommand('arevive', function(source, args, msg)
    local user_id = vRP.getUserId({source})
    msg = msg:sub(9)
    if msg:len() >= 1 then
      msg = tonumber(msg)
      local target = vRP.getUserSource({msg})
      if target ~= nil then
        if vRP.hasPermission({user_id, "admin.tickets"}) then 
          vRPclient.varyHealth(target,{100})

--SAY [CONSOLA]
  RegisterCommand('say', function(source, args, rawCommand)
      if(source == 0)then
          TriggerClientEvent('chatMessage', -1, "[Consola]", { 255, 0, 0 }, rawCommand:sub(5))
      end
  end)

--/ME
  RegisterCommand('me', function(source, args)
      local text = "* " .. table.concat(args, " ") .. " *"
      TriggerClientEvent('3dme:shareDisplay', -1, text, source)
  end)

--RESPAWN
RegisterCommand("respawn", function(player, args)
    local user_id = vRP.getUserId({player})
          if vRP.isUserTrialHelper({user_id}) then
        local target_id = parseInt(args[1])
        local target_src = vRP.getUserSource({target_id})
        if target_src then
            vRPclient.teleport(target_src, {-1281.1693115234,303.02801513672,64.969093322754})
            --TriggerClientEvent("chatMessage", target_src, "^1Info^7: Respawned by admin")
            TriggerClientEvent("chatMessage", player, "^0[^1SYSTEM^0] ^0Admin-ul ^4"..GetPlayerName(player).." ^0i-a dat respawn lui ^4"..GetPlayerName(target_src))
        else
            TriggerClientEvent("chatMessage", player, "^1Syntax^7: /respawn <user_id>")
        end
    else
        TriggerClientEvent("chatMessage", player, "^1Eroare^7: Nu ai acces la aceasta comanda")
    end
end, false)

--ARME
RegisterCommand('arme', function(source)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if vRP.isUserFondator({user_id}) then --- Aici in caz ca vrei sa fie pe un anumit grad
      vRPclient.giveWeapons(player,{{
              ["WEAPON_COMBATPISTOL"] = {ammo=100},
              ["WEAPON_ASSAULTSMG"] = {ammo=200},
              ["WEAPON_MACHETE"] = {ammo=1},
              ["WEAPON_SPECIALCARBINE"] = {ammo=200},
              ["WEAPON_PUMPSHOTGUN"] = {ammo=100},
              ["WEAPON_MG"] = {ammo=100}
          }})
      vRPclient.notify(player, {"Ti-ai dat arme muistule."})
    else 
      vRPclient.notify(player, {"~r~Nu ai acces la aceasta comanda"})
    end     
end)

--AA2
RegisterCommand("aa2",function( source )
    if vRP.isUserTrialHelper({vRP.getUserId({source})}) then
        vRPclient.teleport(source,{131.43910217285,-641.16229248047,262.85186767578})
    end
end)

--REVIVE ALL
RegisterCommand("reviveall", function(player)
    local user_id = vRP.getUserId({player})
    if(vRP.isUserHelper({user_id})) then
        local users = vRP.getUsers({})
        for k, v in pairs(users) do 
            Citizen.Wait(10)
            if v then
                vRPclient.varyHealth(v, {100})
                SetTimeout(500, function()
                    vRPclient.varyHealth(v, {100})
                end)
            end
        end
        TriggerClientEvent("chatMessage", -1, "^1Revive-All^0: Adminul ^1"..GetPlayerName(player).." ^0a dat revive la tot server-ul")
    else
        vRPclient.noAccess(player, {})
    end
end)

--FIX
RegisterCommand('fix', function(source, args, msg)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    CancelEvent()
    if vRP.isUserHelper({user_id}) then
   -- TriggerClientEvent("InteractSound_CL:PlayOnOne", player, "bonusu", 0.10)
        TriggerClientEvent('murtaza:fix', player);
        
        local embed = {
                        {
                          ["color"] = 1234521,
                          ["title"] = "__".. "FIX VEH".."__",
                          ["description"] = "[ "..GetPlayerName(source).." ] ( "..user_id.." ) a folosit comanda [ /fix ] ",
                          ["thumbnail"] = {
                            ["url"] = "https://i.imgur.com/Bi2iC6K.png",
                          },
                          ["footer"] = {
                          ["text"] = "",
                          },
                        }
  }
  PerformHttpRequest('https://discord.com/api/webhooks/811577938536693770/ALyVZcIVXsJvDWgzLrBENtbHa9WEYWeRlB67YVym57f-JAvHLF37RXUOdAZvDhRl35nS', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })

        
    else
        TriggerClientEvent("chatMessage", source, "Nu ai acces la aceasta comanda sefule.")
    end
end)

--TPW
RegisterCommand("tpw", function(player)
    local user_id = vRP.getUserId({player})
    if vRP.isUserMod({user_id}) then
      TriggerClientEvent("TpToWaypoint", player) 
    else
      TriggerClientEvent("chatMessage", player, "^1Eroare^0: Nu ai acces la aceasta comanda !")
    end
  end, false)

--COORDS
  RegisterCommand('coords', function(source, args, rawCommand)
    local user_id = vRP.getUserId({source})
    local msg = rawCommand:sub(4)
    if user_id ~= nil and vRP.hasPermission({user_id,perm}) then
        vRPclient.getPosition(source,{},function(x,y,z)
            vRP.prompt({source,"Pentru a copia coordonatele apasa: Ctrl-A - Ctrl-C",x..","..y..","..z,function(source,choice) end})
        end)
    end
end)

--RESTART
RegisterCommand("restartsv", function(player)
    for k, v in pairs(vRP.getUsers({})) do
        vRP.kick({vRP.getUserSource({v}),"Server-ul v-a primi restart \nTe asteptam si pe discord sa vezi ce am bagat <3 \ndiscord.io/navyrp"})
    end
 end)

 -- MUTE
 RegisterCommand('mute', function(source, args, rawCommand)
 local user_id = vRP.getUserId({source})
 local guy = vRP.getUserSource({tonumber(args[1])})
 if user_id ~= nil then
     if(args[1] == nil)then
         TriggerClientEvent('chatMessage', source, "/"..rawCommand.." (id) (minute)") 
     else
         if vRP.hasPermission({user_id, "admin.tickets"}) then
             if guy ~= nil then
                 if mute[tonumber(args[1])] == 1 then
                        mute[tonumber(args[1])] = 0
                        TriggerClientEvent('chatMessage', -1, "^9[Navy] ^0Jucatorul ^3"..vRP.getPlayerName({vRP.getUserSource({tonumber(args[1])})}).."^0 a primit unmute de la ^3"..vRP.getPlayerName({source}))
                 else
                     if args[2] ~= nil then
                         timpmute[tonumber(args[1])] = tonumber(args[2])*60000
                         mute[tonumber(args[1])] = 1
                         TriggerClientEvent('chatMessage', -1, "^9[Navy] ^0Jucatorul ^3"..vRP.getPlayerName({vRP.getUserSource({tonumber(args[1])})}).."^0 a primit mute de la ^3"..vRP.getPlayerName({source}).."^0, timp de ^3"..tonumber(args[2]).." ^0(de) minut(e).")
                         daicumute(tonumber(args[1]))
                     end
                 end
             else
                 vRPclient.notify(source,{"~r~Jucatorul nu este pe server!"})
             end
         else
             vRPclient.notify(source,{"~r~Nu ai acces!"})
         end
     end
 end
end)

--BAN [CONSOLA]
RegisterCommand("ban", function(source,args,rawCommand)
    if source == 0 then
        local id = args[1]
        id = parseInt(id)
        local reason = ""
        for i=1,10,1 do 
            if args[i]~= nil then
                reason = reason.." "..args[i]
            end
        end
        local tsource = vRP.getUserSource({id})
        vRP.ban({tsource,reason,"Consola"})
        print("Banat cu succes")
    else
        print("Ba nene intelege si nu mai incerca din chat :)")
    end
end)

--UNABN [CONSOLA]
if source == 0 then
    local id = args[1]
    id = parseInt(id)
    vRP.setBanned({id,false})
    print("Unban cu succes")
else
    print("Ba nene intelege si nu mai incerca din chat :)")
end
end)

--QUIT JOB
RegisterCommand("quitjob", function(source, args, rawCommand)
    theusrid = vRP.getUserId({source})
    vRP.addUserGroup({theusrid,"Somer"})
    vRP.removeUserGroup({theusrid,"grad de scos"})
    vRPclient.notify(source,{"~g~Ti-ai dat demisia cu succes! ~y~Credite: Endora"})
    end)

--STOP CHAT
RegisterCommand('stopchat', function(source)
    local user_id = vRP.getUserId({source})
    if user_id ~= nil or source == 0 then
    if vRP.hasGroup({user_id, "Fondator Rage"}) or vRP.hasGroup({user_id, "Co-Fondator Rage"}) or vRP.hasGroup({user_id, "Supervizor Staff Rage"}) or vRP.hasGroup({user_id, "Lider Admin Rage"})then
        TriggerClientEvent("chat:clear", -1);
        if pornit then
            local stuff = "^1[Rage] ^0Chat-ul a fost oprit de catre : ^1"..GetPlayerName(source).."^0"
            TriggerEvent('alex:mesagefrumoase', stuff,"rosu",-1,false)
            pornit = false
        else
            local stuff = "^1[Rage] ^0Chat-ul a fost pornit de catre : ^1"..GetPlayerName(source).."^0"
            TriggerEvent('alex:mesagefrumoase', stuff,"rosu",-1,false)
            pornit = true
        end
    end
end
end)

--TUNNING
RegisterCommand("tunning", function(source)
    local user_id = vRP.getUserId({source})
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed)
    if hasGroup({user_id, "admin.tickets"}) then
        
    elseif IsPedInAnyVehicle(playerPed) then
            SetVehicleEngineHealth(vehicle, 9999)
            GetVehicleBodyHealth(vehicle, 9999)
            GetVehicleFuelLevel(vehicle, 9999)
            GetVehicleTopSpeedModifier(vehicle, 9999)
            GetVehicleHandbrake(vehicle, 9999)
            SetVehicleTurboPressure(vehicle, 9999)
            SetVehiclePetrolTankHealth(vehicle, 9999)
            SetVehicleFixed(vehicle)
    end
end)

--GIVE ALL MONEY
RegisterCommand("giveallmoney", function(player, args)
if player == 0 then
    local theMoney = parseInt(args[1]) or 0
    if theMoney >= 1 then
        giveAllBankMoney(theMoney)
        TriggerClientEvent("chatMessage", -1, "^1Info^7: Server-ul a oferit tuturor jucatorilor ^2$"..theMoney.."^7 !")
    else
        print("/giveallmoney <amount>")
    end
else
    local user_id = vRP.getUserId({player})
      if vRP.hasPermission({user_id, "player.giveallmoney"}) then
        local theMoney = parseInt(args[1]) or 0
        if theMoney then
            giveAllBankMoney(theMoney)
            TriggerClientEvent("chatMessage", -1, "^1Info^7: ^2"..vRP.getPlayerName({player}).."^7 a oferit tuturor jucatorilor ^2$"..theMoney.."^7 !")
        else
            TriggerClientEvent("chatMessage", player, "^1Syntax^7: /giveallmoney <amount>")
        end
    else
        TriggerClientEvent("chatMessage", player, "^1Eroare^7: Nu ai acces la aceasta comanda")
    end
end
end, false)

--AREVIVEAREA
RegisterCommand("arevivearea", function(source,args)
    local user_id = vRP.getUserId({source})
    local src = vRP.getUserSource({user_id})
    local radius = args[1]
radius = radius or 5
    local name = GetPlayerName(src)
    if vRP.isUserTrialHelper({user_id}) then 
            vRPclient.getNearestPlayers(src,{tonumber(radius)}, function(nplayers)
                for k,v in pairs(nplayers) do 
                    vRPclient.varyHealth(k,{100})
                    vRPclient.notify(k,{"Ai primit revive de la adminul ~b~" .. name})
                end
            end)
            TriggerClientEvent("chatMessage",-1,"Adminul " .. name ..  " a dat revive pe o raza de " .. radius .. " metri")
        else
        vRPclient.notify(src,{"~r~Nu ai acces la aceasta comanda!"})
    end
end)

--GIVE CAR GHMATTI
RegisterCommand('givecar', function (source, args)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if vRP.hasGroup({user_id, "VLNO Fondator"})  then
        local target_id = parseInt(args[1])
            if target_id ~= nil then
                local target_src = vRP.getUserSource({target_id})

                local model = tostring(args[2])
                if model ~= nil then
					local plate = tostring(args[3])
					if plate ~= nil then
                        local veh_type = tostring(args[4])
                        if veh_type ~= nil then
                    exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,upgrades,vehicle_plate,veh_type) VALUES(@user_id,@vehicle,@upgrades,@vehicle_plate,@veh_type)", {
                        ['@user_id'] = target_id,
                        ['@vehicle'] = model,
                        ['@upgrades'] = json.encode(""),
						['@vehicle_plate'] = plate,
                        ['@veh_type'] = veh_type,

                        --['@vehicle_plate'] = "P "..identity.registration
                    }, function (rows) end)
                    
					TriggerClientEvent('mythic_notify:client:SendAlert', target_src, { type = 'inform', text = 'Ai primit o masina de tip ' .. model .. " de la [ " ..target_id .. " ] : " .. GetPlayerName(player), style = { ['background-color'] = '#B533FF', ['color'] = '#FFFFFF' }, duration = 20000 })
                    TriggerClientEvent('mythic_notify:client:SendAlert', player, { type = 'inform', text = 'I-ai dat masina de tip  '..model..' la jucatorul ' ..target_id .. ' !'  , style = { ['background-color'] = '#B533FF', ['color'] = '#FFFFFF' }, duration = 20000 })
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', player, { type = 'inform', text = 'Nu ai introdus un tip de masina', style = { ['background-color'] = '#FFAAAA', ['color'] = '#FFFFFF' }, duration = 20000 })
                end
                else
                    elseTriggerClientEvent('mythic_notify:client:SendAlert', target_src, { type = 'inform', text = 'Nu ai introdus un nr de inmatriculare corect', style = { ['background-color'] = '#FFAAAA', ['color'] = '#FFFFFF' }, duration = 20000 })
                end
            else
					TriggerClientEvent('mythic_notify:client:SendAlert', player, { type = 'inform', text = 'Nu ai introdus masina!', style = { ['background-color'] = '#FFAAAA', ['color'] = '#FFFFFF' }, duration = 20000 })
                end
            else
				TriggerClientEvent('mythic_notify:client:SendAlert', player, { type = 'inform', text = 'Nu ai introdus ID-ul!', style = { ['background-color'] = '#FFAAAA', ['color'] = '#FFFFFF' }, duration = 20000 })
            end
    else
		TriggerClientEvent('mythic_notify:client:SendAlert', player, { type = 'inform', text = 'Nu ai access la aceasta comanda!', style = { ['background-color'] = '#FFAAAA', ['color'] = '#FFFFFF' }, duration = 20000 })
    end
end)

--CLEANUP
RegisterCommand("cleanup", function(player, args)
    if player == 0 then
        local theSecs = parseInt(args[1]) or 10
        TriggerClientEvent("delAllVehs", -1, theSecs)
    else
        local user_id = vRP.getUserId({player})
        if vRP.isUserAdmin({user_id}) then
            local sec = parseInt(args[1]) or 10
            if sec >= 0 then
                  TriggerClientEvent('chatMessage', -1, "^1Info: ^7 Toate masinile neocupate au fost sterse !")
                TriggerClientEvent("delAllVehs", -1, sec)
            end
        end
    end
end, false)

--IA ARMELE
RegisterCommand("clearweapons", function(source,args)
    local user_id = vRP.getUserId({source})
    local target_id = parseInt(args[1])
    local target_src = vRP.getUserSource({target_id})
    if  vRP.hasPermission({user_id, "admin.clearweapons"}) then 
        RemoveAllPedWeapons(target_src, true)
        vRPclient.notify(target_src,{"Armele ti-au fost confiscate de catre un administrator"})
        TriggerClientEvent("ples:sendChat", -1, "^1[CWEAPONS]:^0 Adminul ^1"..GetPlayerName(source).."("..user_id..") ^0i-a confiscat armele lui ^1"..vRP.getPlayerName({target_src}).."("..target_id..")", "")
    end
end) 

--SEX
RegisterCommand("sex", function()
    local ped = tempPed
    local veh = GetVehiclePedIsIn(ped, false)
    if IsEntityAVehicle(veh) then
        if GetEntitySpeed(veh) < 1 then
            local sofer = GetPedInVehicleSeat(veh, -1)
            if GetPedInVehicleSeat(veh, 0) == ped then
                if sofer ~= nil and sofer ~= 0 then
                    local done = false
                    Citizen.CreateThread(function()
                        Citizen.Wait(10000)
                        done = true
                    end)
                    while not done do
                        TriggerServerEvent("mihaila:SyncAnimServer", NetworkGetNetworkIdFromEntity(sofer), "mini@prostitutes@sexlow_veh", "low_car_sex_loop_player")
                        TriggerServerEvent("mihaila:SyncAnimServer", NetworkGetNetworkIdFromEntity(ped), "mini@prostitutes@sexlow_veh", "low_car_sex_loop_female")
                        Citizen.Wait(2000)
                    end
                    Citizen.Wait(1000)
                    TriggerServerEvent("mihaila:SyncAnimServer", NetworkGetNetworkIdFromEntity(sofer), "stopAnim", "stopAnim")
                    TriggerServerEvent("mihaila:SyncAnimServer", NetworkGetNetworkIdFromEntity(ped), "stopAnim", "stopAnim")
                else
                    TriggerEvent("chatMessage", "^1Eroare^7: Nu ai cu cine sa faci sex")
                end
            else
                TriggerEvent("chatMessage", "^1Eroare^7: Trebuie sa stai in dreapta soferului pentru a face sex")
            end
        else
            TriggerEvent("chatMessage", "^1Eroare^7: Trebuie ca masina sa stea pe loc pentru a face sex")
        end
    else
        TriggerEvent("chatMessage", "^1Eroare^7: Trebuie sa fii intr-o masina pentru a face sex")
    end
end)


--BY KORRUPT4LIFE PWP