local utils = require("lua.utils")

local mod = "SUPER+"
local mod2 = "SUPER+SHIFT+"

local menu = "noctalia msg panel-toggle launcher"
local terminal = "kitty -1"
local browser = { cmd = "brave-origin" }
local yazi = { cmd = "yazi" }
local nvim = { cmd = "projects nvim", class = "nvim" }
local steam = { cmd = "steam" }

hl.bind(mod2 .. "F", hl.dsp.window.fullscreen())
hl.bind(mod .. "Q", hl.dsp.window.close())
hl.bind(mod2 .. "Q", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(mod .. "E", utils.spawn_or_focus_tui(yazi))
hl.bind(mod .. "N", utils.spawn_or_focus(nvim))
hl.bind(mod .. "G", utils.spawn_or_focus(steam))
hl.bind(mod2 .. "N", hl.dsp.exec_cmd("projects nvim"))
hl.bind(mod .. "A", utils.scratchpad("ai", "projects opencode", "opencode"))
hl.bind(mod .. "B", utils.spawn_or_focus(browser))
hl.bind(mod .. "W", utils.spawn_or_focus_webapp("web.whatsapp.com"))
hl.bind(mod2 .. "M", utils.spawn_or_focus_webapp("mail.proton.me"))
hl.bind(mod .. "V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. "G", hl.dsp.window.pin())
hl.bind(mod .. "SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mod .. "D", hl.dsp.exec_cmd("noctalia msg notification-clear-active"))
hl.bind(mod .. "I", hl.dsp.exec_cmd("noctalia msg notification-invoke-latest"))
hl.bind(mod .. "P", hl.dsp.exec_cmd("dmenu-power"))
hl.bind(mod .. "T", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. "L", utils.toggle_workspace_layout)

-- per layout binds
hl.bind(
    mod .. "F",
    utils.layout_bind({
        scrolling = utils.scrolling_fullwidth_toggle,
        master = hl.dsp.window.fullscreen({ mode = "maximized" }),
    })
)
hl.bind(
    mod .. "R",
    utils.layout_bind({
        scrolling = hl.dsp.layout("colresize +conf"),
    })
)
hl.bind(
    mod2 .. "left",
    utils.layout_bind({
        scrolling = hl.dsp.layout("swapcol l"),
        master = hl.dsp.layout("swapprev"),
    })
)
hl.bind(
    mod2 .. "right",
    utils.layout_bind({
        scrolling = hl.dsp.layout("swapcol r"),
        master = hl.dsp.layout("swapnext"),
    })
)
hl.bind(
    mod .. "comma",
    utils.layout_bind({
        scrolling = hl.dsp.layout("consume_or_expel prev"),
    })
)
hl.bind(
    mod .. "period",
    utils.layout_bind({
        scrolling = hl.dsp.layout("consume_or_expel next"),
    })
)

-- Move focus with mainMod + arrow keys
hl.bind(mod .. "left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. "right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. "up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. "down", hl.dsp.focus({ direction = "down" }))
hl.bind(mod2 .. "up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod2 .. "down", hl.dsp.window.move({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mod .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mod2 .. key, hl.dsp.window.move({ workspace = i }))
end

-- scratchpads
hl.bind(mod .. "S", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(mod2 .. "S", hl.dsp.window.move({ workspace = "special:scratchpad" }))
hl.bind(mod .. "M", utils.scratchpad_webapp("music", "open.spotify.com"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mod .. "mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. "mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("noctalia msg media next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("noctalia msg media toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("noctalia msg media toggle"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("noctalia msg media previous"), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia msg volume-up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia msg volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("noctalia msg volume-mute"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("noctalia msg mic-mute"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("noctalia msg brightness-up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("noctalia msg brightness-down"), { locked = true, repeating = true })
hl.bind(
    "CTRL + XF86MonBrightnessUp",
    hl.dsp.exec_cmd("noctalia msg brightness-up 1"),
    { locked = true, repeating = true }
)
hl.bind(
    "CTRL + XF86MonBrightnessDown",
    hl.dsp.exec_cmd("noctalia msg brightness-down 1"),
    { locked = true, repeating = true }
)
hl.bind(
    mod .. "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl -q -d kbd_backlight s +25%"),
    { locked = true, repeating = true }
)
hl.bind(
    mod .. "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl -q -d kbd_backlight s 25%-"),
    { locked = true, repeating = true }
)
