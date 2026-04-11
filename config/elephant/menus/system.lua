Name = "system"
NamePretty = "System"
FixedOrder = true
HideFromProviderlist = true
Icon = ""
Parent = "menu"

function GetEntries()
	return {
		{
			Text = "Lock",
			Icon = "",
			Actions = {
				["lock"] = "pidof hyprlock || hyprlock &",
			},
		},
		{
			Text = "Suspend",
			Icon = "󰤄",
			Actions = {
				["suspend"] = "system-action suspend",
			},
		},
		{
			Text = "Relaunch",
			Icon = "",
			Actions = {
				["relaunch"] = "hypr-relaunch",
			},
		},
		{
			Text = "Restart",
			Icon = "󰜉",
			Actions = {
				["restart"] = "system-action reboot",
			},
		},
		{
			Text = "Shutdown",
			Icon = "󰐥",
			Actions = {
				["shutdown"] = "system-action poweroff",
			},
		},
	}
end
