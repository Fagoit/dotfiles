Name = "keybindings"
NamePretty = "Keybindings"
HideFromProviderlist = true
Cache = false
Parent = "menu"

function GetEntries()
	local entries = {}
	local home = os.getenv("HOME") or ""
	local hypr_config = home .. "/.config/hypr/hyprland.lua"

	local hardware_file = home .. "/.config/hypr/hardware"
	local hardware_handle = io.open(hardware_file, "r")
	local hardware = hardware_handle and hardware_handle:read("*l") or "desktop"
	if hardware_handle then
		hardware_handle:close()
	end
	local keybindings_path = home .. "/.local/share/dotfiles/default/hypr/lua/" .. (hardware == "laptop" and "laptop-keybindings.lua" or "desktop-keybindings.lua")
	local config_file = keybindings_path

	local test_file = io.open(config_file, "r")
	if not test_file then
		table.insert(entries, {
			Text = "Error: Keybindings file not found",
			Subtext = config_file,
			Value = "",
		})
		return entries
	end
	test_file:close()

	local file = io.open(config_file, "r")
	if not file then
		return entries
	end

	for line in file:lines() do
		local combo, command = line:match('%{%s*key%s*=%s*"([^"]+)"%s*,%s*command%s*=%s*"([^"]+)"')
		if combo and command then
			local display_text = combo .. string.rep(" ", math.max(1, 35 - #combo)) .. "→ " .. command
			table.insert(entries, {
				Text = display_text,
				Value = combo .. " → " .. command,
				Actions = {
					copy = "echo '" .. combo .. "' | wl-copy && notify-send 'Copied' '" .. combo .. "'",
				},
			})
		end
	end

	file:close()

	if #entries == 0 then
		table.insert(entries, {
			Text = "No keybindings found",
			Subtext = "Check your Hyprland config",
			Value = "",
		})
	end

	return entries
end
