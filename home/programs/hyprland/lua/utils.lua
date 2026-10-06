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

---Generate the command string to launch a webapp.
---Eg. `webapp_cmd("open.spotify.com")` → `"brave --app=https://open.spotify.com"`
---@param url string
function M.webapp_cmd(url)
    return browser .. " --app=https://" .. url
end

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
        local w = hl.get_window("class:" .. app.class)
        if w then
            hl.dispatch(hl.dsp.focus({ window = w }))
        else
            hl.dispatch(hl.dsp.exec_cmd(app.cmd))
        end
    end
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

---Open a URL in the browser, focusing an existing tab if one matches.
---Eg. `spawn_or_focus_url("www.youtube.com")`
---@param url string
---@return function
function M.spawn_or_focus_url(url)
    return function()
        hl.dispatch(hl.dsp.exec_cmd(browser .. " --focus='https://" .. url .. "/*' https://" .. url))
    end
end

---Spawn or focus a terminal TUI app using kitty with a unique app ID.
---Eg. `spawn_or_focus_tui("yazi")`
---@param app string|{cmd: string, class: string}
---@return function
function M.spawn_or_focus_tui(app)
    if type(app) == "string" then
        app = { cmd = app, class = app }
    end
    local cmd = "kitty --app-id " .. app.class .. " " .. app.cmd
    return M.spawn_or_focus({ cmd = cmd, class = app.class })
end

---Create a scratchpad toggle function for a given class/cmd.
---Eg. `scratchpad("music", webapp_cmd("open.spotify.com"), webapp_class("open.spotify.com"))`
---@param scratchpad_name string
---@param cmd string
---@param class string|nil
---@return function
function M.scratchpad(scratchpad_name, cmd, class)
    class = class or cmd
    return function()
        local w = hl.get_window("class:" .. class)
        if w then
            hl.dispatch(hl.dsp.workspace.toggle_special(scratchpad_name))
        else
            hl.dispatch(hl.dsp.exec_cmd(cmd, { workspace = scratchpad_name }))
            hl.dispatch(hl.dsp.workspace.toggle_special(scratchpad_name))
        end
    end
end

---Create a scratchpad toggle function for a webapp URL.
---Generates the correct cmd and class automatically.
---Eg. `scratchpad_webapp("music", "open.spotify.com")`
---@param scratchpad_name string
---@param url string
---@return function
function M.scratchpad_webapp(scratchpad_name, url)
    return M.scratchpad(scratchpad_name, M.webapp_cmd(url), M.webapp_class(url))
end

---Toggle the active scrolling column between full width and the configured default width.
function M.scrolling_fullwidth_toggle()
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
