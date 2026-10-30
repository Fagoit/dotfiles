local dotfiles = os.getenv("HOME") .. "/.local/share/dotfiles"

hl.on("hyprland.start", function()
	-- ===== UWSM Check =====
	hl.exec_cmd(dotfiles .. "/bin/check-uwsm")

	-- ===== Theme/cursor settings =====
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

	-- ===== Wallpaper =====
	-- hyprpaper.service handles static images; this restores animated wallpapers
	-- (mpvpaper) and refreshes the lock-screen still frame.
	hl.exec_cmd(dotfiles .. "/bin/wallpaper-restore")

	-- ===== Daemons/Services =====
	-- Managed by systemd user services (graphical-session.target)
	-- See: systemctl --user list-units --type=service
end)
