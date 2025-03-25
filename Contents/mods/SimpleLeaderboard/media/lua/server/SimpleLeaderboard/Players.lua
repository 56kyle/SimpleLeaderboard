
print("SimpleLeaderboard - Server - Players - Top")
if not isServer() then return end
print("SimpleLeaderboard - Server - Players - Loading")

local Players = SimpleLeaderboard.Players

---@public
---@param steamID long
---@return nil
function Players.addPlayer(steamID)
    if not Players.all_players[steamID] then
        Players.all_players[steamID] = true
    end
    ModData:transmit(Players.ALL_PLAYERS_TABLE_NAME)
end

---@public
---@param steamID long
---@return nil
function Players.removePlayer(steamID)
    if Players.all_players[steamID] then
        Players.all_players[steamID] = nil
    end
    ModData:transmit(Players.ALL_PLAYERS_TABLE_NAME)
end


---@public
---@param playerNum integer
---@param player IsoPlayer
local function onCreatePlayer(playerNum, player)
    local steamID = player:getSteamID()
    if not Players.all_players[steamID] then
        Players.addPlayer(steamID)
    end
end
Events.OnCreatePlayer.Add(onCreatePlayer)


return Players
