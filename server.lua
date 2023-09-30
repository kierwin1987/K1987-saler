local QBCore = exports['qb-core']:GetCoreObject()

function SendDiscordMessage(item, Payment, pocet, Player)
	local citizenid = Player.PlayerData.citizenid
	local name = Player.PlayerData.name
	local footer = "K1987-saler"
	local color = 56108
	local message = name.." ["..citizenid.."] prodal "..pocet.amount.."x "..item['label'].." za $"..Payment
	local embeds = {
		{
			["title"] = name,
			["description"] = message,
			["type"] = "rich",
			["color"] = color,
			["footer"] = {
				["text"] = footer,
			},
		}
	}

    PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

QBCore.Functions.CreateCallback('k1987-saler:server:GetCurrentPlayers', function(source, cb)
    local TotalPlayers = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)

QBCore.Functions.CreateCallback('k1987-saler:server:GetActivity', function(source, cb)
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

RegisterNetEvent('k1987-saler:server:Selling', function(item, cena, markedbills)
	local Player = QBCore.Functions.GetPlayer(source)
	local pocet = Player.Functions.GetItemByName(item)
	local amount = 0

	if Player.PlayerData.items ~= nil then
		if item ~= nil and pocet ~= nil then
			if pocet.amount > 0 then
				if markedbills then
					local bags = 1
					local Payment = {
						worth = pocet.amount * cena
					}
					Player.Functions.RemoveItem(item, pocet.amount, false)
					local item = QBCore.Shared.Items[tostring(item):lower()]
					Player.Functions.AddItem('markedbills', bags, false, Payment)
    			    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['markedbills'], "add")
					TriggerClientEvent('QBCore:Notify', source, Lang:t('success.sold', {value = pocet.amount, value2 = item['label'], value3 = Payment.worth}), "success")
--					SendDiscordMessage(item, Payment, pocet, Player)
				else
					Payment = pocet.amount * cena
					Player.Functions.RemoveItem(item, pocet.amount, false)
					local item = QBCore.Shared.Items[tostring(item):lower()]
					TriggerClientEvent('inventory:client:ItemBox', source, item, "remove")
					Player.Functions.AddMoney('cash', Payment)
					TriggerClientEvent('QBCore:Notify', source, Lang:t('success.sold', {value = pocet.amount, value2 = item['label'], value3 = Payment}), "success")
--					SendDiscordMessage(item, Payment, pocet, Player)
				end	
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
