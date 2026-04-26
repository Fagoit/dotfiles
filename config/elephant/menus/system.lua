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
				["lock"] = "i3lock -c 000000",
			},
		},
		{
			Text = "Suspend",
			Icon = "󰤄",
			Actions = {
				["suspend"] = "systemctl suspend",
			},
		},
		{
			Text = "Relaunch",
			Icon = "",
			Actions = {
				["relaunch"] = "pkill -HUP wmaker",
			},
		},
		{
			Text = "Restart",
			Icon = "󰜉",
			Actions = {
				["restart"] = "systemctl reboot",
			},
		},
		{
			Text = "Shutdown",
			Icon = "󰐥",
			Actions = {
				["shutdown"] = "systemctl poweroff",
			},
		},
	}
end
