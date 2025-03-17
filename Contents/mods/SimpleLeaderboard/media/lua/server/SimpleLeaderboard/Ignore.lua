
print("SimpleLeaderboard - Server - Ignore - Top")
if not isServer() then return end
if not SimpleLeaderboard then return end
if not SimpleLeaderboard.Server then return end
print("SimpleLeaderboard - Server - Ignore - Loading")

SimpleLeaderboard.Server.Ignore = SimpleLeaderboard.Ignore
local ServerIgnore = SimpleLeaderboard.Server.Ignore


ServerIgnore.ignored_players = ModData.getOrCreate(ServerIgnore.IGNORED_PLAYERS_TABLE_NAME)

return ServerIgnore
