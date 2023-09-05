Config = {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.Peds = {
	["Prodej"] = {
		["label"] = "Prodejce",
		["coords"] = vector4(-1211.98, -1546.65, 4.37, 314.84),
		["ped"] = 'mp_m_shopkeep_01',
		["scenario"] = "WORLD_HUMAN_STAND_MOBILE",
		["radius"] = 1.5,
		["targetIcon"] = "fas fa-shopping-basket",
		["targetLabel"] = "Prodej nižší",
		["akce"] = "prodej",
		["need_cop"] = 0,
		["gang"] = {
			["lostmc"] = 0,
			["ballas"] = 0,
		},
		["markedbills"] = true
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
		["gang"] = {
			["families"] = 0,
			["vagos"] = 0,
		},
		["markedbills"] = true
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
		["markedbills"] = true
	},
}

Config.Targets = {}

Config.Selling = {
	["prodej"] = {
		[1] = {
			ItemName = "beer",
			Price = 50,
			Label = "Pivo",
			description = "Prodej pivo"
		},
		[2] = {
			ItemName = "vodka",
			Price = 60,
			Label = "Vodka",
			description = "Prodej vodky"
		}
	},
	["prodej2"] = {
		[1] = {
			ItemName = "joint",
			Price = 50,
			Label = "Joint",
			description = "Prodej joint"
		},
		[2] = {
			ItemName = "crack",
			Price = 60,
			Label = "Crack",
			description = "Prodej crack"
		}
	},
}
