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
  log:d(viewp)
  frame.x = viewp.x
  frame.y = viewp.y
  frame.w = (viewp.w / 3) * 2
  frame.h = viewp.h
  win:setFrame(frame)
end)

-- sizes window to 3rds width, right aligned, max height
hs.hotkey.bind({"shift", "alt", "ctrl"}, "up", function()
  win, frame, screen, viewp = rsutils()
  frame.x = viewp.x + viewp.w / 3
  frame.y = viewp.y
  frame.w = (viewp.w / 3) * 2
  frame.h = viewp.h
  win:setFrame(frame)
end)

-- sizes window to half width, left aligned, max height
hs.hotkey.bind({"shift", "alt", "ctrl"}, "left", function()
  win, frame, screen, viewp = rsutils()
  log:d(viewp)
  frame.x = viewp.x
  frame.y = viewp.y
  frame.w = viewp.w / 2
  frame.h = viewp.h
  win:setFrame(frame)
end)

-- sizes window to half width, right aligned, max height
hs.hotkey.bind({"shift", "alt", "ctrl"}, "right", function()
  win, frame, screen, viewp = rsutils()
  log:d(viewp)
  frame.x = viewp.x + viewp.w / 2
  frame.y = viewp.y
  frame.w = viewp.w / 2
  frame.h = viewp.h
  win:setFrame(frame)
end)

-- TODO
--
-- move window to left/right screen, keep size
-- maximize window
-- center window
