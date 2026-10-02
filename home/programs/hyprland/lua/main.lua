require("lua.keybinds")
require("lua.rules")

hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "auto",
    scale = "1.6",
})
hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@72",
    position = "auto",
    scale = "auto",
})

hl.config({
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
    cursor = { inactive_timeout = 0.5, hide_on_key_press = true },
})

hl.gesture({
    fingers = 3,
    direction = "vertical",
    action = "workspace",
})
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "scroll_move",
})

hl.config({
    animations = { enabled = true },

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
        blur = {
            xray = true,
            size = 20,
            passes = 2,
        },
    },
})

-- Global animation duration
hl.animation({ leaf = "global", enabled = true, speed = 2, bezier = "default" })
-- Vertical slide for workspace switches
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "default", style = "slidevert" })

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.667,
        explicit_column_widths = "0.5, 0.667",
        wrap_focus = false,
        wrap_swapcol = false,
    },
})

hl.config({
    ecosystem = { no_donation_nag = true },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        focus_on_activate = true,
    },
})
