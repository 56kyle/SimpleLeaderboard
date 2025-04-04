--- SimpleLeaderboard Client UI
-- @module SimpleLeaderboardClientUI

require "ISUI/ISPanel"
require "ISUI/ISButton"
require "ISUI/ISWindow"
require "ISUI/ISComboBox"

require "SimpleLeaderboard/UI/ISLeaderboardToggle"
require "SimpleLeaderboard/UI/ISLeaderboardWindow"
require "SimpleLeaderboard/UI/ISPlayerFactionToggle"

local SimpleLeaderboardClientUI = {}

local leaderboardWindow = ISSimpleLeaderboardWindow:new(200, 200, 300, 300)
leaderboardWindow:initialise()
leaderboardWindow:setVisible(false)

local toggleButton

-- Fix references here
local function createToggleButton()
    toggleButton = ISLeaderboardToggle:new(10, 200, 50, 25, "", nil, function()
        leaderboardWindow:setVisible(not leaderboardWindow:isVisible())
        if leaderboardWindow:isVisible() then
            leaderboardWindow:bringToTop()
        end
    end)
    toggleButton:initialise()
    toggleButton:instantiate()
    UIManager.addUI(toggleButton)
end

function SimpleLeaderboardClientUI.getLeaderboardWindow()
    return leaderboardWindow
end

function SimpleLeaderboardClientUI.createToggleButton()
    createToggleButton()
end

return SimpleLeaderboardClientUI
