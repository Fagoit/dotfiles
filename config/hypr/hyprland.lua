---------------
--- MODULES ---
---------------

local home = os.getenv("HOME")
local dotfiles = home .. "/.local/share/dotfiles"
local hypr = home .. "/.config/hypr"

local function exists(path)
	local file = io.open(path, "r")
	if file then
		file:close()
		return true
	end
	return false
end

-- Each require runs in its own scope, so an error in one module does not stop the others.

--- Do not change
require(dotfiles .. "/default/hypr/lua/env")
require(dotfiles .. "/default/hypr/lua/autostart")
require(dotfiles .. "/default/hypr/lua/keybindings")
require(dotfiles .. "/default/hypr/lua/looknfeel")
require(dotfiles .. "/default/hypr/lua/rules")

-- Theme colors; fall back to the main theme when the active theme has no Lua file yet.
if exists(dotfiles .. "/current/theme/hyprland.lua") then
	require(dotfiles .. "/current/theme/hyprland")
else
	require(dotfiles .. "/themes/main/hyprland")
end

--- Can change these, create more files and require them here if needed
require(hypr .. "/conf/monitors")
require(hypr .. "/conf/input")
-- require(hypr .. "/my_custom_file")
