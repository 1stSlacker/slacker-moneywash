local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('260-moneywash:WashBlackMoney', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local blackMoneyAmount = Player.Functions.GetItemByName(Config.BlackMoneyItem)

    if blackMoneyAmount then
        local amountToWash = blackMoneyAmount.amount
        if amountToWash > 0 then
            -- Calculate the clean money based on the wash rate
            local cleanMoney = math.floor(amountToWash * Config.WashRate)
            
            -- Remove the black money and add clean cash
            Player.Functions.RemoveItem(Config.BlackMoneyItem, amountToWash)
            Player.Functions.AddMoney('cash', cleanMoney)

            TriggerClientEvent('QBCore:Notify', src, "You washed $" .. cleanMoney .. " of black money.", "success")
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have any black money to wash.", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have any black money to wash.", "error")
    end
end)
