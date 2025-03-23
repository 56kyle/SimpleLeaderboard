
print("SimpleLeaderboard - Server - Players - Top")
if not isServer() then return end
print("SimpleLeaderboard - Server - Players - Loading")

local Players = SimpleLeaderboard.Players

-----@public
-----@param newGame boolean
-----@return nil
function Players.registerModData(newGame)
    Players.all_players = ModData.getOrCreate(Players.ALL_PLAYERS_TABLE_NAME)
end

Events.OnInitGlobalModData.Add(Players.registerModData)

return Players
