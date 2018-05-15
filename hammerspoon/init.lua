-- TODO
-- * setup layouts for each space
hs.alert.show("Hammerspoon Config loaded")

log = hs.logger.new('config', 'debug')

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

function rsutils()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local viewp  = screen:frame()
  return win, frame, screen, viewp
end

-- sizes window to 3rds width, left aligned, max height
hs.hotkey.bind({"shift", "alt", "ctrl"}, "down", function()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x
  frame.y = viewp.y
  frame.w = (viewp.w / 6) * 4
  frame.h = viewp.h
  win:setFrame(frame)
end)

-- sizes window to 3rds width, right aligned, max height
hs.hotkey.bind({"shift", "alt", "ctrl"}, "up", function()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x + (viewp.w / 6) * 2
  frame.y = viewp.y
  frame.w = (viewp.w / 6) * 4
  frame.h = viewp.h
  win:setFrame(frame)
end)

-- sizes window to half width, left aligned, max height
hs.hotkey.bind({"shift", "alt", "ctrl"}, "left", function()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x
  frame.y = viewp.y
  frame.w = viewp.w / 2
  frame.h = viewp.h
  win:setFrame(frame)
end)

-- sizes window to half width, right aligned, max height
hs.hotkey.bind({"shift", "alt", "ctrl"}, "right", function()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x + viewp.w / 2
  frame.y = viewp.y
  frame.w = viewp.w / 2
  frame.h = viewp.h
  win:setFrame(frame)
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
    win:maximize()
  elseif windowSizes[id] ~= nil then
    local prevFrame = windowSizes[id]
    windowSizes[id] = nil
    win:setFrame(prevFrame)
  end
end)

-- maximize vertically
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "v", function()
  win, frame, screen, viewp = rsutils()
  frame.y = viewp.y
  frame.h = viewp.h
  win:setFrame(frame)
end)

-- send to left screen
hs.hotkey.bind({"alt", "ctrl"}, "left", function()
  local win = hs.window.focusedWindow()
  win:moveOneScreenWest()
end)

-- send to right screen
hs.hotkey.bind({"alt", "ctrl"}, "right", function()
  local win = hs.window.focusedWindow()
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
  win:setFrame(frame)
end)


-- switch to and from Note taking app
prevFrontmost = nil
hs.hotkey.bind({"cmd"}, "F2", function()
  currentFrontmost = hs.application.frontmostApplication()
  if currentFrontmost:name() ~= 'Notion' then
    prevFrontmost = hs.application.frontmostApplication()
    hs.application.get('Notion'):activate()
  else
    prevFrontmost:activate()
    prevFrontmost = nil
  end
end)

-- enhance desktop switch shortcuts to switch vertical screen as well
-- do this only for the Hackintosh
if string.find(hs.host.localizedName(), "DEACTIVATEDHackintosh") ~= nil then
  currentDesktop = nil
  firstDesktopFrontmost = nil
  secondDesktopFrontmost = nil
  thirdDesktopFrontmost = nil
  doAfterWait = 0.3

  hs.hotkey.bind({"alt", "shift"}, "p", function()
    if currentDesktop == 2 then
      secondDesktopFrontmost = hs.application.frontmostApplication()
    end
    if currentDesktop == 3 then
      thirdDesktopFrontmost = hs.application.frontmostApplication()
    end
    hs.eventtap.keyStroke({"alt", "shift"}, "0")
    currentDesktop = 1
    hs.timer.doAfter(doAfterWait, function()
      if firstDesktopFrontmost then
        firstDesktopFrontmost:activate()
      end
    end)
  end)
  hs.hotkey.bind({"alt", "shift"}, "[", function()
    if currentDesktop == 1 then
      firstDesktopFrontmost = hs.application.frontmostApplication()
    end
    if currentDesktop == 3 then
      thirdDesktopFrontmost = hs.application.frontmostApplication()
    end
    hs.eventtap.keyStroke({"alt", "shift"}, "-")
    currentDesktop = 2
    hs.timer.doAfter(doAfterWait, function()
      if secondDesktopFrontmost then
        secondDesktopFrontmost:activate()
      end
    end)
  end)
  hs.hotkey.bind({"alt", "shift"}, "]", function()
    if currentDesktop == 1 then
      firstDesktopFrontmost = hs.application.frontmostApplication()
    end
    if currentDesktop == 2 then
      secondDesktopFrontmost = hs.application.frontmostApplication()
    end
    hs.eventtap.keyStroke({"alt", "shift"}, "=")
    currentDesktop = 3
    hs.timer.doAfter(doAfterWait, function()
      if thirdDesktopFrontmost then
        thirdDesktopFrontmost:activate()
      end
    end)
  end)
  hs.hotkey.bind({"alt", "shift"}, "l", function()
    currentDesktop = 4
  end)
  hs.hotkey.bind({"alt", "shift"}, ";", function()
    currentDesktop = 5
  end)
  hs.hotkey.bind({"alt", "shift"}, "'", function()
    currentDesktop = 6
  end)
end

-- TODO
-- use some of the code below to override cmd+d on chrome and launch pinboard instead

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
