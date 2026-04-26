Name = "screenshots"
NamePretty = "Screenshots"
FixedOrder = true
HideFromProviderlist = true
Icon = ""
Parent = "capture"
function GetEntries()
	return {
		{
			Text = "Area → Clipboard",
			Actions = {
				["area_clipboard"] = "maim -s | xclip -selection clipboard -t image/png && notify-send 'Copied Area'",
			},
		},
		{
			Text = "Area → File",
			Actions = {
				["area_file"] = "mkdir -p ~/Pictures && maim -s ~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png && notify-send 'Saved Screenshot'",
			},
		},
		{
			Text = "Window → Clipboard",
			Actions = {
				["window_clipboard"] = "maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png && notify-send 'Copied Window'",
			},
		},
		{
			Text = "Window → File",
			Actions = {
				["window_file"] = "mkdir -p ~/Pictures && maim -i $(xdotool getactivewindow) ~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png && notify-send 'Saved Window'",
			},
		},
		{
			Text = "Fullscreen → Clipboard",
			Actions = {
				["fullscreen_clipboard"] = "maim | xclip -selection clipboard -t image/png && notify-send 'Copied Fullscreen'",
			},
		},
		{
			Text = "Fullscreen → File",
			Actions = {
				["fullscreen_file"] = "mkdir -p ~/Pictures && maim ~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png && notify-send 'Saved Fullscreen'",
			},
		},
	}
end
