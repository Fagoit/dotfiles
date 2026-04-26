Name = "capture"
NamePretty = "Capture"
FixedOrder = true
HideFromProviderlist = true
Icon = ""
Parent = "menu"

function GetEntries()
	return {
		{
			Text = "Screenshot",
			Icon = "",
			Actions = {
				["screenshot"] = "screenshot-menu",
			},
		},
		{
			Text = "Record",
			Icon = "",
			Actions = {
				["record"] = "screenrecord",
			},
		},
	}
end
