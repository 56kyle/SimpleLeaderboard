
print("SimpleLeaderboard - Shared - Players - Top")
if not SimpleLeaderboard then return end
print("SimpleLeaderboard - Shared - Players - Loading")

local Players = SimpleLeaderboard.Players

local mod_name = SimpleLeaderboard.MOD_NAME


Players.MODULE_PREFIX = "Players"
Players.TABLE_PREFIX = mod_name..Players.MODULE_PREFIX


Players.ALL_TABLE_SUFFIX = "All"
Players.ALL_TABLE_NAME = Players.TABLE_PREFIX..Players.ALL_TABLE_SUFFIX



return Players
