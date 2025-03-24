-- media/lua/client/SimpleLeaderboard/UI/ISPlayerFactionToggle.lua

require("ISUI/ISPanel")

---@class ISPlayerFactionToggle : ISPanel
local ISPlayerFactionToggle = ISPanel:derive("ISPlayerFactionToggle")

function ISPlayerFactionToggle:new(x, y, width, height, initialIsFaction, onToggle)
    local o = ISPanel.new(self, x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.isFaction = initialIsFaction or false
    o.onToggle = onToggle
    return o
end

function ISPlayerFactionToggle:initialise()
    ISPanel.initialise(self)
end

function ISPlayerFactionToggle:prerender()
    ISPanel.prerender(self)
    self:drawRectBorder(0, 0, self.width, self.height, 1, 1, 1, 1)

    local dotSize = self.height - 4
    local margin = 2
    local dotX = self.isFaction and (self.width - dotSize - margin) or margin
    local dotY = margin

    self:drawRectBorder(dotX, dotY, dotSize, dotSize, 1, 1, 1, 1)

    -- Use translations for "PLAYER"/"FACTION"
    local text
    if self.isFaction then
        text = getText("UI_SimpleLeaderboard_Faction")
    else
        text = getText("UI_SimpleLeaderboard_Player")
    end

    local textX = (self.width / 2) - (getTextManager():MeasureStringX(UIFont.Small, text) / 2)
    local textY = (self.height / 2) - (getTextManager():getFontFromEnum(UIFont.Small):getLineHeight() / 2)
    self:drawText(text, textX, textY, 1, 1, 1, 1, UIFont.Small)
end

function ISPlayerFactionToggle:onMouseUp(x, y)
    self.isFaction = not self.isFaction
    if self.onToggle then
        self.onToggle(self.isFaction)
    end
    return true
end

return ISPlayerFactionToggle
