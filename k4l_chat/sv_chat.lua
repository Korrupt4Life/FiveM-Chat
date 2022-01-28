--Server Chat Fivem ESX tradus in VRP de catre Korrupt4Life
--Pentru support in plus nu ezita sa ma contactezi: 👑| 𝑲𝒐𝒓𝒓𝒖𝒑𝒕4𝑳𝒊𝒇𝒆 |👑#9999
--Pentru scripturi unice si la comanda poti da un mesaj aici: 👑| 𝑲𝒐𝒓𝒓𝒖𝒑𝒕4𝑳𝒊𝒇𝒆 |👑#9999 | https://discord.gg/mZ7Uu4z4sG


local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","chat")

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('_chat:messageEnteredSTAFF')
RegisterServerEvent('_chat:messageEnteredM')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')



AddEventHandler('_chat:messageEntered', function(author, color, message)
    local user_id = vRP.getUserId({source})
    if not message or not author then
        return
    end

    --TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
        if vRP.hasGroup({user_id,"prisonier"}) then

            for k,v in pairs (vRP.getUsers({})) do
                if vRP.hasGroup({ vRP.getUserId({v}), "prisonier" }) then 
                    TriggerClientEvent('chatMessage', source, "(( [PRISONIER-CHAT] [".. user_id .."] " .. author .. ": " ..  message.." ))")
                end
            end

        else
            --De aici pana  *   
            if vRP.isUserFondator({user_id}) then
                TriggerClientEvent('chatMessage', -1, "[Fondator] [".. user_id .."] " .. author .. ": " ..  message, source)
            
            --*Aici pui doar gradele staff, gradele de factiuni nu le pui ca le ia baza de date automat

            --Subiect: Job | De aici pana **

            elseif vRP.hasGroup({user_id,"user"}) then
                TriggerClientEvent('chatMessage', -1, "[Civil] [".. user_id .."] " .. author .. ": " ..  message, source)
            
            -- **aici pui la fel ca la user grupele de job-uri | !!!!!!nu sterge "user" pentru ca nu va mai merge chat=ul | COMENZILE DE CHAT NU SE PUN TOT IN ACEST FISIER SE VOR PUNE IN SV_COMMANDS
            end

        end

        if string.len(message) >= 200 then
            DropPlayer(source, 'Ai primit kick pentru spam-chat')
        end
    end

    if user_id ~= nil then
        print("^2[CHAT]^7 "..author .. '[ID:'..user_id..'][SID:'..vRP.getUserSource({user_id})..'] : ' .. message .. '')
    else
        user_id = "NIL"
        print("^1[CHAT]^7 "..author .. '[ID'..user_id..'][SID:'..source..'] : ' .. message .. '')
    end

end)

AddEventHandler('_chat:messageEnteredSTAFF', function(author, color, message)
    local user_id = vRP.getUserId({source})
    
    if vRP.isUserTrialHelper({user_id}) then 
        if not message or not author then
            return
        end
    
        TriggerEvent('chatMessageSTAFF', source, author, message)
    
        if not WasEventCanceled() then
            for k,v in pairs (vRP.getUsers({})) do
                if vRP.isUserTrialHelper({vRP.getUserId({v})}) then 
                    TriggerClientEvent('chatMessageSTAFF', v,"["..vRP.getUserAdminTitle({user_id}).."]",{100,200,100},  "[".. user_id .."]".. author .. ": " ..  message) 
                end
            end
        end
    
        if user_id ~= nil then
            print("^2[STAFF-CHAT]^7 "..author .. '[ID:'..user_id..'][SID:'..vRP.getUserSource({user_id})..'] : ' .. message .. '')
        else
            user_id = "NIL"
            print("^1[STAFF-CHAT]^7 "..author .. '[ID'..user_id..'][SID:'..source..'] : ' .. message .. '')
        end
    else 
        TriggerClientEvent('chat:addMessageSTAFF', source, { args = { '^1SYSTEM', 'Nu ai permisiunea pe acest canal!' } })
    end
end)

AddEventHandler('_chat:messageEnteredM', function(author, color, message)
    local user_id = vRP.getUserId({source})
    local faction = vRP.hasUserFaction({user_id})
    
    if faction then
        local factionName = vRP.getUserFaction({user_id})
        local factionRank = vRP.getFactionRank({user_id})

        if not message or not author then
            return
        end

        TriggerEvent('chatMessageM', source, author, message)

        if not WasEventCanceled() then
            for k,v in pairs (vRP.getUsers({})) do
                if vRP.getUserFaction({vRP.getUserId({v})}) == factionName then 
                    TriggerClientEvent('chatMessageM', v ,"["..factionRank.."]",{100,200,100},  "[".. user_id .."]".. author .. ": " ..  message) 
                end
            end
        end

        if user_id ~= nil then
            print("^2[FACTION-CHAT]^7 "..author .. '[ID:'..user_id..'][SID:'..vRP.getUserSource({user_id})..'] : ' .. message .. '')
        else
            user_id = "NIL"
            print("^1[FACTION-CHAT]^7 "..author .. '[ID'..user_id..'][SID:'..source..'] : ' .. message .. '')
        end
    else
        TriggerClientEvent('chat:addMessageM', source, { args = { '^1SYSTEM', 'Nu ai permisiunea pe acest canal!' } })
    end
end)

AddEventHandler('_chat:messageEnteredADVERTISMENTS', function(author, color, message)
    local user_id = vRP.getUserId({source})
    
    if not message or not author then
        return
    end

    TriggerEvent('chatMessageADVERTISMENTS', source, author, message)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessageADVERTISMENTS', -1, "[ADVERTISMENT] [".. user_id .."] " .. author .. ": " ..  message.."\nPHONE: 123121-2121")
    end

    if user_id ~= nil then
        print("^2[ADVERTISMENTS-CHAT]^7 "..author .. '[ID:'..user_id..'][SID:'..vRP.getUserSource({user_id})..'] : ' .. message .. '')
    else
        user_id = "NIL"
        print("^1[ADVERTISMENTS-CHAT]^7 "..author .. '[ID'..user_id..'][SID:'..source..'] : ' .. message .. '')
    end

end)

AddEventHandler('_chat:messageEnteredTWEETS', function(author, color, message)
    local user_id = vRP.getUserId({source})
    
    if not message or not author then
        return
    end

    TriggerEvent('chatMessageTWEETS', source, author, message)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessageTWEETS', -1, "[TWEETS] [".. user_id .."] " .. author .. ": " ..  message)
    end

    if user_id ~= nil then
        print("^2[TWEETS-CHAT]^7 "..author .. '[ID:'..user_id..'][SID:'..vRP.getUserSource({user_id})..'] : ' .. message .. '')
    else
        user_id = "NIL"
        print("^1[TWEETS-CHAT]^7 "..author .. '[ID'..user_id..'][SID:'..source..'] : ' .. message .. '')
    end

end)

AddEventHandler('_chat:messageEnteredOOC', function(author, color, message)
    local user_id = vRP.getUserId({source})
    
    if not message or not author then
        return
    end

    TriggerEvent('chatMessageOOC', source, author, message)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessageOOC', -1, "[OOC] [".. user_id .."] " .. author .. ": " ..  message)
    end

    if user_id ~= nil then
        print("^2[OOC-CHAT]^7 "..author .. '[ID:'..user_id..'][SID:'..vRP.getUserSource({user_id})..'] : ' .. message .. '')
    else
        user_id = "NIL"
        print("^1[OOC-CHAT]^7 "..author .. '[ID'..user_id..'][SID:'..source..'] : ' .. message .. '')
    end

end)


AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)
    if not WasEventCanceled() then
        vRPclient.notify(source,{"~r~[ERROR]~w~ Comanda /~b~"..command.."~w~ nu exista!"})
    end

    CancelEvent()
end)
