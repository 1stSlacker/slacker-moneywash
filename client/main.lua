local QBCore = exports['qb-core']:GetCoreObject()
local spawnedPed

-- Function to spawn the ped
local function spawnPed()
    -- Load the ped model
    local model = GetHashKey(Config.PedModel)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    -- Spawn the ped
    spawnedPed = CreatePed(4, model, Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z - 1.0, Config.PedLocation.w, false, true)

    -- Set ped properties
    SetEntityInvincible(spawnedPed, true)
    SetBlockingOfNonTemporaryEvents(spawnedPed, true)
    FreezeEntityPosition(spawnedPed, true)

    -- Add qb-target interaction
    exports['qb-target']:AddTargetEntity(spawnedPed, {
        options = {
            {
                type = "client",
                event = Config.InteractionEvent,
                icon = "fas fa-money-bill",
                label = Config.TargetLabel,
            },
        },
        distance = 2.5,  -- Distance within which the interaction is available
    })
end

-- Function to ensure the ped is spawned
local function ensurePedIsSpawned()
    if not DoesEntityExist(spawnedPed) then
        spawnPed()
    end
end

-- Periodically check and spawn the ped if needed
CreateThread(function()
    while true do
        ensurePedIsSpawned()
        Wait(5000)  -- Check every 5 seconds (you can adjust the interval if needed)
    end
end)

-- Clean up when the resource stops
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName and spawnedPed then
        exports['qb-target']:RemoveTargetEntity(spawnedPed)  -- Remove target when resource stops
        DeleteEntity(spawnedPed)
    end
end)

-- Event triggered when the player selects the option
RegisterNetEvent(Config.InteractionEvent)
AddEventHandler(Config.InteractionEvent, function()
    -- Trigger a progress bar
	exports["rpemotes"]:EmoteCommandStart("handshake")
    QBCore.Functions.Progressbar("washing_money", Config.ProgressBarLabel, Config.ProgressBarTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        -- Once the progress bar is complete, check and wash money
        TriggerServerEvent('260-moneywash:WashBlackMoney')
    end, function() -- Cancel
        QBCore.Functions.Notify("Money washing canceled.", "error")
    end)
end)
