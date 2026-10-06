local utils = require("lua.utils")

local mod = "SUPER+"
local mod2 = mod .. "SHIFT+"

local menu = "noctalia msg panel-toggle launcher"
local terminal = "kitty -1"
local browser = "brave-origin"
local nvim = { cmd = "projects nvim", class = "nvim" }

hl.bind(mod2 .. "F", hl.dsp.window.fullscreen())
hl.bind(mod .. "Q", hl.dsp.window.close())
hl.bind(mod .. "F", utils.scrolling_fullwidth_toggle)
hl.bind(mod .. "R", hl.dsp.layout("colresize +conf"))
hl.bind(mod2 .. "left", hl.dsp.layout("swapcol l"))
hl.bind(mod2 .. "right", hl.dsp.layout("swapcol r"))
hl.bind(mod .. "C", hl.dsp.layout("center"))
hl.bind(mod .. "comma", hl.dsp.layout("consume_or_expel prev"))
hl.bind(mod .. "period", hl.dsp.layout("consume_or_expel next"))
hl.bind(mod .. "left", hl.dsp.layout("focus l"))
hl.bind(mod .. "right", hl.dsp.layout("focus r"))
hl.bind(mod .. "up", utils.focus_column_or_workspace("u"))
hl.bind(mod .. "down", utils.focus_column_or_workspace("d"))
hl.bind(mod2 .. "up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod2 .. "down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mod2 .. "Q", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(mod .. "E", utils.spawn_or_focus_tui("yazi"))
hl.bind(mod .. "N", utils.spawn_or_focus(nvim))
hl.bind(mod .. "G", utils.spawn_or_focus("steam"))
hl.bind(mod2 .. "N", hl.dsp.exec_cmd("projects nvim"))
hl.bind(mod .. "A", utils.scratchpad("ai", "projects opencode", "opencode"))
hl.bind(mod .. "B", utils.spawn_or_focus(browser))
hl.bind(mod .. "W", utils.spawn_or_focus_webapp("web.whatsapp.com"))
hl.bind(mod2 .. "M", utils.spawn_or_focus_webapp("mail.proton.me"))
hl.bind(mod .. "V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod2 .. "G", hl.dsp.window.pin())
hl.bind(mod .. "SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mod .. "P", hl.dsp.exec_cmd("dmenu-power"))
hl.bind(mod .. "T", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. "D", hl.dsp.exec_cmd("noctalia msg notification-clear-active"))
hl.bind(mod .. "I", hl.dsp.exec_cmd("noctalia msg notification-invoke-latest"))
hl.bind(mod2 .. "S", hl.dsp.exec_cmd("noctalia msg screenshot-annotate"))
hl.bind(mod2 .. "B", hl.dsp.exec_cmd("noctalia msg bar-toggle"))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mod .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mod2 .. key, hl.dsp.window.move({ workspace = i }))
end

-- scratchpads
hl.bind(mod .. "S", utils.scratchpad("scratch", "kitty -1 --app-id scratch", "scratch"))
hl.bind(mod .. "M", utils.scratchpad_webapp("music", "open.spotify.com"))

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
