local M = {}

-- Only Chromium browsers are supported
local browser = "brave-origin"
local browser_class = "brave"

---Generate the Hyprland window class for a webapp.
---Eg. `webapp_class("open.spotify.com")` → `"brave-open.spotify.com__-Default"`
---@param url string
function M.webapp_class(url)
    return browser_class .. "-" .. url .. "__-Default"
end

---Spawn an app or focus it if already running.
---Eg. `spawn_or_focus({ cmd = "brave", class = "brave-browser" })`
---@param app {cmd: string, class: string|nil}
---@return function
function M.spawn_or_focus(app)
    return function()
        local w = hl.get_window("class:" .. (app.class or app.cmd))
        if w then
            hl.dispatch(hl.dsp.focus({ window = w }))
        else
            hl.dispatch(hl.dsp.exec_cmd(app.cmd))
        end
    end
end

---Spawn or focus a Chromium-based webapp by URL.
---Focus lookup needs the full window class; window rules match on URL substring.
---Eg. `spawn_or_focus_webapp("web.whatsapp.com")`
---@param url string
---@return function
function M.spawn_or_focus_webapp(url)
    return M.spawn_or_focus({
        cmd = browser .. " --app=https://" .. url,
        class = M.webapp_class(url),
    })
end

---Spawn or focus a terminal TUI app using kitty with a unique app ID.
---Eg. `spawn_or_focus_tui({ cmd = "yazi" })`
---@param app {cmd: string, class: string|nil}
---@return function
function M.spawn_or_focus_tui(app)
    local class = app.class or app.cmd
    local cmd = "kitty --app-id " .. class .. " " .. app.cmd
    return M.spawn_or_focus({ cmd = cmd, class = app.class or app.cmd })
end

return M
