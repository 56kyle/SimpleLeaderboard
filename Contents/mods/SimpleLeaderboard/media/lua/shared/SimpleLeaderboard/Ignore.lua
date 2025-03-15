if not SimpleLeaderboard then return end

local Ignore = SimpleLeaderboard.Server.Ignore

Ignore.ignored_players_table_name = "SimpleLeaderboardIgnoredPlayers"
Ignore.ignored_players = ModData.getOrCreate(Ignore.ignored_players_table_name)
