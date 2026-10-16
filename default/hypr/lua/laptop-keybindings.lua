local bindings = dofile((os.getenv("HOME") or "") .. "/.local/share/dotfiles/default/hypr/lua/desktop-keybindings.lua")

for _, binding in ipairs(bindings) do
	if binding.key == "XF86MonBrightnessUp" then
		binding.command = "swayosd-client --brightness raise"
	elseif binding.key == "XF86MonBrightnessDown" then
		binding.command = "swayosd-client --brightness lower"
	end
end

table.insert(bindings, { key = "XF86MonBrightnessUp", command = "swayosd-client --brightness raise" })
table.insert(bindings, { key = "XF86MonBrightnessDown", command = "swayosd-client --brightness lower" })

return bindings
