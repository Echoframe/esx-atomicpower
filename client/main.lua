Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local playerPed = PlayerPedId()
local isCleaning = false
local isPickingUp = false
local isProcessing = false
local isUnboxing = false
local isPressing = false
local isSelling = false 

local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) 
        ESX = obj end)
      Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) ESX.PlayerData = xPlayer end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) ESX.PlayerData.job = job end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        --if PlayerData.job ~= nil and PlayerData.job.name == 'atomic' then

        if GetDistanceBetweenCoords(getPlayerPos(), Config.Zones.quarryLocation.coords, true) < Config.DrawDistance then
            drawMarkers(Config.Zones.quarryLocation.coords)
        --elseif
        --GetDistanceBetweenCoords(getPlayerPos(), Config.Zones.changingRoom.coords, true) < Config.DrawDistance then
            --drawMarkers(Config.Zones.changingRoom.coords)
        elseif
        GetDistanceBetweenCoords(getPlayerPos(), Config.Zones.placeBox.coords, true) < Config.DrawDistance then
            drawMarkers(Config.Zones.placeBox.coords)
        elseif
        GetDistanceBetweenCoords(getPlayerPos(), Config.Zones.cleanUranium.coords, true) < Config.DrawDistance then
            drawMarkers(Config.Zones.quarryLocation.coords)
        elseif
        GetDistanceBetweenCoords(getPlayerPos(), Config.Zones.processUranium.coords, true) < Config.DrawDistance then
            drawMarkers(Config.Zones.cleanUranium.coords)
        elseif
        GetDistanceBetweenCoords(getPlayerPos(), Config.Zones.liftTPLevel1.coords, true) < Config.DrawDistance then
            drawMarkers(Config.Zones.liftTPLevel1.coords)
        elseif
        GetDistanceBetweenCoords(getPlayerPos(), Config.Zones.liftTPLevel2.coords, true) < Config.DrawDistance then
            drawMarkers(Config.Zones.liftTPLevel2.coords)
        elseif
        GetDistanceBetweenCoords(getPlayerPos(), Config.Zones.sellUranium.coords, true) < Config.DrawDistance then
            drawMarkers(Config.Zones.sellUranium.coords)
        --elseif
        --GetDistanceBetweenCoords(getPlayerPos(), Config.Zones.carParkInside.coords, true) < Config.DrawDistance then
            --drawMarkers(Config.Zones.carParkInside.coords)
        elseif
        GetDistanceBetweenCoords(getPlayerPos(), Config.Zones.hustleUranium.coords, true) < Config.DrawDistance then
            drawMarkers(Config.Zones.hustleUranium.coords)
        end
    end
    --end
end)

-- pickup uranium at quarry thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local dist = #(getPlayerPos() - Config.Zones.quarryLocation.coords)

        --if PlayerData.job ~= nil and PlayerData.job.name == 'atomicengineer' then
            if dist < Config.InteractionDistance then
                if not isPickingUp then
                    showNotification('uran_pickupprompt', false, true, 5000)
                end

                if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
                    isPickingUp = true

                    ESX.TriggerServerCallback('esx_atomicpower:canPickUp',function(canPickUp)

                        if canPickUp then
                            TaskStartScenarioInPlace(PlayerPedId(),'world_human_clipboard', 0, false)
                            Citizen.Wait(Config.Delays.upackUranium * 1000)
                            ClearPedTasks(playerPed)
                            Citizen.Wait(1500)
                            TriggerServerEvent('esx_atomicpower:pickedUraniumBox')
                        else
                            ESX.ShowNotification(_U('uran_fullprompt'))
                        end
                        isPickingUp = false

                    end, 'radbox')
                end
            else
                Citizen.Wait(500)
            end
        end

   -- end

end)

-- unpack box thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local dist = #(getPlayerPos() - Config.Zones.processUranium.coords)
        --if PlayerData.job ~= nil and PlayerData.job.name == 'atomicengineer' then
        if dist < Config.InteractionDistance then
            if not isCleaning then
                ESX.ShowHelpNotification(_U('processDirtyUranium'))
            end
            if IsControlJustReleased(0, Keys['E']) and not isCleaning then
                cleanUranium()
            end
        else
            Citizen.Wait(500)
        end
        end
    --end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local dist = #(getPlayerPos() - Config.Zones.placeBox.coords)
        --if PlayerData.job ~= nil and PlayerData.job.name == 'atomicengineer' then
        if dist < Config.InteractionDistance then
            if not isUnboxing then
                ESX.ShowHelpNotification(_U('uran_beginunpacking'))
            end
            if IsControlJustReleased(0, Keys['E']) and not isUnboxing then
                unpackBox()
            end
        else
            Citizen.Wait(500)
        end
        end
    --end
end)

--make uranium rods
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local dist = #(getPlayerPos() - Config.Zones.sellUranium.coords)
        --if PlayerData.job ~= nil and PlayerData.job.name == 'atomicengineer' then
        if dist < Config.InteractionDistance then
            if not isPressing then
                ESX.ShowHelpNotification(_U('pressUranium'))
            end
            if IsControlJustReleased(0, Keys['E']) and not isPressing then
                pressUranium()
            end
        else
            Citizen.Wait(500)
        end
        end
    --end
end)

--sell uranium
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local dist = #(getPlayerPos() - Config.Zones.hustleUranium.coords)
        --if PlayerData.job ~= nil and PlayerData.job.name == 'atomicengineer' then
        if dist < Config.InteractionDistance then
            if not isSelling then
                ESX.ShowHelpNotification(_U('uran_sell'))
            end
            if IsControlJustReleased(0, Keys['E']) and not isSelling then
                TaskStartScenarioInPlace(PlayerPedId(),'world_human_clipboard', 0, false)
                Citizen.Wait(Config.Delays.upackUranium * 1000)
                ClearPedTasks(playerPed)
                Citizen.Wait(1500)
                TriggerServerEvent('esx_atomicpower:sellUranium')
            end
        else
            Citizen.Wait(500)
        end
    end
    --end
end)

--teleport handler down
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local dist = #(getPlayerPos() - Config.Zones.liftTPLevel1.coords)
        --if PlayerData.job ~= nil and PlayerData.job.name == 'atomicengineer' then
        if dist < Config.InteractionDistance then
            ESX.ShowHelpNotification(_U('uran_teleport'))
            if IsControlJustReleased(0, Keys['E']) then
                SetEntityCoords(playerPed, Config.Zones.liftTPLevel2.coords, false, false, false, false)
                SetEntityHeading(playerPed, 75.51)
            end
        else
            Citizen.Wait(500)
        end
        --end
    end
end)

--teleport handler down
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local dist = #(getPlayerPos() - Config.Zones.liftTPLevel2.coords)
        --if ESX.PlayerData.job.name == 'atomicengineer' then
        if dist < Config.InteractionDistance then
            ESX.ShowHelpNotification(_U('uran_teleport'))
            if IsControlJustReleased(0, Keys['E']) then
                SetEntityCoords(playerPed, Config.Zones.liftTPLevel1.coords, false, false, false, false)
                SetEntityHeading(playerPed, 168.76)
            end
        else
            Citizen.Wait(500)
        end
        --end
    end
end)

-- ***********************************************************************************************************************************

function showNotification(message, thisFrame, makeSound, duration)
    ESX.ShowHelpNotification(_U(message), thisFrame, makeSound, duration)
end

function unpackBox()
    isUnboxing = true

    ESX.ShowNotification(_U('uran_processingstarted'))
    TriggerServerEvent('esx_atomicpower:processBoxedUranium')
    local timeLeft = Config.Delays.upackUranium * 1000

    while timeLeft > 0 do
        Citizen.Wait(1000)
        timeLeft = timeLeft - 1

        if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.Zones.placeBox.coords, false) > Config.InteractionDistance then
            ESX.ShowNotification(_U('uran_tooFar'))
            TriggerServerEvent('esx_atomicpower:cancelProcessing')
            break
        end
    end

    isUnboxing = false
end

function cleanUranium()
    isCleaning = true
    local dist = #(getPlayerPos() - Config.Zones.processUranium.coords)
    ESX.ShowNotification(_U('uran_processingstarted'))
    TriggerServerEvent('esx_atomicpower:processDirtyUranium')
    local timeLeft = Config.Delays.processUranium * 1000

    while timeLeft > 0 do
        Citizen.Wait(1000)
        timeLeft = timeLeft - 1

        if dist > Config.InteractionDistance then
            ESX.ShowNotification(_U('uran_tooFar'))
            TriggerServerEvent('esx_atomicpower:cancelProcessing')
            break
        end
    end

    isCleaning = false
end

function pressUranium()
    isPressing = true
    local dist = #(getPlayerPos() - Config.Zones.sellUranium.coords)
    ESX.ShowNotification(_U('uran_processingstarted'))
    TriggerServerEvent('esx_atomicpower:pressUranium')
    local timeLeft = Config.Delays.processUranium * 1000

    while timeLeft > 0 do
        Citizen.Wait(1000)
        timeLeft = timeLeft - 1

        if dist > Config.InteractionDistance then
            ESX.ShowNotification(_U('uran_tooFar'))
            TriggerServerEvent('esx_atomicpower:cancelProcessing')
            break
        end
    end

    isPressing = false
end



function drawMarkers(coords)
    DrawMarker(2, coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
end

function getPlayerPos()
    playerpos = GetEntityCoords(PlayerPedId())
    return playerpos
end

function CreateBlip(coords, text, radius, color, sprite)	
	-- create a blip in the middle
	blip = AddBlipForCoord(coords)
	SetBlipHighDetail(blip, true)
	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

--TOd
-- selling
-- (optional) cars
