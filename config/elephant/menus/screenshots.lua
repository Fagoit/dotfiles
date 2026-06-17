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
				["area_clipboard"] = "bash \"$HOME/.local/share/dotfiles/bin/x-screenshot\" area-clip",
			},
		},
		{
			Text = "Area → File",
			Actions = {
				["area_file"] = "bash \"$HOME/.local/share/dotfiles/bin/x-screenshot\" area-file",
			},
		},
		{
			Text = "Window → Clipboard",
			Actions = {
				["window_clipboard"] = "bash \"$HOME/.local/share/dotfiles/bin/x-screenshot\" window-clip",
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
				["fullscreen_clipboard"] = "bash \"$HOME/.local/share/dotfiles/bin/x-screenshot\" full-clip",
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
