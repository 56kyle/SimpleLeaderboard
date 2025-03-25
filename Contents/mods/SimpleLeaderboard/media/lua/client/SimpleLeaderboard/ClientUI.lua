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


return SimpleLeaderboardClientUI
