
print("SimpleLeaderboard - Server - Archive - Top")
if not isServer() then return end
print("SimpleLeaderboard - Server - Archive - Loading")


local Archive = {}

local Leaderboard = SimpleLeaderboard.Leaderboard
local Settings = SimpleLeaderboard.Settings
local Util = SimpleLeaderboard.Util


Archive.MODULE_PREFIX = "Archive"
Archive.TABLE_PREFIX = mod_name..Archive.MODULE_PREFIX


Archive.ARCHIVED_PLAYERS_TABLE_SUFFIX = "ArchivedPlayers"
Archive.ARCHIVED_PLAYERS_TABLE_NAME = Archive.TABLE_PREFIX..Archive.ARCHIVED_PLAYERS_TABLE_SUFFIX


Archive.LAST_SEEN_TABLE_SUFFIX = "LastSeen"
Archive.LAST_SEEN_TABLE_NAME = Archive.TABLE_PREFIX..Archive.LAST_SEEN_TABLE_SUFFIX


---@public
---@return nil
function Archive.archiveInactivePlayers()
    local current_time = getTimestamp()
    for player_name, last_seen in pairs(Archive.last_seen_table) do
        local hours_since_last_seen = Util.secondsToHours(current_time - last_seen)
        if Archive.isPlayerInactive(player_name, hours_since_last_seen) then
            Archive.archivePlayer(player_name)
        end
    end
end


---@public
---@param player_name string
---@param hours_since_last_seen int
---@return boolean
function Archive.isPlayerInactive(player_name, hours_since_last_seen)
    return Settings.ArchiveInactivityThreshold <= hours_since_last_seen and not Leaderboard.isLeader(player_name)
end


Events.OnInitGlobalModData:Add(function(newGame)
    Archive.archived_players_table = ModData:getOrCreate(Archive.ARCHIVED_PLAYERS_TABLE_NAME)
    Archive.last_seen_table = ModData:getOrCreate(Archive.LAST_SEEN_TABLE_NAME)
end)

return Archive
