-- media/lua/client/SimpleLeaderboard/UI/ISLeaderboardToggle.lua

require "ISUI/ISButton"
require "ISUI/ISEquippedItem"


---@class ISLeaderboardToggle : ISButton
ISLeaderboardToggle = ISButton:derive("ISLeaderboardToggle")

local textureOff = getTexture("media/textures/ranking_off.png")
local textureOn  = getTexture("media/textures/ranking_on.png")

---@public
---@param onmousedown function
---@param allowMouseUpProcessing boolean
function ISLeaderboardToggle:new(onmousedown, allowMouseUpProcessing)
    if not ISEquippedItem or not ISEquippedItem.instance then
        print("SimpleLeaderboard - ISLeaderboardToggle:new - Failed to get ISEquippedItem or ISEquippedItem.instance")
    end
    local movableBtnY = ISEquippedItem.instance.movableBtn:getY()
    local movableBtnHeight = ISEquippedItem.instance.movableBtn:getHeight()
    local y = movableBtnY + movableBtnHeight + 340
    local o = ISButton:new(
            0,
            y,
            50,
            50,
            "",
            nil,
            nil,
            onmousedown,
            allowMouseUpProcessing
    )
    setmetatable(o, self)
    self.__index = self
    o.borderColor = { r = 1, g = 1, b = 1, a = 0.1 }
end

function ISLeaderboardToggle:initialise()
    self:setImage(textureOff)
    self:setDisplayBackground(false)
    self:setVisible(true)
    self:setAlwaysOnTop(true)
    ISEquippedItem.instance:addChild(self)
    ISEquippedItem.instance:setHeight(math.max(ISEquippedItem.instance:getHeight(), self:getY() + 400))
end
