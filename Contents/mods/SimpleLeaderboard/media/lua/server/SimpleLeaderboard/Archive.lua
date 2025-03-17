
print("SimpleLeaderboard - Server - Archive - Top")
if not isServer() then return end
if not SimpleLeaderboard then return end
if not SimpleLeaderboard.Server then return end
print("SimpleLeaderboard - Server - Archive - Loading")


SimpleLeaderboard.Server.Archive = SimpleLeaderboard.Archive
local ServerArchive = SimpleLeaderboard.Server.Archive

local Leaderboard = SimpleLeaderboard.Leaderboard
local Settings = SimpleLeaderboard.Settings
local Util = SimpleLeaderboard.Util

---@public
---@return nil
function ServerArchive.archiveInactivePlayers()
    local current_time = getTimestamp()
    for player_name, last_seen in pairs(ServerArchive.last_seen_table) do
        local hours_since_last_seen = Util.secondsToHours(current_time - last_seen)
        if ServerArchive.isPlayerInactive(player_name, hours_since_last_seen) then
            ServerArchive.archivePlayer(player_name)
        end
    end
end


---@public
---@param player_name string
---@param hours_since_last_seen int
---@return boolean
function ServerArchive.isPlayerInactive(player_name, hours_since_last_seen)
    return Settings.archive_inactivity_threshold <= hours_since_last_seen and not Leaderboard.isLeader(player_name)
end


Events.OnInitGlobalModData.Add(function(newGame)
    ServerArchive.archived_players_table = ModData.getOrCreate(ServerArchive.ARCHIVED_PLAYERS_TABLE_NAME)
    ServerArchive.last_seen_table = ModData.getOrCreate(ServerArchive.LAST_SEEN_TABLE_NAME)
end)

return ServerArchive
