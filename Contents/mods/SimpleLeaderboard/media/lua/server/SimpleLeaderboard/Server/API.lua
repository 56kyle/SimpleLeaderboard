
local API = {}

local Leaderboard = SimpleLeaderboard.Leaderboard
local pprint = require("pprint")


---@public
---@return nil
function API.listLeaderboards()
    print("API.listLeaderboards")
    for leaderboardID, _ in ipairs(Leaderboard.registered_leaderboards) do
        print("\t" .. leaderboardID)
    end
end


---@public
---@return nil
function API.viewLeaderboard()
    print("API.viewLeaderboard")
    local leaderboardID = args[1]
    if not leaderboardID then
        print("No leaderboardID provided.")
        return
    end

    local leaderboard = Leaderboard.getLeaderboard(leaderboardID)
    if not leaderboard then
        print("Leaderboard not found: " .. leaderboardID)
        return
    end

    pprint.pprint(leaderboard)
end





return API
