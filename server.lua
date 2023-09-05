local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-saler:server:GetCurrentPlayers', function(source, cb)
    local TotalPlayers = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)

QBCore.Functions.CreateCallback('qb-saler:server:GetActivity', function(source, cb)
    local PoliceCount = 0
    local AmbulanceCount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            PoliceCount = PoliceCount + 1
        end

        if v.PlayerData.job.name == "ambulance" and v.PlayerData.job.onduty then
            AmbulanceCount = AmbulanceCount + 1
        end
    end
    cb(PoliceCount, AmbulanceCount)
end)

RegisterNetEvent('qb-saler:server:Selling', function(item, cena, Ped)
	local Player = QBCore.Functions.GetPlayer(source)
	local pocet = Player.Functions.GetItemByName(item)
	local amount = 0
	local players = QBCore.Functions.GetQBPlayers()
	print('test')
	if Player.PlayerData.items ~= nil then
		if item ~= nil and pocet ~= nil then
			if pocet.amount > 0 then
				Payment = pocet.amount * cena
				Player.Functions.RemoveItem(item, pocet.amount, false)
				local item = QBCore.Shared.Items[tostring(item):lower()]
				TriggerClientEvent('inventory:client:ItemBox', source, item, "remove")
				Player.Functions.AddMoney('cash', Payment)
				TriggerClientEvent('QBCore:Notify', source, Lang:t('success.sold', {value = pocet.amount, value2 = item['label'], value3 = Payment}), "success")
			else
				TriggerClientEvent('QBCore:Notify', source, Lang:t("error.invalid_items"), 'error')
			end
		else
			TriggerClientEvent('QBCore:Notify', source, Lang:t("error.invalid_items"), 'error')
		end
	else
		TriggerClientEvent('QBCore:Notify', source, Lang:t("error.no_items"), "error")
	end

end)
