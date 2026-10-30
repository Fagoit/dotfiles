-- Shared keybindings for every hardware profile.
-- Keep one hl.bind per line with a description: the Elephant keybindings menu
-- (config/elephant/menus/dynamic/keybindings.lua) parses this file line by line.

local dotfiles = os.getenv("HOME") .. "/.local/share/dotfiles"
local hardware = require(dotfiles .. "/default/hypr/lua/hardware")

local terminal = "ghostty"

-- Toggle all windows on the active workspace between floating and tiled
local function toggle_workspace_float()
	local workspace = hl.get_active_workspace()
	if not workspace then
		return
	end
	local windows = hl.get_workspace_windows(workspace)
	local all_floating = true
	for _, window in ipairs(windows) do
		if not window.floating then
			all_floating = false
			break
		end
	end
	local action = all_floating and "disable" or "enable"
	for _, window in ipairs(windows) do
		hl.dispatch(hl.dsp.window.float({ window = window, action = action }))
	end
end

-- Applications
hl.bind("SUPER + Q", hl.dsp.exec_cmd("uwsm app -- " .. terminal), { description = "Launch terminal" })
hl.bind("SUPER + B", hl.dsp.exec_cmd("uwsm app -- librewolf"), { description = "Launch browser" })
hl.bind("SUPER + E", hl.dsp.exec_cmd("uwsm app -- nautilus --new-window"), { description = "Launch file manager" })
hl.bind("SUPER + P", hl.dsp.exec_cmd("uwsm app -- spotify-launcher"), { description = "Launch spotify" })
hl.bind("SUPER + O", hl.dsp.exec_cmd("uwsm app -- obsidian"), { description = "Launch obsidian" })

-- Windows
hl.bind("SUPER + W", hl.dsp.window.close(), { description = "Kill active window" })
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"), { description = "Quit active window and all open instances" })
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), { description = "Set active window to fullscreen" })
hl.bind("SUPER + M", hl.dsp.window.fullscreen({ mode = "maximized" }), { description = "Maximize window" })
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle active window into floating mode" })
hl.bind("SUPER + SHIFT + T", toggle_workspace_float, { description = "Toggle all windows into floating mode" })
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"), { description = "Toggle split (dwindle)" })
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }), { description = "Move focus left" })
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }), { description = "Move focus right" })
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }), { description = "Move focus up" })
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }), { description = "Move focus down" })
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window with the mouse" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window with the mouse" })
hl.bind("SUPER + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { description = "Increase window width with keyboard" })
hl.bind("SUPER + SHIFT + left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { description = "Reduce window width with keyboard" })
hl.bind("SUPER + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { description = "Increase window height with keyboard" })
hl.bind("SUPER + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { description = "Reduce window height with keyboard" })
hl.bind("SUPER + G", hl.dsp.group.toggle(), { description = "Toggle window group" })
hl.bind("SUPER + K", hl.dsp.layout("swapsplit"), { description = "Swap split halves (dwindle)" })
hl.bind("SUPER + ALT + left", hl.dsp.window.swap({ direction = "left" }), { description = "Swap tiled window left" })
hl.bind("SUPER + ALT + right", hl.dsp.window.swap({ direction = "right" }), { description = "Swap tiled window right" })
hl.bind("SUPER + ALT + up", hl.dsp.window.swap({ direction = "up" }), { description = "Swap tiled window up" })
hl.bind("SUPER + ALT + down", hl.dsp.window.swap({ direction = "down" }), { description = "Swap tiled window down" })
hl.bind("ALT + Tab", function() hl.dispatch(hl.dsp.window.cycle_next()) hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" })) end, { repeating = true, description = "Cycle between windows" })

-- Actions
hl.bind("SUPER + CTRL + N", hl.dsp.exec_cmd("sunsetr-toggle"), { description = "Toggle nightlight" })

-- Walker and Elephant
hl.bind("SUPER + R", hl.dsp.exec_cmd("walker"), { description = "Launch application launcher" })
hl.bind("SUPER + Escape", hl.dsp.exec_cmd("walker --theme menus -m menus:system --width 150 --minheight 1 --maxheight 600"), { description = "System menu" })
hl.bind("SUPER + SHIFT + s", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots"), { description = "Screenshot region (save + clipboard)" })
hl.bind("SUPER + Print", hl.dsp.exec_cmd("walker --theme menus -m menus:screenshots --width 295 --minheight 1 --maxheight 600"), { description = "Screenshot menu" })
hl.bind("SUPER + V", hl.dsp.exec_cmd("walker -m clipboard"), { description = "Clipboard history" })
hl.bind("SUPER + ALT + SPACE", hl.dsp.exec_cmd("walker --theme menus -m menus:menu --width 295 --minheight 1 --maxheight 900"), { description = "Main menu" })
hl.bind("SUPER + CTRL + B", hl.dsp.exec_cmd("walker -t menus -m menus:bookmarks --maxwidth 300 --minwidth 180"), { description = "Bookmarks menu" })

-- Workspaces: SUPER + [0-9] opens workspace 1-10, SUPER + SHIFT + [0-9] moves the active window there
for i = 1, 10 do
	local key = i % 10
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }), { description = "Open workspace " .. i })
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), { description = "Move active window to workspace " .. i })
end

hl.bind("SUPER + Tab", hl.dsp.focus({ workspace = "m+1" }), { description = "Open next workspace" })
hl.bind("SUPER + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }), { description = "Open previous workspace" })

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Open next workspace" })
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Open previous workspace" })
hl.bind("SUPER + CTRL + down", hl.dsp.focus({ workspace = "empty" }), { description = "Open the next empty workspace" })

-- Volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume +5"), { repeating = true, description = "Volume up" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume -5"), { repeating = true, description = "Volume down" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { description = "Toggle mute" })

-- Media (requires playerctl)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), { description = "Play/pause media" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), { description = "Play/pause media" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("swayosd-client --playerctl next"), { description = "Next track" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("swayosd-client --playerctl previous"), { description = "Previous track" })

-- Lock
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("hyprlock"), { description = "Lock screen" })

-- Brightness differs per hardware profile
require(dotfiles .. "/default/hypr/lua/" .. (hardware.laptop and "laptop" or "desktop") .. "-keybindings")
