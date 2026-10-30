local hardware = require(os.getenv("HOME") .. "/.local/share/dotfiles/default/hypr/lua/hardware")

-- Cursor size
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", hardware.nvidia and "24" or "12")

-- Force all apps to use Wayland
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GDK_SCALE", "1")

-- Allow better support for screen sharing
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Nvidia
if hardware.nvidia then
	hl.env("NVD_BACKEND", "direct")
	hl.env("LIBVA_DRIVER_NAME", "nvidia")
	hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
	hl.env("GBM_BACKEND", "nvidia-drm")
end

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
	-- Don't show update on first launch
	ecosystem = {
		no_update_news = true,
	},
})
