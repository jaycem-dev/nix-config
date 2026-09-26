local webapp_class = require("lua.utils").webapp_class

-- pip
hl.window_rule({
    name = "apply-something",
    match = {
        title = "Picture in picture",
    },
    float = true,
    pin = true,
    keep_aspect_ratio = true,
    no_initial_focus = true,
    size = { 384, 216 },
    move = { "monitor_w - 384 - 10", 40 },
})

hl.window_rule({
    name = "disable-focus-on-activate",
    match = {
        class = "rocketleague.exe",
    },
    focus_on_activate = false,
})

-- workspace assignment
hl.window_rule({
    match = {
        class = "brave-origin",
    },
    workspace = 1,
})
hl.window_rule({
    match = {
        class = "foot|kitty|nvim",
    },
    workspace = 2,
})
hl.window_rule({
    match = {
        class = webapp_class("web.whatsapp.com") .. "|" .. webapp_class("mail.proton.me"),
    },
    workspace = 4,
})
hl.window_rule({
    match = {
        class = "steam|electron",
    },
    workspace = 5,
})

hl.layer_rule({
    match = { namespace = "waybar" },
    blur = true,
    ignore_alpha = 0,
    xray = true,
})

hl.layer_rule({
    match = { namespace = "launcher" },
    blur = true,
    ignore_alpha = 0.5,
    xray = true,
})

-- Example window rules that are useful
hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
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

-- special workspace gaps
hl.workspace_rule({ workspace = "s[true]", gaps_out = 50 })
