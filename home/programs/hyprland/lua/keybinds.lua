local utils = require("lua.utils")

local mod = "SUPER+"
local mod2 = mod .. "SHIFT+"

hl.bind(mod2 .. "F", hl.dsp.window.fullscreen())
hl.bind(mod .. "Q", hl.dsp.window.close())
hl.bind(mod .. "F", function()
    local win = hl.get_active_window()
    if win then
        hl.dispatch(
            hl.dsp.layout(
                "colresize " .. (win.layout.column.width == 1 and hl.get_config("scrolling.column_width") or 1)
            )
        )
    end
end, { desc = "Toggle between full width and default size (scrolling)" })

hl.bind(mod .. "r", hl.dsp.layout("colresize +conf"))
hl.bind(mod2 .. "left", hl.dsp.layout("swapcol l"))
hl.bind(mod2 .. "right", hl.dsp.layout("swapcol r"))
hl.bind(mod .. "c", hl.dsp.layout("center"))
hl.bind(mod .. "comma", hl.dsp.layout("consume_or_expel prev"))
hl.bind(mod .. "period", hl.dsp.layout("consume_or_expel next"))
hl.bind(mod .. "left", hl.dsp.layout("focus l"))
hl.bind(mod .. "right", hl.dsp.layout("focus r"))

hl.bind(mod .. "up", utils.focus_column_or_workspace("u"))
hl.bind(mod .. "down", utils.focus_column_or_workspace("d"))
hl.bind(mod2 .. "up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod2 .. "down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mod2 .. "g", hl.dsp.window.pin())
hl.bind(mod2 .. "v", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. "v", function()
    local window = hl.get_active_window()
    if not window then
        return
    end
    hl.dispatch(hl.dsp.window.cycle_next({
        floating = not window.floating,
        tiled = window.floating,
    }))
end, { desc = "Switch focus between tiled and floating windows" })

hl.bind(mod .. "space", hl.dsp.exec_cmd("fuzzel"))
hl.bind(mod .. "p", hl.dsp.exec_cmd("dmenu-power"))
hl.bind(mod2 .. "b", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
hl.bind(mod .. "d", hl.dsp.exec_cmd("makoctl dismiss"))
hl.bind(mod .. "i", hl.dsp.exec_cmd("makoctl invoke && makoctl dismiss"))
hl.bind(mod2 .. "q", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(mod2 .. "s", hl.dsp.exec_cmd("screenshot"))

hl.bind(mod .. "e", utils.spawn_or_focus_tui("yazi"))
hl.bind(mod .. "n", utils.spawn_or_focus_tui({ cmd = "projects-picker nvim", class = "nvim" }))
hl.bind(mod2 .. "n", hl.dsp.exec_cmd(utils.tui_cmd({ cmd = "projects-picker nvim", class = "nvim" })))
hl.bind(mod .. "g", utils.spawn_or_focus("steam"))
hl.bind(mod .. "b", utils.spawn_or_focus("brave-origin"))
hl.bind(mod .. "t", utils.spawn_or_focus({ cmd = "kitty -1", class = "kitty" }))
hl.bind(mod .. "w", utils.spawn_or_focus_webapp("web.whatsapp.com"))
hl.bind(mod2 .. "m", utils.spawn_or_focus_webapp("mail.proton.me"))

for i = 1, 9 do
    hl.bind(mod .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mod2 .. i, hl.dsp.window.move({ workspace = i }))
end

-- scratchpads (auto-spawned via on_created_empty in rules.lua)
hl.bind(mod .. "s", hl.dsp.workspace.toggle_special("scratch"))
hl.bind(mod .. "m", hl.dsp.workspace.toggle_special("music"))
hl.bind(mod .. "a", hl.dsp.workspace.toggle_special("ai"))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("volume up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("volume down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("volume mute"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("volume micmute"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightness up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightness down"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightness up 20"), { locked = true, repeating = true })
hl.bind("SHIFT + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightness down 20"), { locked = true, repeating = true })
hl.bind("CTRL + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightness up 2"), { locked = true, repeating = true })
hl.bind("CTRL + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightness down 2"), { locked = true, repeating = true })
