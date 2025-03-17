
print("SimpleLeaderboard - Client - Leaderboard - Top")
if not isClient() then return end
if not SimpleLeaderboard then return end
if not SimpleLeaderboard.Client then return end
print("SimpleLeaderboard - Client - Leaderboard - Loading")


local ClientLeaderboard = SimpleLeaderboard.Client.Leaderboard

---@public
---@return nil
function ClientLeaderboard:requestLeadersTable()
    return self.leaders_table:request()
end


return ClientLeaderboard
