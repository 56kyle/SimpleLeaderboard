
print("SimpleLeaderboard - Client - Commands - Top")
if not isClient() then return end
print("SimpleLeaderboard - Client - Commands - Loading")

---@class SimpleLeaderboardClient.Client.Commands
local Commands = {}

local Constants = SimpleLeaderboard.Constants
local MOD_NAME = Constants.MOD_NAME

local Leaderboard = SimpleLeaderboard.Leaderboard


local API = require("SimpleLeaderboard/API")



---@public
---@param player IsoPlayer
---@param args any[]
function Commands.syncClientLeaderboardFactionLeaders(player, args)
    print("Commands.syncClientLeaderboardFactionLeaders")
    local leaderboardID = args[1]
    if not leaderboardID then
        print("[".. MOD_NAME .."] No leaderboardID provided.")
        return
    end
    API.requestLeaderboardFactionLeaders(leaderboardID)
end


---@public
---@param player IsoPlayer
---@param args any[]
function Commands.syncClientLeaderboardPlayerLeaders(player, args)
    print("Commands.syncClientLeaderboardPlayerLeaders")
    local leaderboardID = args[1]
    if not leaderboardID then
        print("[".. MOD_NAME .."] No leaderboardID provided.")
        return
    end
    API.requestLeaderboardPlayerLeaders(leaderboardID)
end

return Commands
