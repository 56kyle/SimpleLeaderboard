
print("SimpleLeaderboard - Server - Commands - Top")
if not isServer() then return end
print("SimpleLeaderboard - Server - Commands - Loading")

local Constants = SimpleLeaderboard.Constants
local MOD_NAME = Constants.MOD_NAME

local Commands = SimpleLeaderboard.Commands
local Leaderboard = SimpleLeaderboard.Leaderboard
local pprint = require("pprint")


---@public
---@param player IsoPlayer
---@param args table
---@return nil
function Commands.listLeaderboards(player, args)
    print("Commands.listLeaderboards")
    for leaderboardID, _ in pairs(Leaderboard.registered_leaderboards) do
        print("\t"..leaderboardID)
    end
end

---@public
---@param player IsoPlayer
---@param args table
---@return nil
function Commands.viewLeaderboard(player, args)
    print("Commands.viewLeaderboard")
    local leaderboardID = args[1]
    if not leaderboardID then
        print("No leaderboardID provided.")
        return
    end
    local leaderboard = Leaderboard.getLeaderboard(leaderboardID)
    if not leaderboard then
        print("[".. MOD_NAME .."] Leaderboard not found: " .. leaderboardID)
        return
    end
    pprint.pprint(leaderboard)
end

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
end





return Commands
