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
    move = { "monitor_w - 384 - 5", "5" },
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
    match = { class = "nvim" },
    workspace = 2,
})
hl.window_rule({
    match = {
        class = "zapfast" .. "|" .. utils.webapp_class("mail.proton.me"),
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

-- scratchpads: auto-spawn once when empty special is first toggled
hl.workspace_rule({ workspace = "special:scratch", on_created_empty = "kitty -1 --app-id scratch" })
hl.workspace_rule({ workspace = "special:music", on_created_empty = utils.webapp_cmd("music.youtube.com") })
hl.workspace_rule({
    workspace = "special:ai",
    on_created_empty = utils.tui_cmd({ cmd = "projects-picker opencode", class = "opencode" }),
})

hl.layer_rule({
    name = "noctalia",
    match = {
        namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
    },
    no_anim = true,
})
