-- 1. GENTOO OPENRC & SESSION TRACKING
local uid = os.getenv("UID") or "1000"
local runtime_dir = "/run/user/" .. uid
hl.env("XDG_RUNTIME_DIR", runtime_dir)
hl.env("DBUS_SESSION_BUS_ADDRESS", "unix:path=" .. runtime_dir .. "/bus")

-- 2. GRAPHICS & INTEL HARDWARE ACCELERATION
hl.env("LIBVA_DRIVER_NAME", "iHD")
hl.env("VDPAU_DRIVER", "va_gl")
hl.env("LIBVA_DRIVERS_PATH", "/usr/lib64/va/drivers")

-- 3. WAYLAND TOOLKIT FORCING
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")

-- 4. CURSOR & APPS THEMING
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- 5. XWAYLAND BLUR FIX
hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})
