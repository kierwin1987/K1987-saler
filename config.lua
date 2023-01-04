Config = {}

Config.UseTarget = GetConvar('UseTarget', 'true') == 'true'

Config.Peds = {
	["Prodej"] = {
		["label"] = "Prodejce",
		["coords"] = vector4(485.82, 4813.58, -58.38, 350.1),
		["ped"] = 'mp_m_shopkeep_01',
		["scenario"] = "WORLD_HUMAN_STAND_MOBILE",
		["radius"] = 1.5,
		["targetIcon"] = "fas fa-shopping-basket",
		["targetLabel"] = "Prodej nižší",
		["akce"] = "prodej",
		["gang"] = {
			["lostmc"] = 0,
			["ballas"] = 0,
		},
		["showblip"] = false,
        ["blipsprite"] = 52,
        ["blipscale"] = 0.6,
        ["blipcolor"] = 0
   },
   ["Prodej2"] = {
		["label"] = "Prodejce 2",
		["coords"] = vector4(481.27, 4814.25, -58.38, 22.36),
		["ped"] = 'mp_m_shopkeep_01',
		["scenario"] = "WORLD_HUMAN_STAND_MOBILE",
		["radius"] = 1.5,
		["targetIcon"] = "fas fa-shopping-basket",
		["targetLabel"] = "Prodej vyšší",
		["akce"] = "prodej2",
		["gang"] = {
			["vagos"] = 0,
			["triads"] = 0,
		},
		["showblip"] = false,
        ["blipsprite"] = 52,
        ["blipscale"] = 0.6,
        ["blipcolor"] = 0
	},
	["Prodej3"] = {
		["label"] = "<font face='Red Hat Display'>Prodejce</font>",
		["coords"] = vector4(479.88, 4818.33, -58.38, 13.5),
		["ped"] = 'cs_priest',
		["scenario"] = "WORLD_HUMAN_STAND_MOBILE",
		["radius"] = 1.5,
		["targetIcon"] = "fas fa-shopping-basket",
		["targetLabel"] = "Prodej vše",
		["akce"] = "prodej3",
		["gang"] = {
			["none"] = 0,
		},
		["showblip"] = false,
        ["blipsprite"] = 52,
        ["blipscale"] = 0.6,
        ["blipcolor"] = 0
	}
}

Config.Targets = {}

Config.Selling = {
	Prodej = {
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
	Prodej2 = {
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
	Prodej3 = {
		[1] = {
			ItemName = "lockpick",
			Price = 50,
			Label = "Lockpick",
			description = "Prodej Lockpick"
		},
		[2] = {
			ItemName = "metalscrap",
			Price = 60,
			Label = "Šrot",
			description = "Prodej Šrot"
		}
	}
}