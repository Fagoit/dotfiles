Name = "screenshots"
NamePretty = "Screenshots"
FixedOrder = true
HideFromProviderlist = true
Icon = ""
Parent = "capture"
function GetEntries()
	local dir = "~/Pictures/Screenshots"
	local file = dir .. "/$(date +%Y-%m-%d_%H-%M-%S).png"
	local ensure = "mkdir -p " .. dir
	return {
		{
			Text = "Area → Clipboard + File",
			Actions = {
				["area_clipboard"] = ensure
					.. " && grim -g \"$(slurp)\" - | tee "
					.. file
					.. " | wl-copy && notify-send 'Screenshot' 'Saved + copied area'",
			},
		},
		{
			Text = "Area → File",
			Actions = {
				["area_file"] = ensure
					.. " && grim -g \"$(slurp)\" "
					.. file
					.. " && notify-send 'Screenshot' 'Saved area'",
			},
		},
		{
			Text = "Window → Clipboard + File",
			Actions = {
				["window_clipboard"] = ensure
					.. " && grim -g \"$(hyprctl -j clients | jq -r '.[] | \"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])\"' | slurp -r)\" - | tee "
					.. file
					.. " | wl-copy && notify-send 'Screenshot' 'Saved + copied window'",
			},
		},
		{
			Text = "Window → File",
			Actions = {
				["window_file"] = ensure
					.. " && grim -g \"$(hyprctl -j clients | jq -r '.[] | \"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])\"' | slurp -r)\" "
					.. file
					.. " && notify-send 'Screenshot' 'Saved window'",
			},
		},
		{
			Text = "Fullscreen → Clipboard + File",
			Actions = {
				["fullscreen_clipboard"] = ensure
					.. " && grim - | tee "
					.. file
					.. " | wl-copy && notify-send 'Screenshot' 'Saved + copied fullscreen'",
			},
		},
		{
			Text = "Fullscreen → File",
			Actions = {
				["fullscreen_file"] = ensure
					.. " && grim "
					.. file
					.. " && notify-send 'Screenshot' 'Saved fullscreen'",
			},
		},
	}
end
