
print("SimpleLeaderboard - Server - Leaderboard - Top")
if not isServer() then return end
if not SimpleLeaderboard then return end
if not SimpleLeaderboard.Server then return end
print("SimpleLeaderboard - Server - Leaderboard - Loading")

SimpleLeaderboard.Server.Leaderboard = SimpleLeaderboard.Leaderboard
local ServerLeaderboard = SimpleLeaderboard.Server.Leaderboard



---@public
---@param newGame boolean
---@return nil
function ServerLeaderboard.onInitGlobalModData(newGame)

end


Events.OnInitGlobalModData.Add()


return ServerLeaderboard
