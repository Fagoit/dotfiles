Name = "omz-themes"
NamePretty = "OMZ themes"
HideFromProviderlist = true
Cache = false
Parent = "themes"

local themes = {
	{ name = "robbyrussell", desc = "Default — clean arrow prompt" },
	{ name = "agnoster", desc = "Powerline — full segment style" },
	{ name = "af-magic", desc = "Two-line — clean and informative" },
	{ name = "avit", desc = "Minimal — subtle and lightweight" },
	{ name = "bira", desc = "Two-line — colorful with user@host" },
	{ name = "bureau", desc = "Two-line — git-aware with clock" },
	{ name = "candy", desc = "Colorful — bright and playful" },
	{ name = "clean", desc = "Simple — hostname and directory" },
	{ name = "cloud", desc = "Minimal — cloud prompt symbol" },
	{ name = "dpoggi", desc = "Minimal — clean single-line" },
	{ name = "dst", desc = "Simple — lightweight two-line" },
	{ name = "eastwood", desc = "Compact — single-line with git" },
	{ name = "fino", desc = "Elegant — detailed two-line" },
	{ name = "fino-time", desc = "Elegant — fino with timestamp" },
	{ name = "fox", desc = "Clean — minimal with colors" },
	{ name = "frisk", desc = "Fun — colorful with git info" },
	{ name = "frontcube", desc = "Cube — retro terminal style" },
	{ name = "gallois", desc = "Classic — ruby/git aware" },
	{ name = "gnzh", desc = "Two-line — powerline-lite style" },
	{ name = "half-life", desc = "Gaming — lambda prompt" },
	{ name = "jonathan", desc = "Rich — detailed status bar" },
	{ name = "jtriley", desc = "Clean — host and path" },
	{ name = "kardan", desc = "Minimal — directory focused" },
	{ name = "mh", desc = "Simple — clean with return code" },
	{ name = "mira", desc = "Colorful — minimal two-line" },
	{ name = "miloshadzic", desc = "Minimal — lambda with git" },
	{ name = "nanotech", desc = "Compact — tech-inspired" },
	{ name = "refined", desc = "Modern — pure-inspired, subtle" },
	{ name = "simple", desc = "Bare — as minimal as it gets" },
	{ name = "sorin", desc = "Balanced — clean with git" },
	{ name = "steeef", desc = "Two-line — python/ruby/git aware" },
	{ name = "sunrise", desc = "Colorful — detailed two-line" },
	{ name = "wedisagree", desc = "Fun — opinonated single-line" },
	{ name = "ys", desc = "Hacker — detailed system info" },
}

function GetEntries()
	local entries = {}
	local home = os.getenv("HOME") or ""
	local init_file = home .. "/.local/share/dotfiles/default/zshrc/init"

	local current_handle = io.popen("grep '^ZSH_THEME=' '" .. init_file .. "' 2>/dev/null | sed 's/ZSH_THEME=\"//;s/\"//'")
	local current_theme = ""
	if current_handle then
		current_theme = current_handle:read("*l") or ""
		current_handle:close()
	end

	local starship_active = false
	local star_handle = io.popen("grep -c 'starship init zsh' '" .. init_file .. "' 2>/dev/null")
	if star_handle then
		local count = star_handle:read("*l") or "0"
		star_handle:close()
		local commented = io.popen("grep -c '^#.*starship init zsh' '" .. init_file .. "' 2>/dev/null")
		if commented then
			local c = commented:read("*l") or "0"
			commented:close()
			starship_active = (tonumber(count) or 0) > (tonumber(c) or 0)
		end
	end

	table.insert(entries, {
		Text = (starship_active and "* " or "") .. "Starship prompt",
		Subtext = starship_active and "Active — overrides OMZ theme" or "Disabled — using OMZ theme",
		Value = "starship",
		Icon = "🚀",
		state = starship_active and { "current" } or nil,
		Actions = {
			apply = starship_active
				and "sed -i '/^if command -v starship/,/^fi$/{s/^/# /}' '"
					.. init_file
					.. "' && notify-send 'Shell Prompt' 'Starship disabled — OMZ theme active (restart shell)'"
				or "sed -i '/^# if command -v starship/,/^# fi$/{s/^# //}' '"
					.. init_file
					.. "' && notify-send 'Shell Prompt' 'Starship enabled (restart shell)'",
		},
	})

	for _, theme in ipairs(themes) do
		local is_current = (theme.name == current_theme)
		local prefix = (is_current and not starship_active) and "* " or ""

		table.insert(entries, {
			Text = prefix .. theme.name,
			Subtext = theme.desc .. (is_current and starship_active and " (set but hidden by Starship)" or ""),
			Value = theme.name,
			Actions = {
				apply = "sed -i 's/^ZSH_THEME=\".*\"/ZSH_THEME=\""
					.. theme.name
					.. "\"/' '"
					.. init_file
					.. "' && notify-send 'OMZ Theme' 'Switched to "
					.. theme.name
					.. (starship_active and " (disable Starship to see it)" or " (restart shell)")
					.. "'",
			},
		})
	end

	return entries
end
