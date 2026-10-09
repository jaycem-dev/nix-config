require("lua.keybinds")
require("lua.rules")

local default_width = 0.75 -- scrolling

-- Speed up global animation and use vertical workspace transition
hl.animation({ leaf = "global", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "default", style = "slidevert" })

hl.monitor({ output = "eDP-1", mode = "preferred", scale = "1.67" })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@72" })

hl.gesture({ fingers = 3, direction = "vertical", action = "workspace" })
hl.gesture({ fingers = 3, direction = "horizontal", action = "scroll_move" })

hl.config({
    animations = { enabled = true },
    ecosystem = { no_donation_nag = true },
    cursor = { inactive_timeout = 0.5, hide_on_key_press = true },

    input = {
        kb_layout = "us,us",
        kb_variant = "colemak_dh_iso,",
        kb_options = "caps:escape,grp:alt_shift_toggle",
        repeat_rate = 30,
        repeat_delay = 400,
        follow_mouse = 1,
        touchpad = {
            tap_to_click = false,
            natural_scroll = true,
            clickfinger_behavior = true,
        },
    },

    general = {
        gaps_out = 5,
        gaps_in = 2.5,
        border_size = 2,
        allow_tearing = false,
        layout = "scrolling",
        no_focus_fallback = true,
        snap = { enabled = true, respect_gaps = true },
    },

    decoration = {
        inactive_opacity = 0.9,
        shadow = { enabled = false },
        blur = {
            enabled = true,
            xray = true,
            size = 15,
            passes = 1,
        },
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        focus_on_activate = true,
    },

    scrolling = {
        fullscreen_on_one_column = true,
        column_width = default_width,
        explicit_column_widths = "0.5, " .. default_width,
        wrap_focus = false,
        wrap_swapcol = false,
        follow_min_visible = 1,
    },
})
