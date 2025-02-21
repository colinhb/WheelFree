--- WheelFree.spoon/init.lua
local obj = {}

-- Metadata
obj.name = "WheelFree"
obj.version = "0.1"
obj.author = "C.H. Bortner <colin@chb.xyz>"
obj.license = "MIT - https://opensource.org/licenses/MIT"
-- Optional: obj.homepage = "https://github.com/colinhb/WheelFree.spoon"

-- Configuration variables
obj.scrollButton = 2
obj.deferClick = false     -- Flag to track if we should perform a click after drag
obj.scrollmult = -4        -- Scroll multiplication factor (negative for "natural" scrolling)

--- WheelFree:getButtonNumber(e)
--- Helper function to extract the mouse button number from an event.
---
--- Parameters:
---  * e - An hs.eventtap event object
---
--- Returns:
---  * The mouse button number (number)
function obj:getButtonNumber(e)
  return e:getProperty(hs.eventtap.event.properties["mouseEventButtonNumber"])
end

--- WheelFree:init()
--- Method
--- Prepares the WheelFree Spoon by creating the necessary eventtap objects.
---
--- Returns:
---  * The WheelFree object
function obj:init()
  -- Initialize the event taps table
  self.taps = {}

  -- Create an event tap for the initial mouse button press
  self.taps.mouseDown = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(e)
    local pressedButton = self:getButtonNumber(e)
    if pressedButton == self.scrollButton then
      self.deferClick = true
      return true  -- Stop propagation for our scroll button
    end
    return false
  end)

  -- Create an event tap for the mouse button release
  self.taps.mouseUp = hs.eventtap.new({ hs.eventtap.event.types.otherMouseUp }, function(e)
    local releasedButton = self:getButtonNumber(e)
    if releasedButton == self.scrollButton then
      if self.deferClick then
        -- Stop and then restart the taps to simulate a middle click
        self:stop()
        hs.eventtap.otherClick(e:location(), releasedButton)
        self:start()
        return true
      end
      return false
    end
    return false
  end)

  -- Create an event tap to convert dragging into scroll events
  self.taps.mouseDragged = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDragged }, function(e)
    local draggedButton = self:getButtonNumber(e)
    if draggedButton == self.scrollButton then
      self.deferClick = false  -- Cancel deferred click since we are dragging
      local oldmousepos = hs.mouse.absolutePosition()
      local dx = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaX"])
      local dy = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaY"])
      local scroll = hs.eventtap.event.newScrollEvent({ -dx * self.scrollmult, dy * self.scrollmult }, {}, "pixel")
      hs.mouse.absolutePosition(oldmousepos)  -- Reset the mouse position
      return true, { scroll }
    else
      return false, {}
    end
  end)

  return self
end

-- Note: We're using pairs() to iterate over taps which means the start/stop
-- order is non-deterministic. If tap order becomes important, we could switch to
-- table.insert() during init and ipairs() here to control the order.

--- WheelFree:start()
--- Method
--- Starts the event watchers for middle mouse scrolling.
---
--- Returns:
---  * The WheelFree object
function obj:start()
  for _, tap in pairs(self.taps) do
    if tap then tap:start() end
  end
  return self
end

--- WheelFree:stop()
--- Method
--- Stops the event watchers.
---
--- Returns:
---  * The WheelFree object
function obj:stop()
  for _, tap in pairs(self.taps) do
    if tap then tap:stop() end
  end
  return self
end

return obj
