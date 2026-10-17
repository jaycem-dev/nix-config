local M = {}

-- Only Chromium browsers are supported
local browser = "brave-origin"
local browser_class = "brave"

---Spawn an app or focus it if already running.
---Accepts a single string (used as both cmd and class) or a full table for distinct values.
---Eg. `spawn_or_focus("steam")` or `spawn_or_focus({ cmd = "brave", class = "brave-browser" })`
---@param app string|{cmd: string, class: string}
---@return function
function M.spawn_or_focus(app)
    if type(app) == "string" then
        app = { cmd = app, class = app }
    end
    return function()
        local w = hl.get_windows({ class = app.class, floating = false })[1]
        if w then
            hl.dispatch(hl.dsp.focus({ window = w }))
        else
            hl.dispatch(hl.dsp.exec_cmd(app.cmd))
        end
    end
end

---Generate the Hyprland window class for a webapp.
---Eg. `webapp_class("open.spotify.com")` → `"brave-open.spotify.com__-Default"`
---@param url string
function M.webapp_class(url)
    return browser_class .. "-" .. url .. "__-Default"
end

---Generate the command string to launch a webapp.
---Eg. `webapp_cmd("open.spotify.com")` → `"brave --app=https://open.spotify.com"`
---@param url string
function M.webapp_cmd(url)
    return browser .. " --app=https://" .. url
end

---Spawn or focus a Chromium-based webapp by URL.
---Eg. `spawn_or_focus_webapp("web.whatsapp.com")`
---@param url string
---@return function
function M.spawn_or_focus_webapp(url)
    return M.spawn_or_focus({
        cmd = M.webapp_cmd(url),
        class = M.webapp_class(url),
    })
end

---Build the kitty command string for a TUI app with a unique app ID.
---Eg. `tui_cmd("yazi")` → `"kitty -1 --app-id yazi yazi"`
---@param app string|{cmd: string, class: string}
---@return string
function M.tui_cmd(app)
    if type(app) == "string" then
        app = { cmd = app, class = app }
    end
    return "kitty -1 --app-id " .. app.class .. " " .. app.cmd
end

---Spawn or focus a terminal TUI app using kitty with a unique app ID.
---Eg. `spawn_or_focus_tui("yazi")`
---@param app string|{cmd: string, class: string}
---@return function
function M.spawn_or_focus_tui(app)
    if type(app) == "string" then
        app = { cmd = app, class = app }
    end
    return M.spawn_or_focus({ cmd = M.tui_cmd(app), class = app.class })
end

---Focus window in scrolling column, else adjacent workspace.
---`dir` "u" falls back to "r-1", "d" to "r+1".
---@param dir "u"|"d"
---@return function
function M.focus_column_or_workspace(dir)
    local fallback = dir == "u" and "r-1" or "r+1"
    return function()
        local before = hl.get_active_window()
        hl.dispatch(hl.dsp.layout("focus " .. dir))
        local after = hl.get_active_window()
        if (before == nil and after == nil) or (before ~= nil and after ~= nil and before.address == after.address) then
            hl.dispatch(hl.dsp.focus({ workspace = fallback }))
        end
    end
end

return M
