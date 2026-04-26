Name = "keybindings"
NamePretty = "Keybindings"
HideFromProviderlist = true
Cache = false
Parent = "menu"

function GetEntries()
	local entries = {}
	local home = os.getenv("HOME") or ""
	local config_file = home .. "/.xbindkeysrc"

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

	local pending_command = nil

	for line in file:lines() do
		local command = line:match('^%s*"(.-)"%s*$')
		if command then
			pending_command = command
		elseif pending_command then
			local key_combo = line:match("^%s*(.-)%s*$")
			if key_combo ~= "" and not key_combo:match("^#") then
				table.insert(entries, {
					Text = key_combo .. " -> " .. pending_command,
					Value = key_combo .. " -> " .. pending_command,
					Actions = {
						copy = "printf '%s' '"
							.. key_combo
							.. "' | xclip -selection clipboard && notify-send 'Copied' '"
							.. key_combo
							.. "'",
					},
				})
				pending_command = nil
			end
		end
	end

	file:close()

	if #entries == 0 then
		table.insert(entries, {
			Text = "No keybindings found",
			Subtext = "Check ~/.xbindkeysrc",
			Value = "",
		})
	end

	return entries
end
