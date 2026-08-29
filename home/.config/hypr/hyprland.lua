-- Nordic Dark desktop configuration for Hyprland 0.56+.
-- This machine uses the native Lua configuration format.

local terminal = "alacritty"
local fileManager = "thunar"
local browser = "brave-origin"
local editor = "code"
local launcher = "pkill -x rofi || rofi -show drun -config \"$HOME/.config/rofi/config.rasi\""
local clipboard = "$HOME/.local/bin/hypr-clipboard"
local wallpaper = "$HOME/.local/bin/hypr-wallpaper"
local mainMod = "SUPER"

-- Let Hyprland choose the active output and preferred mode without assigning
-- workspaces to a monitor. Workspaces remain attached to their active output.
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("HYPRCURSOR_THEME", "Adwaita")
hl.env("GTK_THEME", "Nordic:dark")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")

hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 12,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(88c0d0ff)", "rgba(81a1c1ff)" }, angle = 45 },
            inactive_border = "rgba(4c566acc)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 12,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.96,
        shadow = {
            enabled = true,
            range = 8,
            render_power = 3,
            color = "rgba(00000080)",
        },
        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            noise = 0.02,
            contrast = 1.0,
            brightness = 0.85,
            vibrancy = 0.12,
            ignore_opacity = true,
            popups = true,
            popups_ignorealpha = 0.2,
            new_optimizations = true,
        },
    },

    animations = { enabled = true },

    misc = {
        background_color = "rgb(2e3440)",
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        animate_manual_resizes = true,
        animate_mouse_windowdragging = true,
    },

    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = { natural_scroll = false },
    },

    dwindle = {
        preserve_split = true,
        smart_split = true,
    },

    binds = {
        allow_workspace_cycles = true,
        workspace_back_and_forth = true,
    },
})

-- One animation vocabulary keeps windows, layers, workspaces and movement in sync.
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1.0 }, { 0.30, 1.0 } } })
hl.curve("easeInOut", { type = "bezier", points = { { 0.65, 0.0 }, { 0.35, 1.0 } } })
hl.curve("softOut", { type = "bezier", points = { { 0.22, 1.0 }, { 0.36, 1.0 } } })
hl.curve("linear", { type = "bezier", points = { { 0.0, 0.0 }, { 1.0, 1.0 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "easeOutExpo", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "softOut", style = "popin 85%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "easeInOut", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "easeInOut" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "softOut" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 5, bezier = "easeOutExpo" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 5, bezier = "softOut" })
hl.animation({ leaf = "layers", enabled = true, speed = 5, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 5, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 5, bezier = "softOut", style = "slide" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 5, bezier = "easeOutExpo" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 5, bezier = "softOut" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "easeInOut", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 5, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 5, bezier = "softOut", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 5, bezier = "easeOutExpo" })

-- Layer surfaces get the same fade timing as application windows.
hl.layer_rule({
    name = "waybar-glass",
    match = { namespace = "^waybar$" },
    blur = true,
    ignore_alpha = 0.2,
    animation = "fade",
})

hl.layer_rule({
    name = "rofi-glass",
    match = { namespace = "^rofi$" },
    blur = true,
    blur_popups = true,
    ignore_alpha = 0.15,
    animation = "fade",
})

for _, namespace in ipairs({ "swaync-control-center", "swaync-notification-window", "notifications" }) do
    hl.layer_rule({
        name = namespace .. "-glass",
        match = { namespace = "^" .. namespace .. "$" },
        blur = true,
        blur_popups = true,
        ignore_alpha = 0.15,
        animation = "fade",
    })
end

hl.layer_rule({
    name = "wlogout-glass",
    match = { namespace = "^logout_dialog$" },
    blur = true,
    ignore_alpha = 0.15,
    animation = "fade",
})

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "no-anim-ffplay",
    match = { class = "^(ffplay|[Ff]fplay|SDL_App)$" },
    no_anim = true,
    no_shadow = true,
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

hl.on("hyprland.start", function()
    -- Long-running processes are launched once per Hyprland session.
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd(wallpaper)
    hl.exec_cmd("hypridle -c $HOME/.config/hypr/hypridle.conf")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Keep GTK/GNOME-aware applications on the same dark color scheme.
    hl.exec_cmd("command -v gsettings >/dev/null 2>&1 && gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
    hl.exec_cmd("command -v gsettings >/dev/null 2>&1 && gsettings set org.gnome.desktop.interface gtk-theme Nordic")
    hl.exec_cmd("command -v gsettings >/dev/null 2>&1 && gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark")
    hl.exec_cmd("command -v gsettings >/dev/null 2>&1 && gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 13'")
end)

-- Super by itself opens the launcher on key release. SUPER_L is the release key,
-- so regular SUPER+key combinations continue to work.
hl.bind(mainMod .. " + SUPER_L", hl.dsp.exec_cmd(launcher), {
    release = true,
    description = "Open application launcher",
})

hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser), { description = "Open Brave Origin" })
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Close active window" })
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal), { description = "Open terminal" })
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal), { description = "Open terminal" })
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(editor), { description = "Open VSCode" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle", window = "activewindow" }), { description = "Toggle fullscreen" })
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(clipboard), { description = "Open clipboard history" })
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client --toggle-panel --skip-wait"), { description = "Toggle notification center" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager), { description = "Open file manager" })
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"), { description = "Lock screen" })
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("wlogout"), { description = "Open power menu" })
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(wallpaper), { description = "Change wallpaper" })
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("$HOME/.local/bin/hypr-wallpaper-picker"), { description = "Pick wallpaper" })
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("killall -SIGUSR2 waybar"), { description = "Reload Waybar" })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("$HOME/.local/bin/hypr-screenshot"), { description = "Copy screenshot selection" })

-- Workspace 1-10. There is deliberately no monitor selector here.
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }), { description = "Focus workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), { description = "Move window to workspace " .. i })
    hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i }), { description = "Move window to workspace " .. i })
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Next workspace" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Previous workspace" })

hl.bind(mainMod .. " + left", hl.dsp.focus({ workspace = "e-1" }), { description = "Previous workspace" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ workspace = "e+1" }), { description = "Next workspace" })
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
