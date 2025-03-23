
print("SimpleLeaderboard - Server - Leaderboard - Top")
if not isServer() then return end
print("SimpleLeaderboard - Server - Leaderboard - Loading")


local Leaderboard = SimpleLeaderboard.Leaderboard


---@public
---@return nil
function Leaderboard:setup()
    self.LEADERS_TABLE_NAME = self.TABLE_PREFIX .. self.LEADERS_TABLE_NAME_SUFFIX
    self.RECORDS_TABLE_NAME = self.TABLE_PREFIX .. self.RECORDS_TABLE_NAME_SUFFIX

    Events.OnInitGlobalModData.Add(function (newGame)
        self.leaders_table = ModData.getOrCreate(self.LEADERS_TABLE_NAME)
        self.records_table = ModData.getOrCreate(self.RECORDS_TABLE_NAME)
    end)

    table.insert(Leaderboard.registered_leaderboards, self)
end


Leaderboard:setup()

return Leaderboard
