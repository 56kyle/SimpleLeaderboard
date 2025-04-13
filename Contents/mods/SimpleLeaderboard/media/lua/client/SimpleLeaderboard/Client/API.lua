
local Leaderboard = SimpleLeaderboard.Leaderboard


local API = {}


---@public
---@return nil
function API.listLeaderboards()
    print("SimpleLeaderboard - API - listLeaderboards")
    for leaderboardID, _ in pairs(Leaderboard.registered_leaderboards) do
        print("\t" .. leaderboardID)
    end
end

---@public
---@generic T
---@param leaderboardID LeaderboardID
---@return nil
function API.requestLeaderboardFactionLeaders(leaderboardID)
    local leaderboard = Leaderboard.getLeaderboard(leaderboardID)
    if not leaderboard then
        print("SimpleLeaderboard - API - requestLeaderboardFactionLeaders - Leaderboard not found: " .. leaderboardID)
        return
    end
    ModData:request(leaderboard.FACTION_LEADERS_TABLE_NAME)
end

---@public
---@generic T
---@param leaderboardID LeaderboardID
---@return nil
function API.requestLeaderboardPlayerLeaders(leaderboardID)
    local leaderboard = Leaderboard.getLeaderboard(leaderboardID)
    if not leaderboard then
        print("SimpleLeaderboard - API - requestLeaderboardPlayerLeaders - Leaderboard not found: " .. leaderboardID)
        return
    end
    ModData:request(leaderboard.PLAYER_LEADERS_TABLE_NAME)
end

return API

