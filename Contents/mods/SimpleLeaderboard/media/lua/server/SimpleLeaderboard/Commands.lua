
print("SimpleLeaderboard - Server - Commands - Top")
if not isServer() then return end
print("SimpleLeaderboard - Server - Commands - Loading")


local Commands = SimpleLeaderboard.Commands
local Leaderboard = SimpleLeaderboard.Leaderboard
local Constants = SimpleLeaderboard.Constants
local MOD_NAME = Constants.MOD_NAME

---@public
---@param player IsoPlayer
---@param leaderboardID LeaderboardID
---@return nil
local function printLeaderboard(player, leaderboardID)
    print("printLeaderboard")
    for k, v in pairs(Leaderboard.records) do
        print("\t"..k.." - "..v)
    end
end

---@public
---@param player IsoPlayer
---@param args table
---@return nil
function Commands.printLeaderboard(player, args)
    print("Commands.printLeaderboard")
    if not args[1] then
        print("No leaderboardID provided.")
        return
    end
    printLeaderboard(player, args[1])
end


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
