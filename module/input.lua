hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		repeat_delay = 250,
		repeat_rate = 50,

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
		},
	},
	cursor = {
		no_hardware_cursors = true,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "lxddz-2.4g-wireless-device-1",
	sensitivity = -0.15,
	accel_profile = "flat",
})
