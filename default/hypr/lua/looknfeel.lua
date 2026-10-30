hl.config({
	general = {
		gaps_in = 1,
		gaps_out = 2,
		border_size = 1,
		layout = "dwindle",
		resize_on_border = false,
	},

	decoration = {
		rounding = 0,
		rounding_power = 1,

		active_opacity = 0.95,
		inactive_opacity = 0.9,

		blur = {
			enabled = true,
			size = 4,
			passes = 3,
			new_optimizations = true,
			ignore_opacity = true,
		},

		shadow = {
			enabled = true,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},

	binds = {
		workspace_back_and_forth = true,
		allow_workspace_cycles = true,
		pass_mouse_when_bound = false,
	},

	misc = {
		disable_hyprland_logo = true,
	},
})

hl.curve("easeOut", { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } })
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2.8, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.2, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })

hl.animation({ leaf = "border", enabled = true, speed = 3.0, bezier = "easeOutQuint" })
hl.animation({ leaf = "fade", enabled = true, speed = 2.8, bezier = "quick" })

hl.animation({ leaf = "layersIn", enabled = true, speed = 2.4, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2.4, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 0.2, bezier = "quick" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.8, bezier = "easeOut" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "easeOut", style = "slide" })
