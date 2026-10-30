-- Hardware profile written by install/setup-by-hardware to ~/.config/hypr/hardware.
-- Known values: desktop, laptop, nvidia, laptop-nvidia.

local profile = "desktop"
local file = io.open(os.getenv("HOME") .. "/.config/hypr/hardware", "r")
if file then
	profile = file:read("*l") or profile
	file:close()
end

return {
	profile = profile,
	laptop = profile == "laptop" or profile == "laptop-nvidia",
	nvidia = profile == "nvidia" or profile == "laptop-nvidia",
}
