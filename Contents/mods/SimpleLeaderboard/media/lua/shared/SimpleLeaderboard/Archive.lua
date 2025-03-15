if not SimpleLeaderboard then return end

local Archive = SimpleLeaderboard.Archive

local Leaderboard = SimpleLeaderboard.Leaderboard
local Settings = SimpleLeaderboard.Settings
local Util = SimpleLeaderboard.Util


Archive.archived_players_table_name = "SimpleLeaderboardArchivedPlayers"
Archive.archived_players_table = ModData.getOrCreate(Archive.archived_players_table_name)

Archive.last_seen_table_name = "SimpleLeaderboardLastSeen"
Archive.last_seen_table = ModData.getOrCreate(Archive.last_seen_table_name)


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
    return Settings.archive_inactivity_threshold <= hours_since_last_seen and not Leaderboard.isLeader(player_name)
end

