-- Set programs
local terminal = "kitty"
local fileManager = "nautilus"
local menu = "rofi -show drun"
local browser = "helium"
local screenShot = "~/.config/hypr/utility/screenshot.sh"
local tmuxWorkspace = "kitty -e tmux new-session -A -s workspace"
local toggleWaybar = "pkill -SIGUSR1 waybar"
local toggleNightMode = "~/.config/hypr/utility/toggle-nightmode.sh"

local mainMod = "SUPER"
local secondMod = "SUPER + SHIFT"

-- binding for each programs
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(secondMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(secondMod .. " + RETURN", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + ALT + RETURN", hl.dsp.exec_cmd(tmuxWorkspace))
hl.bind(mainMod .. " + CTRL + SPACE", hl.dsp.exec_cmd(toggleWaybar))
hl.bind(mainMod .. " + CTRL + N", hl.dsp.exec_cmd(toggleNightMode))

-- utility helper
hl.bind(secondMod .. " + S", hl.dsp.exec_cmd(screenShot))

-- Hyprland functions
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(
	mainMod .. " + R",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("loginctl lock-session"))

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + C", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Resize window with ALT + hjkl
hl.bind("ALT + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind("ALT + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind("ALT + K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind("ALT + J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

-- Move window pane with secondMod + hjkl
hl.bind(secondMod .. " + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(secondMod .. " + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(secondMod .. " + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(secondMod .. " + J", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
