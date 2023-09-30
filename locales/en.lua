local Translations = {
    error = {
        ["invalid_items"] = "You do not have the correct items!",
        ["no_items"] = "You do not have any items!",
		["not_enough_police"] = "Not enough cops in the city!",
    },
    success = {
		["sold"] = "You sold %{value}x %{value2} for $%{value3}";
	}
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true})
