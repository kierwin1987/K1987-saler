Config = {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.Webhook = ""

Config.Peds = {
	["Prodej"] = { --Name of Selling Ped for better orientation
		["label"] = "Prodejce", -- Or label for better orientation
		["coords"] = vector4(-1211.98, -1546.65, 4.37, 314.84), -- Location of Ped
		["ped"] = 'mp_m_shopkeep_01', -- Ped
		["scenario"] = "WORLD_HUMAN_STAND_MOBILE", --Ped Scenario
		["radius"] = 1.5, -- Radius for qb-target
		["targetIcon"] = "fas fa-shopping-basket", --qb-target icons
		["targetLabel"] = "Prodej nižší", -- qb-target label
		["akce"] = "prodej", -- What will be buying. Must be the same with name in Config.Selling [""]
		["need_cop"] = 0, -- If cops is needed
		["gang"] = {'lostmc','ballas'}, -- If is a member of some gang. Gangs from @qb-core/shared/gangs.lua
--		["job"] = {'police','ambulance'}, -- If has some job. Jobs from @qb-core/shared/jobs.lua
		["markedbills"] = true, -- True if you want to give to player a Marked Money
		["StablePrice"] = true, -- True for Price, false for MinPrice and MaxPrice.
		['illegal'] = false -- True for selling illegal ware. With true will be also notifed PDs.
	},
	["Prodej2"] = {
		["label"] = "Prodejce 2",
		["coords"] = vector4(-1208.98, -1551.29, 4.37, 297.94),
		["ped"] = 'mp_m_shopkeep_01',
		["scenario"] = "WORLD_HUMAN_STAND_MOBILE",
		["radius"] = 1.5,
		["targetIcon"] = "fas fa-shopping-basket",
		["targetLabel"] = "Prodej vyšší",
		["akce"] = "prodej2",
		["need_cop"] = 0,
		["gang"] = {'families','vagos'},
--		["job"] = {'none'},
		["markedbills"] = true,
		["StablePrice"] = true,
		['illegal'] = false
	},
	["Prodej3"] = {
		["label"] = "Prodejce 3",
		["coords"] = vector4(-1208.97, -1543.64, 4.33, 197.45),
		["ped"] = 'csb_mp_agent14',
		["scenario"] = "world_human_drinking",
		["radius"] = 1.5,
		["targetIcon"] = "fas fa-shopping-basket",
		["targetLabel"] = "Prodej vyšší",
		["akce"] = "prodej2",
		["need_cop"] = 2,
		["gang"] = {
			["none"] = 0,
		},
		["markedbills"] = true,
		["StablePrice"] = false,
		['illegal'] = true
	},
}

Config.Targets = {}

Config.Dispatch = {
	['default'] = false, -- default qb-core 
	['ps'] = true, -- https://github.com/Project-Sloth/ps-dispatch
}

Config.Selling = {
	["prodej"] = {
		[1] = {
			ItemName = "beer",
			Price = 50,
			Label = "Pivo",
			description = "Prodej pivo",
			MinPrice = 50,
			MaxPrice = 60
		},
		[2] = {
			ItemName = "vodka",
			Price = 60,
			Label = "Vodka",
			description = "Prodej vodky",
			MinPrice = 50,
			MaxPrice = 60
		}
	},
	["prodej2"] = {
		[1] = {
			ItemName = "joint",
			Price = 50,
			Label = "Joint",
			description = "Prodej joint",
			MinPrice = 50,
			MaxPrice = 60
		},
		[2] = {
			ItemName = "crack",
			Price = 60,
			Label = "Crack",
			description = "Prodej crack",
			MinPrice = 60,
			MaxPrice = 80
		}
	},
}
