local M = {}

-- Only Chromium browsers are supported
local browser = "brave-origin"
local browser_class = "brave"

---Bind different actions to the same key depending on the current layout.
---Values can be layout dispatchers or functions (functions are called, dispatchers are dispatched).
---Eg. `layout_bind({ scrolling = hl.dsp.layout("swapcol l"), master = hl.dsp.layout("swapprev") })`
---@param bind_table {scrolling: HL.Dispatcher|function|nil, master: HL.Dispatcher|function|nil}
---@return function
function M.layout_bind(bind_table)
    return function()
        local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
        if not workspace then
            return
        end
        local action = bind_table[workspace.tiled_layout]
        if type(action) == "function" then
            action()
        elseif action then
            hl.dispatch(action)
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
---Eg. `spawn_or_focus_tui({ cmd = "yazi" })`
---@param app {cmd: string, class: string|nil}
---@return function
function M.spawn_or_focus_tui(app)
    local class = app.class or app.cmd
    local cmd = "kitty --app-id " .. class .. " " .. app.cmd
    return M.spawn_or_focus({ cmd = cmd, class = app.class or app.cmd })
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

---Toggle the current workspace between the scrolling and master layouts.
function M.toggle_workspace_layout()
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
end

return M
