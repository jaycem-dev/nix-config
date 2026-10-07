local utils = require("lua.utils")

-- pip
hl.window_rule({
    name = "Pip",
    match = { title = "Picture in picture" },
    float = true,
    pin = true,
    keep_aspect_ratio = true,
    no_initial_focus = true,
    size = { 384, 216 },
    move = { "monitor_w - 384 - 10", "10 + 30" },
})

hl.window_rule({
    name = "disable-focus-on-activate",
    match = { class = "rocketleague.exe" },
    focus_on_activate = false,
})

-- workspace assignment
hl.window_rule({
    match = { class = "brave-origin" },
    workspace = 1,
})
hl.window_rule({
    match = { class = "foot|kitty|nvim" },
    workspace = 2,
})
hl.window_rule({
    match = {
        class = utils.webapp_class("web.whatsapp.com") .. "|" .. utils.webapp_class("mail.proton.me"),
    },
    workspace = 4,
})
hl.window_rule({
    match = { class = "steam|heroic" },
    workspace = 5,
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

hl.workspace_rule({ workspace = "s[true]", gaps_out = 50 })
