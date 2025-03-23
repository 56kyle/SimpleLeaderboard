
print("SimpleLeaderboard - Client - Leaderboard - Top")
if not isClient() then return end
print("SimpleLeaderboard - Client - Leaderboard - Loading")

local ClientLeaderboard = SimpleLeaderboard.Leaderboard

---@public
---@return nil
function ClientLeaderboard:requestLeadersTable()
    print("ClientLeaderboard.requestLeadersTable")
    return self.leaders_table:request()
end


return ClientLeaderboard
