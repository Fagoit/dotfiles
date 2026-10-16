local hl = hl

-- Window rules from the former windowrules.conf.
hl.window_rule({ match = { tag = "floating-window" }, float = true })
hl.window_rule({ match = { tag = "floating-window" }, center = true })
hl.window_rule({ match = { tag = "floating-window" }, size = { 800, 600 } })
hl.window_rule({
	match = {
		class = "^(local\\.xdg-desktop-portal-gtk|local\\.sublime_text|local\\.DesktopEditors|local\\.org\\.gnome\\.Nautilus)$",
		title = "^(Open.*Files?|Open [Ff]older.*|Save.*Files?|Save.*As|Save|All Files)$",
	},
	tag = "+floating-window",
})
hl.window_rule({ match = { class = "([window])" }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { class = "^(local\\.bluetui|local\\.impala|local\\.wiremix|local\\.org\\.gnome\\.NautilusPreviewer|local\\.com\\.gabm\\.satty)$" }, float = true })
hl.window_rule({ match = { class = "^(local\\.bluetui|local\\.impala|local\\.wiremix|local\\.org\\.gnome\\.NautilusPreviewer|local\\.com\\.gabm\\.satty)$" }, center = true })
hl.window_rule({ match = { class = "^(local\\.bluetui|local\\.impala|local\\.wiremix|local\\.org\\.gnome\\.NautilusPreviewer|local\\.com\\.gabm\\.satty)$" }, size = { 800, 600 } })
hl.window_rule({ match = { class = "^(local\\.floating)$" }, float = true })
hl.window_rule({ match = { class = "^(local\\.floating)$" }, center = true })
hl.window_rule({ match = { class = "^(local\\.floating)$" }, size = { 800, 600 } })
hl.window_rule({ match = { class = "([cC]hrom(e|ium)|[bB]rave-browser|Microsoft-edge|Vivaldi-stable|helium-browser)" }, tag = "+chromium-based-browser" })
hl.window_rule({ match = { class = "([fF]irefox|zen|zen-browser|zen-bin|librewolf)" }, tag = "+firefox-based-browser" })
hl.window_rule({ match = { tag = "chromium-based-browser" }, tile = true })
hl.window_rule({ match = { tag = "chromium-based-browser" }, opacity = "1 override 0.97 override" })
hl.window_rule({ match = { tag = "firefox-based-browser" }, opacity = "1 override 0.97 override" })
hl.window_rule({ match = { initial_title = "((?i)(?:[a-z0-9-]+\\.)*youtube\\.com_/|app\\.zoom\\.us_/wc/home)" }, opacity = "1.0 override 1.0 override" })
hl.window_rule({ match = { class = "^(zoom|vlc|mpv|org\\.kde\\.kdenlive|com\\.obsproject\\.Studio|com\\.github\\.PintaProject\\.Pinta|imv|org\\.gnome\\.NautilusPreviewer)$" }, opacity = "1 override 1 override" })
hl.window_rule({ match = { class = "(org.tinte.Tinte)" }, float = true })
hl.window_rule({ match = { class = "(org.tinte.Tinte)" }, size = { 900, 700 } })
hl.window_rule({ match = { class = "(org.tinte.Tinte)" }, center = true })

-- Layer rules from the former layerrules.conf.
for _, namespace in ipairs({ "waybar", "launcher", "notifications" }) do
	hl.layer_rule({ match = { namespace = "^" .. namespace .. "$" }, blur = true })
end
hl.layer_rule({ match = { namespace = "^waybar$" }, ignore_alpha = 0.2 })
hl.layer_rule({ match = { namespace = "^launcher$" }, ignore_alpha = 1 })
hl.layer_rule({ match = { namespace = "^notifications$" }, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "^hyprpicker$" }, no_anim = true })
hl.layer_rule({ match = { namespace = "^gtk-layer-shell$" }, no_anim = true })

return true
