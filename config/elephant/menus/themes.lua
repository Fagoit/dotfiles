Name = "themes"
NamePretty = "Themes"
FixedOrder = true
HideFromProviderlist = true
Icon = "󰸌"
Parent = "menu"

function GetEntries()
	return {
		{
			Text = "System theme",
			Icon = "󰸌",
			Actions = {
				["change-theme"] = "theme-menu",
			},
		},
		{
			Text = "Fastfetch theme",
			Icon = "󰸌",
			Actions = {
				["change-fastfetch"] = "rofi -show drun",
			},
		},
		{
			Text = "Starship theme",
			Icon = "󰸌",
			Actions = {
				["change-starship"] = "rofi -show drun",
			},
		},
		{
			Text = "Cursor theme",
			Icon = "󰸌",
			Actions = {
				["change-cursor"] = "rofi -show drun",
			},
		},
	}
end
