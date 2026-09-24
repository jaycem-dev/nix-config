require("lua.keybinds")
require("lua.rules")

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        focus_on_activate = true,
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
})

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
        kb_model = "",
        kb_options = "caps:escape,grp:alt_shift_toggle",
        kb_rules = "",
        follow_mouse = 1,
        touchpad = {
            tap_to_click = false,
            natural_scroll = true,
            clickfinger_behavior = true,
        },
    },
    cursor = {
        hide_on_key_press = true,
    },
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
    general = {
        gaps_in = 5,
        gaps_out = 5,
        border_size = 2,
        layout = "scrolling",
    },

    decoration = {
        inactive_opacity = 0.9,

        blur = {
            enabled = true,
            size = 10,
            passes = 2,
            xray = true,
        },
    },
})

hl.config({
    scrolling = {
        explicit_column_widths = "0.333, 0.5, 0.667",
        wrap_focus = false,
    },
})

hl.animation({ leaf = "global", enabled = true, speed = 2, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "default", style = "slidevert" })
