Name = "menu"
NamePretty = "Menu"
FixedOrder = true
HideFromProviderlist = true
Description = "Menu"

function GetEntries()
	return {
		{
			Text = "Update",
			Icon = "",
			Actions = {
				["update"] = "ghostty --class=local.floating -e update-perform",
			},
		},
		{
			Text = "Install package",
			Icon = "󰣇",
			Actions = {
				["manage-pkg"] = "ghostty --class=local.floating -e pkg-install",
			},
		},
		{
			Text = "Remove package",
			Icon = "󰭌",
			Actions = {
				["manage-pkg"] = "ghostty --class=local.floating -e pkg-remove",
			},
		},
		{
			Text = "Change themes",
			Icon = "󰸌",
			Actions = {
				["change-themes"] = "theme-menu",
			},
		},
		{
			Text = "Next background",
			Icon = "",
			Actions = {
				["change-bg"] = "theme-bg-next",
			},
		},
		{
			Text = "Capture",
			Icon = "",
			Actions = {
				["capture"] = "screenshot-menu",
			},
		},
		{
			Text = "Setup",
			Icon = "󰉉",
			Actions = {
				["setup"] = "rofi -show drun",
			},
		},
		{
			Text = "Tools",
			Icon = "",
			Actions = {
				["tools"] = "rofi -show drun",
			},
		},
		{
			Text = "Keybindings",
			Icon = "",
			Actions = {
				["keybindings"] = "ghostty --class=local.floating -e sh -lc 'sed -n \"1,160p\" ~/.xbindkeysrc; read -r _'",
			},
		},
		{
			Text = "System",
			Icon = "󰐥",
			Actions = {
				["system"] = "system-menu",
			},
		},
	}
end
