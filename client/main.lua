ESX = exports["es_extended"]:getSharedObject()

-- Variables declaration
local health
local multi
local pulse = 70
local area = "Unknown"
local blood = 100
local bleeding = 0
local dead = false
local timer = 0

local cPulse = -1
local cBlood = -1
local cNameF = ""
local cNameL = ""
local cArea = ""
local cBleeding = "NONE"

-- Helper function for debugging
local function debugLog(message)
    if Config.Debug then
        print("^0[^1DEBUG^0] ^5" .. message)
    end
end

-- Command to get player's pulse
RegisterCommand('getpulse', function(source, args)
	local health = GetEntityHealth(GetPlayerPed(-1))
	if health > 0 then
		pulse = (health / 4 + math.random(19, 28)) 
	end
	
	debugLog("Pulse: ^3" .. pulse .. "^5")
	local hit, bone = GetPedLastDamageBone(GetPlayerPed(-1))
	debugLog("Last damage bone: ^3" .. bone .. "^5")
end, false)

-- Event handler for player's death
AddEventHandler('esx:onPlayerDeath', function(data)
	multi = 2.0
	blood = 100
	health = GetEntityHealth(GetPlayerPed(-1))
	area = "LEGS/ARMS"
	local hit, bone = GetPedLastDamageBone(GetPlayerPed(-1))
	bleeding = 1
	if bone == 31086 then
		multi = 0.0
		debugLog('^1HEADSHOT^5')
		TriggerEvent('chatMessage', "hw_medsystem", {255, 0, 0}, "You have been shot/damaged in the HEAD area")
		bleeding = 5
		area = "HEAD"
	elseif bone == 24817 or bone == 24818 or bone == 10706 or bone == 24816 or bone == 11816 then
		multi = 1.0
		debugLog('^1BODYSHOT^5')
		TriggerEvent('chatMessage', "hw_medsystem", {255, 0, 0}, "You have been shot/damaged in the BODY area")
		bleeding = 2
		area = "BODY"
	end
	
	pulse = ((health / 4 + 20) * multi) + math.random(0, 4)
	dead = true
end)

-- Thread to handle player's health regeneration
Citizen.CreateThread(function()
	while true do
		Wait(5000)
		local hp = GetEntityHealth(GetPlayerPed(-1))
		if hp >= 1 and dead then
			dead = false
			bleeding = 0
			blood = 100
		end
		if dead and blood > 0 then
			blood = blood - bleeding
		end
	end
end)

-- Function to draw advanced text
function DrawAdvancedText(x, y, w, h, sc, text, r, g, b, a, font, jus)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 100)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - 0.1 + w, y - 0.02 + h)
end

-- Event handler for player proximity
RegisterNetEvent('hw_medsystem:near')
AddEventHandler('hw_medsystem:near', function(x, y, z, pulse, blood, nameF, nameL, area, bldn)
	local md = Config.Declared
	
	debugLog("^2Received ^5proximity event.")
	debugLog("Pulse: ^3" .. pulse .. "^5, Blood: ^3" .. blood .. "^5, Name: ^3" .. nameF .. " " .. nameL .. "^5, Area: ^3" .. area .. "^5, Bleeding: ^3" .. bldn .. "^5")
	
	if area == "HEAD" and blood <= 5 then
		cBlood = blood
		cPulse = pulse
		cNameF = nameF
		cNameL = nameL
		cArea = area
			
		ESX.ShowNotification(nameF .. ' ' .. nameL .. ' ' .. Config.Declared, true, true, 20)
		message = nameF .. ' ' .. nameL .. ' ' .. Config.Declared
	
		TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message ems"><b>Medical Center </b>: <b>' .. message .. '</b></div>',
            args = { -1, message }
        })
	end
	
	local a, b, c = GetEntityCoords(GetPlayerPed(-1))
	
	if GetDistanceBetweenCoords(x, y, z, a, b, c, false) < 10 then
		timer = Config.Timer
		cBlood = blood
		cPulse = pulse
		cNameF = nameF
		cNameL = nameL
		cArea = area
		
		if bldn == 1 then
			cBleeding = "SLOW"
		elseif bldn == 2 then
			cBleeding = "MEDIUM"
		elseif bldn == 5 then
			cBleeding = "FAST"
		elseif bldn == 0 then
			cBleeding = "NONE"
		end
	else
		timer = 0
		cBlood = -1
		cPulse = -1
		cNameF = ""
		cNameL = ""
		cArea = ""
		cBleeding = "SLOW"
	end
end)

-- Thread to display player's health information
Citizen.CreateThread(function()
	while true do
		Wait(1)
		while timer >= 1 do
			Wait(1)
			if cPulse ~= -1 and cBlood ~= -1 then
				DrawAdvancedText(0.7, 0.7, 0.005, 0.0028, 0.9, cNameF .. " " .. cNameL .. "\n~r~Pulse: ~w~" .. cPulse .. "BPM\n~r~Blood: ~w~" .. cBlood .. "%~r~\nHurt area: ~w~" .. cArea .. "\n~r~Bleeding: ~w~" .. cBleeding, 255, 255, 255, 255, 4, 1)
			end
		end
	end
end)

-- Timer thread
Citizen.CreateThread(function()
	while true do
		Wait(1000)
		if timer >= 1 then
			timer = timer - 1
		end	
	end
end)

-- Event handler for sending medical request
RegisterNetEvent('hw_medsystem:send')
AddEventHandler('hw_medsystem:send', function(req)
	local health = GetEntityHealth(GetPlayerPed(-1))
	if health > 0 then
		pulse = (health / 4 + math.random(19, 28)) 
	end
	local a, b, c = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	
	TriggerServerEvent('hw_medsystem:print', req, math.floor(pulse * (blood / 90)), area, blood, a, b, c, bleeding)
end)

----------------PART BELOW IS IN BETA, PLEASE DONT CHANGE STUFF HERE SINCE ITS NOT DONE YET--------------------

-- Function to calculate the ID of the nearest player
function GetNearestPlayerId()
    local players = GetActivePlayers()
    local closestPlayer = -1
    local closestDistance = 9999
    
    local sourcePed = GetPlayerPed(-1)
    local sourceCoords = GetEntityCoords(sourcePed)
    
    for _, playerId in ipairs(players) do
        if playerId ~= PlayerId() then
            local targetPed = GetPlayerPed(playerId)
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(targetCoords - sourceCoords)
            
            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = playerId
            end
        end
    end
    
    return closestPlayer
end

-- Export function to send medical requests
function SendMedicalRequest(requestType)
    if Config.IDmode == 'own' then
        local health = GetEntityHealth(GetPlayerPed(-1))
        if health > 0 then
            local pulse = (health / 4 + math.random(19, 28)) 
            local playerCoords = GetEntityCoords(GetPlayerPed(-1))
            
            TriggerServerEvent('hw_medsystem:print', requestType, math.floor(pulse * (blood / 90)), area, blood, playerCoords.x, playerCoords.y, playerCoords.z, bleeding)
			ESX.ShowNotification('~g~You have checked yourself.', -1)
		else
			print("^1Something went wrong! Please contact the script developer...")
			ESX.ShowNotification('~r~Something went wrong! Please contact the script developer...', -1)
		end
    elseif Config.IDmode == 'player' then
        local nearestPlayerId = GetNearestPlayerId()
        if nearestPlayerId ~= -1 then
            local health = GetEntityHealth(GetPlayerPed(nearestPlayerId))
            if health > 0 then
                local pulse = (health / 4 + math.random(19, 28)) 
                local playerCoords = GetEntityCoords(GetPlayerPed(nearestPlayerId))
                
                TriggerServerEvent('hw_medsystem:print', requestType, math.floor(pulse * (blood / 90)), area, blood, playerCoords.x, playerCoords.y, playerCoords.z, bleeding)
				ESX.ShowNotification('~g~You have checked nearby person.', -1)
            end
        else
            print("^1No players nearby.")
			ESX.ShowNotification('~r~No players nearby.', -1)
        end
    end
end


exports('SendMedicalRequest', SendMedicalRequest)