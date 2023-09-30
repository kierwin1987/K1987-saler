local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
local blip = 0
local cops = 0
local pedSpawned = false
local JobPed = {}

local function deletePeds()
	if not pedSpawned then return end

	for k, v in pairs(JobPed) do
		DeletePed(v)
	end
	pedSpawned = false
end

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
	local PlayerJob = JobInfo
end)

local function createPeds()
	if pedSpawned then return end
	
	QBCore.Functions.TriggerCallback('k1987-saler:server:GetActivity', function(cops, ambulance)
		QBCore.Functions.TriggerCallback("k1987-saler:server:GetCurrentPlayers", function(Players)
		end)
	end)
	
	for k, v in pairs(Config.Peds) do
		if not JobPed[k] then JobPed[k] = {} end
		local stableprice = v["StablePrice"]
		local current = v["ped"]
		local akce = v["akce"]
		local gang = v["gang"]
		local job = v["job"]
		local illegal = v["illegal"]
		local needed_cops = v["need_cop"]
		local markedbills = v["markedbills"]
		
		local current = type(v["ped"]) == "number" and v["ped"] or joaat(v["ped"])
		RequestModel(current)

		while not HasModelLoaded(current) do
			Wait(0)
		end

		JobPed[k] = CreatePed(0, current, v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
		TaskStartScenarioInPlace(JobPed[k], v["scenario"], 0, true)
		FreezeEntityPosition(JobPed[k], true)
		SetEntityInvincible(JobPed[k], true)
		SetBlockingOfNonTemporaryEvents(JobPed[k], true)

		exports['qb-target']:AddTargetEntity(JobPed[k], {
		options = {
			{
				label = v["targetLabel"],
				icon = v["targetIcon"],
				item = v["item"],
				gang = gang,
				job = job,
				action = function() 
					TriggerEvent('k1987-saler:client:target:prodej', akce, markedbills, needed_cops, cops, stableprice, illegal)
 					end,
				}
			},
			distance = 2.0
		})
	end

	current = type(current) == 'string' and GetHashKey(current) or current
	RequestModel(current)

	while not HasModelLoaded(current) do
		Wait(0)
	end
	pedSpawned = true
end

RegisterNetEvent('k1987-saler:client:target:Sell', function (data)
	local item = data.item
	local markedbills = data.markedbills
	local stableprice = data.stableprice
	local minprice = data.minprice
	local maxprice = data.maxprice
	local illegal = data.illegal
	if stableprice then
		cena = data.cena
	else
		cena = math.random(minprice, maxprice)
	end
	
	if illegal then
		for k,_ in pairs(Config.Dispatch) do
			if k == "ps" and v then
				exports['ps-dispatch']:DrugSale()
			elseif k == "default" and v then
				TriggerServerEvent('police:server:policeAlert', 'Probíhá prodej drog')
			end
		end
	end
	TriggerServerEvent('k1987-saler:server:Selling', item, cena, markedbills)
end)

RegisterNetEvent('k1987-saler:client:target:prodej', function (akce, markedbills, needed_cops, cops, stableprice, illegal)
	if cops >= needed_cops then
		QBCore.Functions.Notify(lang:t('no_pd'), "error", 5000)
	else
		local Prodej = {
			{
				header = "Prodej",
				isMenuHeader = true,
				icon = "fas fa-comment"
			},
		}
		for k, v in pairs(Config.Selling[akce]) do
			Prodej[#Prodej + 1] = {
			header = v.Label,
			icon = "fa-solid fa-wrench",
			txt = v.description,
			params = {
				event = "k1987-saler:client:target:Sell",
				args = {
					item = v.ItemName,
					cena = v.Price,
					markedbills = markedbills,
					stableprice = stableprice,
					minprice = v.MinPrice,
					maxprice = v.MaxPrice,
					illegal = illegal
				}
			}	
		}
		end
		Prodej[#Prodej + 1] = {
			header = "Zavrit",
			txt = "Uzavri",
			icon = "fas fa-times",
			params = {
				event = "qb-menu:client:closeMenu",
			}
		}
		exports['qb-menu']:openMenu(Prodej)
	end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    deletePeds()
	PlayerData = nil
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	PlayerData = QBCore.Functions.GetPlayerData()
	createPeds()
end)

AddEventHandler('onResourceStart', function(resourceName)
	if GetCurrentResourceName() ~= resourceName then return end

	createPeds()
end)

AddEventHandler('onResourceStop', function(resourceName)
	if GetCurrentResourceName() ~= resourceName then return end

	deletePeds()
end)
