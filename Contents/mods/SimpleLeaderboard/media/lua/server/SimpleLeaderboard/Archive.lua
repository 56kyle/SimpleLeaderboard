
if not isServer() then return end
if not SimpleLeaderboard then return end
if not SimpleLeaderboard.Server then return end

SimpleLeaderboard.Server.Archive = SimpleLeaderboard.Archive
local Archive = SimpleLeaderboard.Server.Archive

local Leaderboard = SimpleLeaderboard.Leaderboard
local Settings = SimpleLeaderboard.Settings
local Util = SimpleLeaderboard.Util

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


Events.OnInitGlobalModData.Add(function(newGame)
    Archive.archived_players_table = ModData.getOrCreate(Archive.ARCHIVED_PLAYERS_TABLE_NAME)
    Archive.last_seen_table = ModData.getOrCreate(Archive.LAST_SEEN_TABLE_NAME)
end)


