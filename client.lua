local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
local stashTargetBoxID = 'stashTarget'
local tasking = false
local random = 0
local blip = 0
local pedSpawned = false
local JobPed = {}
local NewZones = {}

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

local function createBlips()
    if pedSpawned then return end

    for saler in pairs(Config.Peds) do
        if Config.Peds[saler]["showblip"] then
            local StoreBlip = AddBlipForCoord(Config.Peds[saler]["coords"]["x"], Config.Peds[saler]["coords"]["y"], Config.Peds[saler]["coords"]["z"])
            SetBlipSprite(StoreBlip, Config.Peds[saler]["blipsprite"])
            SetBlipScale(StoreBlip, Config.Peds[saler]["blipscale"])
            SetBlipDisplay(StoreBlip, 4)
            SetBlipColour(StoreBlip, Config.Peds[saler]["blipcolor"])
            SetBlipAsShortRange(StoreBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Peds[saler]["label"])
            EndTextCommandSetBlipName(StoreBlip)
        end
    end
end

local function Menu(data, akce)
	if akce == "prodej" then
		TriggerEvent('qb-saler:client:target:prodej')
	end
	if akce == "prodej2" then
		TriggerEvent('qb-saler:client:target:prodej2')
	end
	if akce == "prodej3" then
		TriggerEvent('qb-saler:client:target:prodej3')
	end
end

local function PlayerJob()
	QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
    end)
	print(PlayerJob.name)
end

local function createPeds()
    if pedSpawned then return end
    for k, v in pairs(Config.Peds) do
        if not JobPed[k] then JobPed[k] = {} end
        local current = v["ped"]
        local akce = v["akce"]
		local gang = v["gang"]
        current = type(current) == 'string' and GetHashKey(current) or current
        RequestModel(current)

        while not HasModelLoaded(current) do
            Wait(0)
        end
		
        JobPed[k] = CreatePed(0, current, v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
        TaskStartScenarioInPlace(JobPed[k], v["scenario"], true)
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
					action = function()
						Menu(Config.Peds[k], akce)
					end,
				}
                },
                distance = 2.5,
            })
			
    end

    current = type(current) == 'string' and GetHashKey(current) or current
    RequestModel(current)

    while not HasModelLoaded(current) do
        Wait(0)
    end

    pedSpawned = true
end


local function log(debugMessage)
	print(('^6[^3qb-saler^6]^0 %s'):format(debugMessage))
end

RegisterNetEvent('qb-saler:client:target:Sell', function (data)
	local item = data.item
	local cena = data.cena
	TriggerServerEvent('qb-saler:server:Selling', item, cena)
end)

RegisterNetEvent('qb-saler:client:target:prodej', function ()
	local Prodej = {
		{
			header = "Prodej",
			isMenuHeader = true,
			icon = "fas fa-comment"
		},
	}
		for k, v in pairs(Config.Selling.Prodej) do
			Prodej[#Prodej + 1] = {
			header = v.Label,
			icon = "fa-solid fa-wrench",
			txt = v.description,
			params = {
				event = "qb-saler:client:target:Sell",
				args = {
					item = v.ItemName,
					cena = v.Price,
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
end)

RegisterNetEvent('qb-saler:client:target:prodej2', function ()
	local Prodej2 = {
		{
			header = "Prodej",
			isMenuHeader = true,
			icon = "fas fa-comment"
		},
	}
		for k, v in pairs(Config.Selling.Prodej2) do
			Prodej2[#Prodej2 + 1] = {
			header = v.Label,
			icon = "fa-solid fa-wrench",
			txt = v.description,
			params = {
				event = "qb-saler:client:target:Sell",
				args = {
					item = v.ItemName,
					cena = v.Price,
				}
			}	
		}
		end
		Prodej2[#Prodej2 + 1] = {
            header = "Zavrit",
            txt = "Uzavri",
			icon = "fas fa-times",
            params = {
                event = "qb-menu:client:closeMenu",
            }
        }
	
	exports['qb-menu']:openMenu(Prodej2)
end)

RegisterNetEvent('qb-saler:client:target:prodej3', function ()
	local Prodej3 = {
		{
			header = "Prodej",
			isMenuHeader = true,
			icon = "fas fa-comment"
		},
	}
		for k, v in pairs(Config.Selling.Prodej3) do
			Prodej3[#Prodej3 + 1] = {
			header = v.Label,
			icon = "fa-solid fa-wrench",
			txt = v.description,
			params = {
				event = "qb-saler:client:target:Sell",
				args = {
					item = v.ItemName,
					cena = v.Price,
				}
			}	
		}
		end
		Prodej3[#Prodej3 + 1] = {
            header = "Zavrit",
            txt = "Uzavri",
			icon = "fas fa-times",
            params = {
                event = "qb-menu:client:closeMenu",
            }
        }
	
	exports['qb-menu']:openMenu(Prodej3)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    deletePeds()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
    end)
    createPeds()
	createBlips()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    createBlips()
    createPeds()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        deletePeds()
    end
end)