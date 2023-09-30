local Translations = {
    error = {
        ["invalid_items"] = "Nemáš správné itemy u sebe!",
        ["no_items"] = "Nemáš žédné item u sebe",
		["not_enough_police"] = "Nedostatek PD",
    },
    success = {
		["sold"] = "Prodal jsi %{value}x %{value2} za $%{value3}";
	}
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true})
