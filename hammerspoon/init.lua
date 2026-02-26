hs.alert.show("Hammerspoon Config loaded")

log = hs.logger.new('config', 'debug')

hs.hotkey.bind({"ctrl", "alt", "cmd"}, "R", function()
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

function resize3thirdsLeftAlignedMaxHeight()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x
  frame.y = viewp.y
  frame.w = (viewp.w / 8) * 6
  frame.h = viewp.h
  win:setFrame(frame, 0)
end
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "left", resize3thirdsLeftAlignedMaxHeight)

function resize3thirdsRightAlignedMaxHeight()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x + (viewp.w / 8) * 2
  frame.y = viewp.y
  frame.w = (viewp.w / 8) * 6
  frame.h = viewp.h
  win:setFrame(frame, 0)
end
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "right", resize3thirdsRightAlignedMaxHeight)


function resize1thirdLeftAlignedMaxHeight()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x
  frame.y = viewp.y
  frame.w = (viewp.w / 8) * 2
  frame.h = viewp.h
  win:setFrame(frame, 0)
end
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "up", resize1thirdLeftAlignedMaxHeight)


function resize1thirdRightAlignedMaxHeight()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x + (viewp.w / 8) * 6
  frame.y = viewp.y
  frame.w = (viewp.w / 8) * 2
  frame.h = viewp.h
  win:setFrame(frame, 0)
end
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "down", resize1thirdRightAlignedMaxHeight)

function resizeHalfWidthLeftAlignedMaxHeight()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x
  frame.y = viewp.y
  frame.w = viewp.w / 2
  frame.h = viewp.h
  win:setFrame(frame, 0)
end
hs.hotkey.bind({"alt", "cmd"}, "left", resizeHalfWidthLeftAlignedMaxHeight)

function resizeHalfWidthRightAlignedMaxHeight()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x + viewp.w / 2
  frame.y = viewp.y
  frame.w = viewp.w / 2
  frame.h = viewp.h
  win:setFrame(frame, 0)
end
hs.hotkey.bind({"alt", "cmd"}, "right", resizeHalfWidthRightAlignedMaxHeight)

windowSizes = {}

function checkIfCoordinatesAreClose(a, b)
  a = math.floor(a)
  b = math.floor(b)
  return math.abs(a - b) < 15
end

function isMaximized()
  win, frame, screen, viewp = rsutils()
  return checkIfCoordinatesAreClose(frame.x, viewp.x) and
         checkIfCoordinatesAreClose(frame.y, viewp.y) and
         checkIfCoordinatesAreClose(frame.w, viewp.w) and
         checkIfCoordinatesAreClose(frame.h, viewp.h)
end

function maximizeWindowOrReturnToPreviousSize()
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
end
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "m", maximizeWindowOrReturnToPreviousSize)

function maximizeVertically()
  win, frame, screen, viewp = rsutils()
  frame.y = viewp.y
  frame.h = viewp.h
  win:setFrame(frame, 0)
end
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "v", maximizeVertically)

function sendToLeftScreen()
  win, frame, screen, viewp = rsutils()
  win:moveOneScreenWest()
  win:maximize(0)
end
hs.hotkey.bind({"alt", "ctrl"}, "left", sendToLeftScreen)

function sendToRightScreen()
  win, frame, screen, viewp = rsutils()
  win:moveOneScreenEast()
  win:maximize(0)
end
hs.hotkey.bind({"alt", "ctrl"}, "right", sendToRightScreen)

function resizeCenteredHalfWidthRightAlignedMaxHeight()
  win, frame, screen, viewp = rsutils()
  local sevenths = viewp.w / 7
  frame.x = viewp.x + sevenths
  frame.y = viewp.y
  frame.w = viewp.w - sevenths * 2
  frame.h = viewp.h
  win:setFrame(frame, 0)
end
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "c", resizeCenteredHalfWidthRightAlignedMaxHeight)

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
  --apps = hs.application.runningApplications()
  apps = hs.window.allWindows()
  for name, app in pairs(apps) do
    --for title, window in pairs(app:visibleWindows()) do
      log:d(app:name(), ': ', window:title())
    --end
  end
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "s", getCurrentSpaceWindowsForApp)

-- Bundle IDs for the apps you want to manage
local appBundleIDs = {
    "org.mozilla.firefox",       -- Firefox
    "com.figma.Desktop",         -- Figma
    "com.google.Chrome",         -- Chrome
    "com.tinyspeck.slackmacgap", -- Slack
    "com.reederapp.5.macOS",     -- Reeder
    "com.jetbrains.intellij"     -- IntelliJ
}

-- Function to move all specified app windows in current Space only
function moveAllAppsEastCurrentSpace()
    local totalMoved = 0
    local allWindows = hs.window.allWindows()
    
    for _, window in ipairs(allWindows) do
        local app = window:application()
        if app then
            local bundleID = app:bundleID()
            
            -- Check if this window belongs to one of our target apps
            for _, targetBundleID in ipairs(appBundleIDs) do
                if bundleID == targetBundleID then
                    if window:isStandard() and window:isVisible() then
                        -- Move window east
                        window:moveOneScreenEast(true, true)
                        
                        window:maximize()
                        
                        totalMoved = totalMoved + 1
                    end
                    break
                end
            end
        end
    end
    
    hs.alert.show("Moved " .. totalMoved .. " windows (current Space)")
end

-- Function to move all specified app windows across all Spaces
function moveAllAppsEastAllSpaces()
    local currentSpace = hs.spaces.focusedSpace()
    local mainScreen = hs.screen.mainScreen()
    local mainScreenUUID = mainScreen:getUUID()
    local allSpaces = hs.spaces.allSpaces()
    local totalMoved = 0
    
    -- Get spaces for the main screen only and sort them
    local spaces = allSpaces[mainScreenUUID] or {}
    table.sort(spaces) -- This ensures we start from the first space
    
    print("Processing " .. #spaces .. " spaces on main screen")
    
    -- Iterate through spaces in order
    for i, spaceID in ipairs(spaces) do
        print("Switching to space " .. i .. " (ID: " .. tostring(spaceID) .. ")")
        
        -- Switch to this space
        hs.spaces.gotoSpace(spaceID)
        hs.timer.usleep(300000) -- 0.3 seconds to let the switch complete
        
        -- Look for target app windows in this space
        local allWindows = hs.window.allWindows()
        local movedInThisSpace = 0
        
        for _, window in ipairs(allWindows) do
            local app = window:application()
            if app then
                local bundleID = app:bundleID()
                
                -- Check if this window belongs to one of our target apps
                for _, targetBundleID in ipairs(appBundleIDs) do
                    if bundleID == targetBundleID then
                        if window:isStandard() and window:isVisible() then
                            print("  Moving: " .. (window:title() or "Untitled"))
                            
                            -- Move window east
                            window:moveOneScreenEast(true, true)
                            
                            window:maximize()
                            
                            totalMoved = totalMoved + 1
                            movedInThisSpace = movedInThisSpace + 1
                        end
                        break
                    end
                end
            end
        end
        
        print("  Moved " .. movedInThisSpace .. " windows in this space")
    end
    
    -- Return to original space
    print("Returning to original space: " .. tostring(currentSpace))
    hs.spaces.gotoSpace(currentSpace)
    
    hs.alert.show("Moved " .. totalMoved .. " windows (all Spaces)")
end

-- Hotkeys
hs.hotkey.bind({"ctrl", "alt"}, "s", function()
    moveAllAppsEastCurrentSpace()
end)

hs.hotkey.bind({"ctrl", "alt", "cmd"}, "s", function()
    moveAllAppsEastAllSpaces()
end)

