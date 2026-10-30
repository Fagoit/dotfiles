-- Floating windows
hl.window_rule({ match = { tag = "floating-window" }, float = true, center = true, size = { 800, 600 } })
hl.window_rule({
	match = {
		class = "^(local\\.xdg-desktop-portal-gtk|local\\.sublime_text|local\\.DesktopEditors|local\\.org\\.gnome\\.Nautilus)$",
		title = "^(Open.*Files?|Open [Ff]older.*|Save.*Files?|Save.*As|Save|All Files)$",
	},
	tag = "+floating-window",
})

-- idleinhibit
hl.window_rule({ match = { class = "([window])" }, idle_inhibit = "fullscreen" })

-- CLI tools
hl.window_rule({
	match = { class = "^(local\\.bluetui|local\\.impala|local\\.wiremix|local\\.org\\.gnome\\.NautilusPreviewer|local\\.com\\.gabm\\.satty)$" },
	float = true,
	center = true,
	size = { 800, 600 },
})

-- Floating generic class
hl.window_rule({ match = { class = "^(local\\.floating)$" }, float = true, center = true, size = { 800, 600 } })

-- Browser types
hl.window_rule({ match = { class = "([cC]hrom(e|ium)|[bB]rave-browser|Microsoft-edge|Vivaldi-stable|helium-browser)" }, tag = "+chromium-based-browser" })
hl.window_rule({ match = { class = "([fF]irefox|zen|zen-browser|zen-bin|librewolf)" }, tag = "+firefox-based-browser" })

-- Force chromium-based browsers into a tile to deal with --app bug
hl.window_rule({ match = { tag = "chromium-based-browser" }, tile = true })

-- Only a subtle opacity change, but not for video sites
hl.window_rule({ match = { tag = "chromium-based-browser" }, opacity = "1 0.97" })
hl.window_rule({ match = { tag = "firefox-based-browser" }, opacity = "1 0.97" })

-- Some video sites should never have opacity applied to them
hl.window_rule({ match = { initial_title = "((?i)(?:[a-z0-9-]+\\.)*youtube\\.com_/|app\\.zoom\\.us_/wc/home)" }, opacity = "1.0 1.0" })

-- No transparency on media windows
hl.window_rule({
	match = { class = "^(zoom|vlc|mpv|org.kde.kdenlive|com.obsproject.Studio|com.github.PintaProject.Pinta|imv|org.gnome.NautilusPreviewer)$" },
	opacity = "1 1",
})

-- App specific tweaks

-- tinte
hl.window_rule({ match = { class = "(org.tinte.Tinte)" }, float = true, size = { 900, 700 }, center = true })

-- Layer rules
hl.layer_rule({ match = { namespace = "^(waybar)$" }, blur = true, ignore_alpha = 0.2 })
hl.layer_rule({ match = { namespace = "^(launcher)$" }, blur = true, ignore_alpha = 1 })
hl.layer_rule({ match = { namespace = "^(notifications)$" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "^(hyprpicker)$" }, no_anim = true })
hl.layer_rule({ match = { namespace = "^(gtk-layer-shell)$" }, no_anim = true })
hl.layer_rule({ name = "no_anim_for_selection", match = { namespace = "selection" }, no_anim = true })
