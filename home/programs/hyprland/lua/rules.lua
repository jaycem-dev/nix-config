local webapp_class = require("lua.utils").webapp_class

hl.window_rule({
    match = { class = "opencode|git" },
    workspace = "special:scratchpad",
})

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
    move = { "monitor_w - 384 - 5", 5 },
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
        class = "brave-browser",
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

-- Hyprland-run windowrule
hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true,
})

hl.workspace_rule({ workspace = "s[true]", gaps_out = 50 })

-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name        = "no-gaps-wtv1",
--     match       = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name        = "no-gaps-f1",
--     match       = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
