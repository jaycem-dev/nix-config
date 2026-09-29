local spawn = require("lua.utils").spawn_or_focus
local spawn_webapp = require("lua.utils").spawn_or_focus_webapp
local spawn_tui = require("lua.utils").spawn_or_focus_tui
local scratchpad = require("lua.utils").scratchpad
local scratchpad_webapp = require("lua.utils").scratchpad_webapp
local layout_bind = require("lua.utils").layout_bind

local mod = "SUPER+"
local mod2 = "SUPER+SHIFT+"

local menu = "noctalia msg panel-toggle launcher"
local terminal = "kitty -1"
local browser = { cmd = "brave-origin" }
local yazi = { cmd = "yazi" }
local nvim = { cmd = "projects nvim", class = "nvim" }

local function scrolling_fullwidth_toggle()
    local win = hl.get_active_window()
    if not win then
        return
    end
    if win.layout.column.width == 1 then
        hl.dispatch(hl.dsp.layout("colresize " .. hl.get_config("scrolling.column_width")))
    else
        hl.dispatch(hl.dsp.layout("colresize 1"))
    end
end

hl.bind(
    mod .. "F",
    layout_bind({
        scrolling = scrolling_fullwidth_toggle, -- scrolling: toggle column between full width and default width
        master = hl.dsp.window.fullscreen({ mode = "maximized" }), -- master: toggle maximize
    })
)

hl.bind(mod2 .. "F", hl.dsp.window.fullscreen())
hl.bind(mod .. "Q", hl.dsp.window.close())
hl.bind(mod2 .. "Q", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(mod .. "E", spawn_tui(yazi))
hl.bind(mod .. "N", spawn(nvim))
hl.bind(mod2 .. "N", hl.dsp.exec_cmd("projects nvim"))
hl.bind(mod .. "A", scratchpad("ai", "projects opencode", "opencode"))
hl.bind(mod .. "B", spawn(browser))
hl.bind(mod .. "W", spawn_webapp("web.whatsapp.com"))
hl.bind(mod2 .. "M", spawn_webapp("mail.proton.me"))
hl.bind(mod .. "V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. "G", hl.dsp.window.pin())
hl.bind(mod .. "SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mod .. "D", hl.dsp.exec_cmd("noctalia msg notification-clear-active"))
hl.bind(mod .. "I", hl.dsp.exec_cmd("noctalia msg notification-invoke-latest"))
hl.bind(mod .. "P", hl.dsp.exec_cmd("dmenu-power"))
hl.bind(mod .. "T", hl.dsp.exec_cmd(terminal))
hl.bind(
    mod .. "R",
    layout_bind({
        scrolling = hl.dsp.layout("colresize +conf"), -- scrolling: cycle column width forward
    })
)

hl.bind(mod .. "L", function()
    local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
    if not workspace then
        return
    end
    local next_layout = workspace.tiled_layout == "scrolling" and "master" or "scrolling"
    if workspace.special then
        hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
    else
        hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
    end
end) -- toggle current workspace between scrolling and master

-- Move focus with mainMod + arrow keys
hl.bind(mod .. "left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. "right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. "up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. "down", hl.dsp.focus({ direction = "down" }))

hl.bind(
    mod2 .. "left",
    layout_bind({
        scrolling = hl.dsp.layout("swapcol l"), -- scrolling: swap column with left one
        master = hl.dsp.layout("swapprev"), -- master: swap with previous window in stack
    })
)
hl.bind(
    mod2 .. "right",
    layout_bind({
        scrolling = hl.dsp.layout("swapcol r"), -- scrolling: swap column with right one
        master = hl.dsp.layout("swapnext"), -- master: swap with next window in stack
    })
)
hl.bind(
    mod .. "comma",
    layout_bind({
        scrolling = hl.dsp.layout("consume_or_expel prev"), -- scrolling: join/expel column backward
    })
)
hl.bind(
    mod .. "period",
    layout_bind({
        scrolling = hl.dsp.layout("consume_or_expel next"), -- scrolling: join/expel column forward
    })
)
hl.bind(mod2 .. "up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod2 .. "down", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mod .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mod2 .. key, hl.dsp.window.move({ workspace = i }))
end

-- scratchpads
hl.bind(mod .. "S", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(mod2 .. "S", hl.dsp.window.move({ workspace = "special:scratchpad" }))

hl.bind(mod .. "M", scratchpad_webapp("music", "open.spotify.com"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mod .. "mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. "mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
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

-- Media keys via Noctalia MPRIS
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("noctalia msg media next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("noctalia msg media toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("noctalia msg media toggle"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("noctalia msg media previous"), { locked = true })
