-- TODO
-- * setup layouts for each space
hs.alert.show("Hammerspoon Config loaded")

log = hs.logger.new('config', 'debug')

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

function rsutils()
  local win = hs.window.frontmostWindow()
  log:d('window', win)
  local frame = win:frame()
  local screen = win:screen()
  log:d('screen', screen)
  local viewp  = screen:frame()
  return win, frame, screen, viewp
end

-- sizes window to 3rds width, left aligned, max height
hs.hotkey.bind({"shift", "alt", "ctrl"}, "down", function()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x
  frame.y = viewp.y
  frame.w = (viewp.w / 8) * 6
  frame.h = viewp.h
  win:setFrame(frame, 0)
end)

-- sizes window to 3rds width, right aligned, max height
hs.hotkey.bind({"shift", "alt", "ctrl"}, "up", function()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x + (viewp.w / 8) * 2
  frame.y = viewp.y
  frame.w = (viewp.w / 8) * 6
  frame.h = viewp.h
  win:setFrame(frame, 0)
end)

-- sizes window to half width, left aligned, max height
hs.hotkey.bind({"shift", "alt", "ctrl"}, "left", function()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x
  frame.y = viewp.y
  frame.w = viewp.w / 2
  frame.h = viewp.h
  win:setFrame(frame, 0)
end)

-- sizes window to half width, right aligned, max height
hs.hotkey.bind({"shift", "alt", "ctrl"}, "right", function()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x + viewp.w / 2
  frame.y = viewp.y
  frame.w = viewp.w / 2
  frame.h = viewp.h
  win:setFrame(frame, 0)
end)

windowSizes = {}

function aroundTheSame(a, b)
  a = math.floor(a)
  b = math.floor(b)
  return math.abs(a - b) < 15
end

function isMaximized()
  win, frame, screen, viewp = rsutils()
  return aroundTheSame(frame.x, viewp.x) and
         aroundTheSame(frame.y, viewp.y) and
         aroundTheSame(frame.w, viewp.w) and
         aroundTheSame(frame.h, viewp.h)
end

-- maximizes window. if window was previously maximized, returns it to previous size
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "m", function()
  win, frame = rsutils()
  local id = win:id()
  if not isMaximized() then
    windowSizes[id] = frame
    win:maximize(0)
  elseif windowSizes[id] ~= nil then
    local prevFrame = windowSizes[id]
    windowSizes[id] = nil
    win:setFrame(prevFrame, 0)
  end
end)

-- maximize vertically
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "v", function()
  win, frame, screen, viewp = rsutils()
  frame.y = viewp.y
  frame.h = viewp.h
  win:setFrame(frame, 0)
end)

-- send to left screen
hs.hotkey.bind({"alt", "ctrl"}, "left", function()
  win, frame, screen, viewp = rsutils()
  win:moveOneScreenWest()
end)

-- send to right screen
hs.hotkey.bind({"alt", "ctrl"}, "right", function()
  win, frame, screen, viewp = rsutils()
  win:moveOneScreenEast()
end)

-- sizes window to half width, right aligned, max height
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "c", function()
  win, frame, screen, viewp = rsutils()
  local sevenths = viewp.w / 7
  frame.x = viewp.x + sevenths
  frame.y = viewp.y
  frame.w = viewp.w - sevenths * 2
  frame.h = viewp.h
  win:setFrame(frame, 0)
end)

-- switch to and from a given app
function activateAppOnCmd(appName, key)
  prevFrontmost = nil
  hs.hotkey.bind({"cmd"}, key, function()
    currentFrontmost = hs.application.frontmostApplication()
    if currentFrontmost:name() ~= appName then
      prevFrontmost = hs.application.frontmostApplication()
      app = hs.application.get(appName)
      if (app) then
        app:activate()
      end
    else
      prevFrontmost:activate()
      prevFrontmost = nil
    end
  end)
end

-- experimental
function getCurrentSpaceWindowsForApp()
  log:d('Current Space Windows')
  apps = hs.application.runningApplications()
  for name, app in pairs(apps) do
    for title, window in pairs(app:visibleWindows()) do
      log:d(app:name(), ': ', window:title())
      if app:name() == 'Google Chrome' then
        log:d(hs.inspect(app:selectMenuItem({"Bookmarks", "tag"})))
      end
    end
  end
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "s", getCurrentSpaceWindowsForApp)
