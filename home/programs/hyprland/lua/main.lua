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
        kb_model = "",
        kb_options = "caps:escape,grp:alt_shift_toggle",
        kb_rules = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            tap_to_click = false,
            natural_scroll = true,
            clickfinger_behavior = true,
        },
    },
    cursor = {
        inactive_timeout = 0.5,
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
        gaps_out = 10,
        gaps_in = 5,
        border_size = 3,
        resize_on_border = false,
        allow_tearing = false,
        layout = "scrolling",
    },

    decoration = {
        rounding = 5,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        blur = {
            xray = true,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Global animation duration
hl.animation({ leaf = "global", enabled = true, speed = 2, bezier = "default" })
-- Vertical slide for workspace switches
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "default", style = "slidevert" })

hl.config({
    scrolling = {
        fullscreen_on_one_column = false,
        column_width = 0.667,
        explicit_column_widths = "0.5, 0.667",
        wrap_focus = false,
        wrap_swapcol = false,
    },
})

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
