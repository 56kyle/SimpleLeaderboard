
print("SimpleLeaderboard - Shared - Ignore - Top")
if not SimpleLeaderboard then return end
print("SimpleLeaderboard - Shared - Ignore - Loading")

local Ignore = SimpleLeaderboard.Server.Ignore

local mod_name = SimpleLeaderboard.MOD_NAME

Ignore.MODULE_PREFIX = "Ignore"
Ignore.TABLE_PREFIX = mod_name..Ignore.MODULE_PREFIX
Ignore.IGNORED_PLAYERS_TABLE_NAME_SUFFIX = "IgnoredPlayers"
Ignore.IGNORED_PLAYERS_TABLE_NAME = Ignore.TABLE_PREFIX..Ignore.IGNORED_PLAYERS_TABLE_NAME_SUFFIX

return Ignore
