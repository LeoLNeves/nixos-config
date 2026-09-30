-- Hyprland config (Lua format, Hyprland 0.55+)
-- Docs: https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

-------------------
---- AUTOSTART ----
-------------------

-- hyprpaper is not listed here: home-manager already starts it as a service
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        border_size     = 0,
        gaps_in         = 5,
        gaps_out        = 10,
        gaps_workspaces = -10,
        layout          = "master",
        resize_on_border = true,

        col = {
            active_border   = { colors = { "rgba(90ceaaff)", "rgba(ecd3a0ff)" }, angle = 45 },
            inactive_border = { colors = { "rgba(86aaeccc)", "rgba(93cee9cc)" }, angle = 45 },
        },
    },

    decoration = {
        rounding           = 8,
        active_opacity     = 1.0,
        inactive_opacity   = 1.0,
        fullscreen_opacity = 1.0,

        blur   = { enabled = false },
        shadow = { enabled = false },
    },

    animations = {
        enabled = true,
    },

    master = {
        allow_small_split    = false,
        special_scale_factor = 0.8,
        mfact                = 0.5,
        new_on_top           = false,
        orientation          = "left",
    },

    misc = {
        disable_hyprland_logo   = true,
        force_default_wallpaper = 0,
    },

    cursor = {
        no_hardware_cursors = 0,
    },
})

hl.curve("zoom", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1.0 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 1, bezier = "zoom", style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 1, bezier = "zoom", style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 1, bezier = "zoom", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, bezier = "zoom", style = "slide" })
hl.animation({ leaf = "fade",        enabled = true, speed = 2, bezier = "zoom" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 1, bezier = "zoom", style = "slide" })

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout     = "pt",
        sensitivity   = 0,
        scroll_method = "2fg",

        touchpad = {
            natural_scroll = true,
        },
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Programs
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + Space",  hl.dsp.exec_cmd("wofi --show drun"))
hl.bind(mainMod .. " + L",      hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("powermenu"))

-- Windows
hl.bind(mainMod .. " + Q",             hl.dsp.window.close())
hl.bind(mainMod .. " + V",             hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F",     hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + SHIFT + M",     hl.dsp.exit())

-- Move focus / move windows with the arrow keys
for _, dir in ipairs({ "left", "right", "up", "down" }) do
    hl.bind(mainMod .. " + " .. dir,         hl.dsp.focus({ direction = dir }))
    hl.bind(mainMod .. " + SHIFT + " .. dir, hl.dsp.window.move({ direction = dir }))
end

-- Resize the focused window with the arrow keys (hold to keep resizing)
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 40,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x = 0, y = 40,  relative = true }), { repeating = true })

-- Workspaces 1-5: switch, or send the window there without following it
for i = 1, 5 do
    hl.bind(mainMod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Move/resize windows with mainMod + left/right mouse button
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshots: saved to ~/Pictures/Screenshots and copied to the clipboard
hl.bind("Print",                   hl.dsp.exec_cmd("screenshot region"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("screenshot region"))
hl.bind("SHIFT + Print",           hl.dsp.exec_cmd("screenshot screen"))

-- Screen recording: press once to start, again to stop. Saved to ~/Videos/Recordings
hl.bind(mainMod .. " + R",         hl.dsp.exec_cmd("screenrecord region"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("screenrecord screen"))

-- The laptop's special keys below also work on the lock screen (locked),
-- and the volume/brightness ones repeat while held down (repeating)
local held = { locked = true, repeating = true }
local once = { locked = true }

-- Volume keys (wpctl comes with wireplumber). "-l 1" stops the volume at 100%
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), held)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      held)
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     once)
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   once)

-- Screen brightness. "-n 2" keeps the screen from going fully black
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), held)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), held)

-- Keyboard backlight
hl.bind("XF86KbdBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -d asus::kbd_backlight set 1+"), once)
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d asus::kbd_backlight set 1-"), once)

-- Media keys (Spotify, browser videos, ...)
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), once)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), once)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       once)
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   once)

----------------------
---- WINDOW RULES ----
----------------------

-- Small menus opened from the bar (Wi-Fi, bluetooth, volume mixer) float in the middle
hl.window_rule({
    name   = "floating-menus",
    match  = { class = "^(nmtui|bluetuith|org.pulseaudio.pavucontrol)$" },
    float  = true,
    size   = { 900, 600 },
    center = true,
})
