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

-- Volume keys (wpctl comes with wireplumber)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
