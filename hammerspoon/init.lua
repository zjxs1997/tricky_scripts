----------------------------------------
-- 输入法自动切换
----------------------------------------
local function Chinese()
    -- 简体拼音
    hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.ITABC")
end

local function English()
    -- ABC
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

-- app to expected ime config
-- app和对应的输入法
local app2Ime = {
    {'/Applications/iTerm.app', 'English'},
    {'/Applications/Visual Studio Code.app', 'English'},
    -- {'/System/Library/CoreServices/Finder.app', 'English'},
    -- {'/Applications/System Preferences.app', 'English'},
    {'/Applications/DingTalk.app', 'Chinese'},
    {'/Applications/语雀.app', 'Chinese'}
}

function updateFocusAppInputMethod()
    local ime = '-'
    local focusAppPath = hs.window.frontmostWindow():application():path()
    for index, app in pairs(app2Ime) do
        local appPath = app[1]
        local expectedIme = app[2]

        if focusAppPath == appPath then
            ime = expectedIme
            break
        end
    end

    if ime == 'English' then
        English()
    elseif ime == 'Chinese' then
        Chinese()
    end
end

-- helper hotkey to figure out the app path and name of current focused window
-- 当选中某窗口按下ctrl+command+.时会显示应用的路径等信息
hs.hotkey.bind({'ctrl', 'cmd'}, ".", function()
    hs.alert.show("App path:        "
    ..hs.window.focusedWindow():application():path()
    .."\n"
    .."App name:      "
    ..hs.window.focusedWindow():application():name()
    .."\n"
    .."IM source id:  "
    ..hs.keycodes.currentSourceID())
end)

-- Handle cursor focus and application's screen manage.
-- 窗口激活时自动切换输入法
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        updateFocusAppInputMethod()
    end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

----------------------------------------
-- 输入法自动切换 END
----------------------------------------


----------------------------------------
-- 两个窗口布局快捷键
----------------------------------------
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)


----------------------------------------
-- 两个app快捷键
----------------------------------------
hs.hotkey.bind({"alt"}, "z", function()
    hs.application.launchOrFocus("Launchpad")
end)

hs.hotkey.bind({"cmd","shift"}, ",", function()
    hs.application.launchOrFocus("System Preferences")
end)

