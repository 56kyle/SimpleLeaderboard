
if not isServer() then return end
if not SimpleLeaderboard then return end
if not SimpleLeaderboard.Server then return end


SimpleLeaderboard.Server.Players = SimpleLeaderboard.Players
local ServerPlayers = SimpleLeaderboard.Players


ServerPlayers.all_players = ModData.getOrCreate(ServerPlayers.ALL_PLAYERS_TABLE_NAME)
