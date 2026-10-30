Name = "keybindings"
NamePretty = "Keybindings"
HideFromProviderlist = true
Cache = false
Parent = "menu"

local function add_bindings(entries, path)
	local file = io.open(path, "r")
	if not file then
		table.insert(entries, {
			Text = "Error: Keybindings file not found",
			Subtext = path,
			Value = "",
		})
		return
	end

	for line in file:lines() do
		-- Binds built in loops (workspaces) use concatenation and are listed separately.
		local combo = line:match('^%s*hl%.bind%(%s*"([^"]+)"%s*,')
		local description = line:match('description%s*=%s*"([^"]+)"')
		if combo and description then
			local display_text = combo .. string.rep(" ", math.max(1, 35 - #combo)) .. "→ " .. description
			table.insert(entries, {
				Text = display_text,
				Value = combo .. " → " .. description,
				Actions = {
					copy = "echo '" .. combo .. "' | wl-copy && notify-send 'Copied' '" .. combo .. "'",
				},
			})
		end
	end

	file:close()
end

function GetEntries()
	local entries = {}
	local home = os.getenv("HOME") or ""
	local keybindings_dir = home .. "/.local/share/dotfiles/default/hypr/lua/"

	local hardware_handle = io.open(home .. "/.config/hypr/hardware", "r")
	local hardware = hardware_handle and hardware_handle:read("*l") or "desktop"
	if hardware_handle then
		hardware_handle:close()
	end
	local is_laptop = hardware == "laptop" or hardware == "laptop-nvidia"

	add_bindings(entries, keybindings_dir .. "keybindings.lua")
	add_bindings(entries, keybindings_dir .. (is_laptop and "laptop-keybindings.lua" or "desktop-keybindings.lua"))
	table.insert(entries, {
		Text = "SUPER + [0-9]" .. string.rep(" ", 22) .. "→ Open workspace 1-10",
		Value = "SUPER + [0-9] → Open workspace 1-10",
	})
	table.insert(entries, {
		Text = "SUPER + SHIFT + [0-9]" .. string.rep(" ", 14) .. "→ Move active window to workspace 1-10",
		Value = "SUPER + SHIFT + [0-9] → Move active window to workspace 1-10",
	})

	if #entries == 0 then
		table.insert(entries, {
			Text = "No keybindings found",
			Subtext = "Check your Hyprland config",
			Value = "",
		})
	end

	return entries
end
