local QBCore = exports['qb-core']:GetCoreObject()
local WebHook = 'WebHook'

function SendDiscordMessage(item, Payment, pocet, Player)
	local citizenid = Player.PlayerData.citizenid
	local name = Player.PlayerData.name
	local footer = "qb-saler"
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

    PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('qb-saler:server:Selling', function(item, cena)
	local Player = QBCore.Functions.GetPlayer(source)
	local pocet = Player.Functions.GetItemByName(item)

	if Player.PlayerData.items ~= nil then
		if item ~= nil and pocet ~= nil then
			if pocet.amount > 0 then
				Payment = pocet.amount * cena
				Player.Functions.RemoveItem(item, pocet.amount, false)
				local item = QBCore.Shared.Items[tostring(item):lower()]
				TriggerClientEvent('inventory:client:ItemBox', source, item, "remove")
				Player.Functions.AddMoney('cash', Payment)
				TriggerClientEvent('QBCore:Notify', source, Lang:t('success.sold', {value = pocet.amount, value2 = item['label'], value3 = Payment}), "success")
				SendDiscordMessage(item, Payment, pocet, Player)
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