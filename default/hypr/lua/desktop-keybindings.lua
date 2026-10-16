local main = "SUPER"
local terminal = "ghostty"

local bindings = {
	{ key = main .. " + Q", command = "uwsm app -- " .. terminal },
	{ key = main .. " + B", command = "uwsm app -- librewolf" },
	{ key = main .. " + E", command = "uwsm app -- nautilus --new-window" },
	{ key = main .. " + P", command = "uwsm app -- spotify-launcher" },
	{ key = main .. " + O", command = "uwsm app -- obsidian" },
	{ key = main .. " + W", command = "hyprctl dispatch killactive" },
	{ key = main .. " + F", command = "hyprctl dispatch fullscreen" },
	{ key = main .. " + M", command = "hyprctl dispatch fullscreen" },
	{ key = main .. " + T", command = "hyprctl dispatch togglefloating" },
	{ key = main .. " + SHIFT + T", command = "hyprctl dispatch workspaceopt allfloat" },
	{ key = main .. " + J", command = "hyprctl dispatch layoutmsg togglesplit" },
	{ key = main .. " + LEFT", command = "hyprctl dispatch movefocus l" },
	{ key = main .. " + RIGHT", command = "hyprctl dispatch movefocus r" },
	{ key = main .. " + UP", command = "hyprctl dispatch movefocus u" },
	{ key = main .. " + DOWN", command = "hyprctl dispatch movefocus d" },
	{ key = main .. " + SHIFT + RIGHT", command = "hyprctl dispatch resizeactive 100 0" },
	{ key = main .. " + SHIFT + LEFT", command = "hyprctl dispatch resizeactive -100 0" },
	{ key = main .. " + SHIFT + DOWN", command = "hyprctl dispatch resizeactive 0 100" },
	{ key = main .. " + SHIFT + UP", command = "hyprctl dispatch resizeactive 0 -100" },
	{ key = main .. " + G", command = "hyprctl dispatch togglegroup" },
	{ key = main .. " + K", command = "hyprctl dispatch layoutmsg swapsplit" },
	{ key = main .. " + ALT + LEFT", command = "hyprctl dispatch swapwindow l" },
	{ key = main .. " + ALT + RIGHT", command = "hyprctl dispatch swapwindow r" },
	{ key = main .. " + ALT + UP", command = "hyprctl dispatch swapwindow u" },
	{ key = main .. " + ALT + DOWN", command = "hyprctl dispatch swapwindow d" },
	{ key = main .. " + CTRL + N", command = "sunsetr-toggle" },
	{ key = main .. " + R", command = "walker" },
	{ key = main .. " + ESCAPE", command = "walker --theme menus -m menus:system --width 150 --minheight 1 --maxheight 600" },
	{ key = main .. " + SHIFT + S", command = "hyprshot -m region -o ~/Pictures/Screenshots" },
	{ key = main .. " + PRINT", command = "walker --theme menus -m menus:screenshots --width 295 --minheight 1 --maxheight 600" },
	{ key = main .. " + V", command = "walker -m clipboard" },
	{ key = main .. " + ALT + SPACE", command = "walker --theme menus -m menus:menu --width 295 --minheight 1 --maxheight 900" },
	{ key = main .. " + CTRL + B", command = "walker -t menus -m menus:bookmarks --maxwidth 300 --minwidth 180" },
	{ key = main .. " + TAB", command = "hyprctl dispatch workspace m+1" },
	{ key = main .. " + SHIFT + TAB", command = "hyprctl dispatch workspace m-1" },
	{ key = main .. " + CTRL + DOWN", command = "hyprctl dispatch workspace empty" },
	{ key = "XF86MonBrightnessUp", command = "ddcutil setvcp 10 + 5 && notify-send Brightness \"$(ddcutil getvcp 10 | awk '/Brightness/ {gsub(/,/, \"\", $9); print $9}')%\"" },
	{ key = "XF86MonBrightnessDown", command = "ddcutil setvcp 10 - 5 && notify-send Brightness \"$(ddcutil getvcp 10 | awk '/Brightness/ {gsub(/,/, \"\", $9); print $9}')%\"" },
	{ key = "XF86MonBrightnessUp", command = "ddcutil setvcp 10 + 5 && notify-send Brightness \"$(ddcutil getvcp 10 | awk '/Brightness/ {gsub(/,/, \"\", $9); print $9}')%\"" },
	{ key = "XF86MonBrightnessDown", command = "ddcutil setvcp 10 - 5 && notify-send Brightness \"$(ddcutil getvcp 10 | awk '/Brightness/ {gsub(/,/, \"\", $9); print $9}')%\"" },
	{ key = "XF86AudioRaiseVolume", command = "swayosd-client --output-volume +5" },
	{ key = "XF86AudioLowerVolume", command = "swayosd-client --output-volume -5" },
	{ key = "XF86AudioMute", command = "swayosd-client --output-volume mute-toggle" },
	{ key = "XF86AudioPlay", command = "swayosd-client --playerctl play-pause" },
	{ key = "XF86AudioPause", command = "swayosd-client --playerctl play-pause" },
	{ key = "XF86AudioNext", command = "swayosd-client --playerctl next" },
	{ key = "XF86AudioPrev", command = "swayosd-client --playerctl previous" },
	{ key = "SUPER + SHIFT + L", command = "hyprlock" },
}

for i = 1, 10 do
	local key = i == 10 and "0" or tostring(i)
	table.insert(bindings, { key = main .. " + " .. key, command = "hyprctl dispatch workspace " .. i })
	table.insert(bindings, { key = main .. " + SHIFT + " .. key, command = "hyprctl dispatch movetoworkspace " .. i })
end

return bindings
