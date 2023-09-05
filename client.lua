local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
local blip = 0
local cops = 0
local pedSpawned = false
local JobPed = {}

local function deletePeds()
	if pedSpawned then
		for k, v in pairs(JobPed) do
			DeletePed(v)
		end
	end
end

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
	PlayerJob = JobInfo
end)

local function createPeds()
	if pedSpawned then return end
	
	QBCore.Functions.TriggerCallback('qb-saler:server:GetActivity', function(cops, ambulance)
		QBCore.Functions.TriggerCallback("qb-saler:server:GetCurrentPlayers", function(Players)
		end)
	end)
	
	for k, v in pairs(Config.Peds) do
		if not JobPed[k] then JobPed[k] = {} end
		local SalerPed = k
		local current = v["ped"]
		local akce = v["akce"]
		local gang = v["gang"]
		local job = v["job"]
		local needed_cops = v["need_cop"]
		current = type(current) == 'string' and GetHashKey(current) or current
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
					TriggerEvent('qb-saler:client:target:prodej', akce, SalerPed, needed_cops, cops)
 --					Menu(k, Config.Peds[k], akce)
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

RegisterNetEvent('qb-saler:client:target:Sell', function (data)
	local item = data.item
	local cena = data.cena
	local Ped = data.SalerPed
	TriggerServerEvent('qb-saler:server:Selling', item, cena, Ped)
end)

RegisterNetEvent('qb-saler:client:target:prodej', function (akce, SalerPed, needed_cops, cops)
	print(needed_cops)
	print(cops)
	print(cops>needed_cops)
	
	if cops >= needed_cops then
		QBCore.Functions.Notify('Nedostatek PD', "error", 5000)
		print("Nedostatek PD")
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
				event = "qb-saler:client:target:Sell",
				args = {
					item = v.ItemName,
					cena = v.Price,
					SalerPed = SalerPed
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
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	QBCore.Functions.GetPlayerData(function(PlayerData)
		PlayerJob = PlayerData.job
	end)
	createPeds()
end)

AddEventHandler('onResourceStart', function(resourceName)
	if GetCurrentResourceName() == resourceName then
		createPeds()
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if GetCurrentResourceName() == resourceName then
		deletePeds()
	end
end)
