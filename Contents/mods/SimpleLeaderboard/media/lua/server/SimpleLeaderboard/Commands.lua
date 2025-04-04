
print("SimpleLeaderboard - Server - Commands - Top")
if not isServer() then return end
print("SimpleLeaderboard - Server - Commands - Loading")


local Commands = SimpleLeaderboard.Commands
local Leaderboard = SimpleLeaderboard.Leaderboard
local mod_name = SimpleLeaderboard.Constants.MOD_NAME

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







return Commands
