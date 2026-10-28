-- Android Emulator
hl.window_rule({
	name = "android-emulator",
	match = { class = "^(Emulator)$" },
	float = true,
})

-- Float utility app
hl.window_rule({
	match = { class = "^float-app$" },
	float = true,
	size = { 850, 550 },
	center = true,
})

-- LocalSend
hl.window_rule({
	name = "localsend",
	match = { class = "^(org\\.localsend\\.localsend_app)$" },
	float = true,
	size = { 850, 550 },
	center = true,
})

-- Default hyprland window rule
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})
