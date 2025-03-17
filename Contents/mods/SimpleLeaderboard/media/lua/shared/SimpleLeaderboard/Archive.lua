
print("SimpleLeaderboard - Shared - Archive - Top")
if not SimpleLeaderboard then return end
print("SimpleLeaderboard - Shared - Archive - Loading")

local Archive = SimpleLeaderboard.Archive

local mod_name = SimpleLeaderboard.MOD_NAME


Archive.MODULE_PREFIX = "Archive"
Archive.TABLE_PREFIX = mod_name..Archive.MODULE_PREFIX


Archive.ARCHIVED_PLAYERS_TABLE_SUFFIX = "ArchivedPlayers"
Archive.ARCHIVED_PLAYERS_TABLE_NAME = Archive.TABLE_PREFIX..Archive.ARCHIVED_PLAYERS_TABLE_SUFFIX


Archive.LAST_SEEN_TABLE_SUFFIX = "LastSeen"
Archive.LAST_SEEN_TABLE_NAME = Archive.TABLE_PREFIX..Archive.LAST_SEEN_TABLE_SUFFIX

return Archive
