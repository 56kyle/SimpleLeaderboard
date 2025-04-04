
local Factions = SimpleLeaderboard.Factions


local API = {}


---@public
---@generic T
---@param leaderboardID LeaderboardID
---@param factionName FactionName
---@param record LeaderboardFactionRecord<T>
---@return nil
function API.updateClientLeaderboardFactionRecord()
    Leaderboard.player_factions_table
end

return API

