local Translations = {
    error = {
        ["invalid_items"] = "Nemáš správné itemy u sebe!",
        ["no_items"] = "Nemáš žédné item u sebe",
    },
    success = {
		["sold"] = "Prodal jsi %{value}x %{value2} za $%{value3}";
	},
	info = {
		["open"] = "[E] otevřit";
	}
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true}