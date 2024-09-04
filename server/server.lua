--local QBCore = exports['qb-core']:GetCoreObject()
local ESX = exports['es_extended']:getSharedObject()

--[[RegisterNetEvent('QBCore:Server:UpdateObject', function()
	if source ~= '' then return false end
	QBCore = exports['qb-core']:GetCoreObject() 
end)]]--

RegisterNetEvent("bl-realtor:server:updateProperty", function(type, property_id, data)
    -- Job check
    local src = source
    --[[local Player = QBCore.Functions.GetPlayer(src)
    local PlayerData = Player.PlayerData]]--
    local Player = ESX.GetPlayerFromId(src)
    
    if not RealtorJobs[Player.getJob().name] then return false end

    data.realtorSrc = src
    -- Update property
    TriggerEvent("ps-housing:server:updateProperty", type, property_id, data)
end)

RegisterNetEvent("bl-realtor:server:registerProperty", function(data)
    -- Job check
    local src = source
    --[[local Player = QBCore.Functions.GetPlayer(src)
    local PlayerData = Player.PlayerData]]--
    local Player = ESX.GetPlayerFromId(src)
    
    if not RealtorJobs[Player.getJob().name] then return false end

    data.realtorSrc = src
    return exports['ps-housing']:registerProperty(data, nil, src)
end)

RegisterNetEvent("bl-realtor:server:addTenantToApartment", function(data)
    -- Job check
    local src = source
    --[[local Player = QBCore.Functions.GetPlayer(src)
    local PlayerData = Player.PlayerData]]--
    local Player = ESX.GetPlayerFromId(src)
    
    if not RealtorJobs[Player.getJob().name] then return false end

    data.realtorSrc = src
    -- Add tenant
    TriggerEvent("ps-housing:server:addTenantToApartment", data)
end)

lib.callback.register("bl-realtor:server:getNames", function (source, data)
    local src = source
    --[[local Player = QBCore.Functions.GetPlayer(src)
    local PlayerData = Player.PlayerData]]--
    local Player = ESX.GetPlayerFromId(src)
    
    if not RealtorJobs[Player.getJob().name] then return false end
    
    local names = {}
    for i = 1, #data do
        local target = ESX.GetPlayerFromIdentifier(data[i])
        local name = ""

        if not target then
            target = exports['ps-housing']:getESXOfflinePlayer(data[i])
            name = target.firstName .. " " .. target.lastName
        else
            name = target.getName()
        end

        if target then
            names[#names+1] = name
        else
            names[#names+1] = "Unknown"
        end
    end
    
    return names
end)

if Config.UseItem then
    --[[QBCore.Functions.CreateUseableItem(Config.ItemName, function(source, item)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.Functions.GetItemByName(item.name) ~= nil then
            TriggerClientEvent("bl-realtor:client:toggleUI", src)
        end
    end)]]--
end
