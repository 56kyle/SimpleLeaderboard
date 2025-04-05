
local API = {}



local Leaderboard = SimpleLeaderboard.Leaderboard


---@public
---@return nil
function API.showRegisteredLeaderboards()
    print("API.listLeaderboards")
    local leaderboards = Leaderboard.getLeaderboards()
    for _, leaderboard in ipairs(leaderboards) do
        print("\t" .. leaderboard)
    end
end





return API
