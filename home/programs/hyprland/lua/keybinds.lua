local spawn = require("lua.utils").spawn_or_focus
local spawn_webapp = require("lua.utils").spawn_or_focus_webapp
local spawn_tui = require("lua.utils").spawn_or_focus_tui

local mod = "SUPER"
local mod2 = "SUPER + SHIFT"

-- format for spawn_or_focus: { cmd = "command", class = "class" }
-- format for spawn: "command"
local menu = "fuzzel"
local terminal = "kitty"
local browser = { cmd = "brave-origin" }

-- webapps, use only url
local whatsapp = "web.whatsapp.com"
local protonmail = "mail.proton.me"
local music = "open.spotify.com"

-- tui, class is optional
local yazi = { cmd = "yazi" }
local nvim = { cmd = "dmenu-projects nvim", class = "nvim" }

hl.bind(mod .. " + F", hl.dsp.layout("colresize 1.0"))
hl.bind(mod2 .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod2 .. " + Q", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(mod .. " + E", spawn_tui(yazi))
hl.bind(mod .. " + N", spawn(nvim))
hl.bind(mod .. " + M", spawn_webapp(music))
hl.bind(mod .. " + B", spawn(browser))
hl.bind(mod .. " + W", spawn_webapp(whatsapp))
hl.bind(mod2 .. " + M", spawn_webapp(protonmail))
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + G", hl.dsp.window.pin())
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + D", hl.dsp.exec_cmd("makoctl dismiss"))
hl.bind(mod .. " + I", hl.dsp.exec_cmd("makoctl invoke"))
hl.bind(mod .. " + P", hl.dsp.exec_cmd("dmenu-power"))
hl.bind(mod .. " + T", hl.dsp.exec_cmd(terminal))

-- scrolling keybinds
hl.bind(mod .. " + R", hl.dsp.layout("colresize +conf")) -- cycle column width forward
hl.bind(mod2 .. " + R", hl.dsp.layout("colresize -conf")) -- cycle column width backward
hl.bind(mod .. " + left", hl.dsp.layout("focus l"))
hl.bind(mod .. " + right", hl.dsp.layout("focus r"))
hl.bind(mod .. " + up", hl.dsp.layout("focus u"))
hl.bind(mod .. " + down", hl.dsp.layout("focus d"))
hl.bind(mod2 .. " + left", hl.dsp.layout("swapcol l"))
hl.bind(mod2 .. " + right", hl.dsp.layout("swapcol r"))
hl.bind(mod2 .. " + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod2 .. " + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mod .. " + comma", hl.dsp.layout("consume_or_expel prev"))
hl.bind(mod .. " + period", hl.dsp.layout("consume_or_expel next"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mod2 .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("scratch"))
hl.bind(mod2 .. " + S", hl.dsp.window.move({ workspace = "special:scratch" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("volume up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("volume down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("volume mute"), { locked = true, repeating = true })
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightness up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightness down"), { locked = true, repeating = true })
hl.bind("CTRL + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightness up 2"), { locked = true, repeating = true })
hl.bind("CTRL + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightness down 2"), { locked = true, repeating = true })
hl.bind(
    mod .. " + XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl -q -d kbd_backlight s +25%"),
    { locked = true, repeating = true }
)
hl.bind(
    mod .. " + XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl -q -d kbd_backlight s 25%-"),
    { locked = true, repeating = true }
)

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
