ESX = exports["es_extended"]:getSharedObject()

-- Helper function for debugging
local function debugLog(message)
    if Config.Debug then
        print("^0[^1DEBUG^0] ^5" .. message)
    end
end

-- Main log function for sending discord logs
local function sendLog(playerIdentifier, message)
    if Config.Webhook == "" then return end
    
    local embeds = {
        {
            title = "🚨 Med System Alert",
            description = message,
            type = "rich",
            color = 0xFF0000,
            footer = {
                text = "Amsterdam Roleplay | Log"
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }

    PerformHttpRequest(Config.Webhook, function() end, 'POST', json.encode({username = "/Med Logs", embeds = embeds}), {['Content-Type'] = 'application/json'})
end

-- Main print function to show floating text with current state of person
RegisterServerEvent('hw_medsystem:print')
AddEventHandler('hw_medsystem:print', function(req, pulse, area, blood, x, y, z, bleeding)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    debugLog("^2Printing ^5medical system data.^5")
    debugLog("Source player ID: ^3" .. _source .. "^5")
    Wait(100)
    local name = getIdentity(_source)
    debugLog("Source player identity: ^3" .. name.firstname .. " " .. name.lastname .. "^5")
    local message = string.format("**Player**: %s %s, **Pulse**: %s, **Area**: %s, **Blood**: %s, **Bleeding**: %s, **Location**: `%s, %s, %s`",
        name.firstname, name.lastname, pulse, area, blood, bleeding, x, y, z)
    debugLog("^5Message for logging: ^3" .. message .. "^5")

    sendLog(_source, message)

    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers do
        TriggerClientEvent('hw_medsystem:near', xPlayers[i], x, y, z, pulse, blood, name.firstname, name.lastname, area, bleeding)
    end
end)

-- Main command function for player with permission to use
RegisterCommand('med', function(source, args)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    for k,v in pairs(Config.jobs) do
        if v[xPlayer.job.name] then
            if args[1] ~= nil then
                debugLog("Med command ^3triggered.^5")
                debugLog("Source player ID: ^3" .. _source .. "^5")
                local message = string.format("/med is triggered - **Player**: %s, **Target**: %s", _source, args[1])
                debugLog("Med command message: ^3" .. message .. "^5")
                sendLog(_source, message)
                TriggerClientEvent('hw_medsystem:send', args[1], source)
            else
                debugLog("^1Incorrect ^5player ID received.")
                TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
            end
        else
            debugLog("Player job ^1not ^5whitelisted.")
            xPlayer.showNotification('Your job is not Whitelisted!', true , true, 30)
            local message = string.format("/med is **triggered** by player (id): `%s`. - The person is not authorized to use this command!", _source, args[1])
            debugLog("^1Unauthorized ^5med command message: ^3" .. message .. "^5")
            sendLog(_source, message)
        end
    end
end, false)

-- Main identity function to check for player ID
function getIdentity(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier})
    
    if result[1] then
        local identity = result[1]
        debugLog("Identity ^2found ^5for source player ID: ^3" .. source .. "^5")
        return {
            identifier = identity.identifier,
            firstname = identity.firstname,
            lastname = identity.lastname
        }
    else
        debugLog("Identity ^1not ^5found for source player ID: ^3" .. source .. "^5")
        return nil
    end
end