-- media/lua/client/SimpleLeaderboard/SimpleLeaderboardClientUI.lua

require "ISUI/ISPanel"
require "ISUI/ISButton"
require "ISUI/ISWindow"
require "ISUI/ISComboBox"
require "ISUI/ISEquippedItem"

local ISPlayerFactionToggle = require("SimpleLeaderboard/UI/ISPlayerFactionToggle")

local SimpleLeaderboardClientUI = {}

------------------------------------------------
-- Load toggle images for the scoreboard button
------------------------------------------------

-- Place these PNGs in YourMod/media/textures/
local textureOff = getTexture("media/textures/ranking_off.png")
local textureOn  = getTexture("media/textures/ranking_on.png")

if not textureOff then
    print("WARNING: ranking_off.png not found!")
end
if not textureOn then
    print("WARNING: ranking_on.png not found!")
end

------------------------------------------------
-- Scoreboard Window Class
------------------------------------------------

---@class ISSimpleLeaderboardWindow : ISWindow
local ISSimpleLeaderboardWindow = ISWindow:derive("ISSimpleLeaderboardWindow")

function ISSimpleLeaderboardWindow:new(x, y, width, height)
    -- “title, x, y, width, height” signature
    local windowTitle = getText("UI_SimpleLeaderboard_WindowTitle")
    local o = ISWindow:new(windowTitle, x, y, width, height)
    setmetatable(o, self)
    self.__index = self

    o.resizable = false
    o.isFaction = false  -- whether scoreboard is in faction mode
    return o
end

function ISSimpleLeaderboardWindow:initialise()
    ISWindow.initialise(self)

    -- #1 Faction toggle inside scoreboard
    self.factionToggle = ISPlayerFactionToggle:new(10, 10, 100, 25, self.isFaction, function(newVal)
        self.isFaction = newVal
        self:requestCurrentLeaderboard()
    end)
    self.factionToggle:initialise()
    self.factionToggle:instantiate()
    self:addChild(self.factionToggle)

    -- #2 Leaderboard combo box
    self.comboBox = ISComboBox:new(10, 50, self.width - 20, 20, self, ISSimpleLeaderboardWindow.onComboBoxChange)
    self.comboBox:initialise()
    self:addChild(self.comboBox)

    -- #3 Panel for scoreboard entries
    self.outputPanel = ISPanel:new(10, 80, self.width - 20, self.height - 90)
    self.outputPanel:initialise()
    self:addChild(self.outputPanel)
end

function ISSimpleLeaderboardWindow:onComboBoxChange(combo)
    local selText = combo.options[combo.selected]
    if not selText then return end
    local baseName = selText:match("^(.-)%s?%(") or selText
    self.currentLeaderboardName = baseName
    self:requestCurrentLeaderboard()
end

function ISSimpleLeaderboardWindow:requestCurrentLeaderboard()
    if not self.currentLeaderboardName then return end
    local actualName = self.currentLeaderboardName
    if self.isFaction then
        actualName = actualName .. "_Faction"
    end
    sendClientCommand("SimpleLeaderboard", "RequestLeaderboard", { leaderboard_name = actualName })
end

function ISSimpleLeaderboardWindow:updateLeaderboardList(listData)
    self.comboBox.options = {}
    for _, lb in ipairs(listData) do
        local text = lb.name
        if lb.unit and lb.unit ~= "" then
            text = text .. " (" .. lb.unit .. ")"
        end
        self.comboBox:addOption(text)
    end
end

function ISSimpleLeaderboardWindow:updateLeaderboardData(lbName, data)
    self.outputPanel:clearChildren()
    if not data or #data == 0 then
        local lbl = ISLabel:new(0, 0, 20, getText("UI_SimpleLeaderboard_NoDataAvailable"), 1,1,1,1, UIFont.Small)
        lbl:initialise()
        self.outputPanel:addChild(lbl)
        return
    end

    local yOff = 0
    for i, row in ipairs(data) do
        local txt
        if row.factionName then
            txt = string.format("#%d %s - %s", i, row.factionName, row.displayScore or row.score or "0")
        else
            local uname = row.username or ("ID:" .. (row.steamID or "Unknown"))
            txt = string.format("#%d %s - %s", i, uname, row.displayScore or row.score or "0")
        end

        local label = ISLabel:new(0, yOff, 20, txt, 1,1,1,1, UIFont.Small)
        label:initialise()
        self.outputPanel:addChild(label)
        yOff = yOff + 15
    end
end

-- Single scoreboard window instance
SimpleLeaderboardClientUI.scoreboardWin = ISSimpleLeaderboardWindow:new(200, 200, 300, 300)
local scoreboardWin = SimpleLeaderboardClientUI.scoreboardWin
scoreboardWin:initialise()
scoreboardWin:setVisible(false)

local toggleButton


function SimpleLeaderboardClientUI.toggleLeaderboardWindow()
    print("SimpleLeaderboardClientUI.toggleLeaderboardWindow")
    if scoreboardWin:isVisible() then
        SimpleLeaderboardClientUI.hideLeaderboardWindow()
    else
        SimpleLeaderboardClientUI.showLeaderboardWindow()
    end
end

function SimpleLeaderboardClientUI.showLeaderboardWindow()
    print("SimpleLeaderboardClientUI.showLeaderboardWindow")
    if not scoreboardWin.isInitialised then
        scoreboardWin.isInitialised = true
        scoreboardWin:initialise()
        scoreboardWin:instantiate()
        scoreboardWin:addToUIManager()
    end
    scoreboardWin:setVisible(true)
    scoreboardWin:bringToTop()
    toggleButton:setImage(textureOn)
end

function SimpleLeaderboardClientUI.hideLeaderboardWindow()
    print("SimpleLeaderboardClientUI.hideLeaderboardWindow")
    scoreboardWin:setVisible(false)
    toggleButton:setImage(textureOff)
end

------------------------------------------------
-- Window references
------------------------------------------------

function SimpleLeaderboardClientUI.getLeaderboardWindow()
    print("SimpleLeaderboardClientUI.getLeaderboardWindow")
    return scoreboardWin
end

function SimpleLeaderboardClientUI.addToolbarButton()
    toggleButton = ISButton:new(0, ISEquippedItem.instance.movableBtn:getY() + ISEquippedItem.instance.movableBtn:getHeight() + 340, 50, 50, "", nil, SimpleLeaderboardClientUI.toggleLeaderboardWindow)
    toggleButton:setImage(textureOff)
    toggleButton:setDisplayBackground(false)
    toggleButton.borderColor = { r = 1, g = 1, b = 1, a = 0.1 }

    ISEquippedItem.instance:addChild(toggleButton)
    ISEquippedItem.instance:setHeight(math.max(ISEquippedItem.instance:getHeight(), toggleButton:getY() + 400))
end

return SimpleLeaderboardClientUI
