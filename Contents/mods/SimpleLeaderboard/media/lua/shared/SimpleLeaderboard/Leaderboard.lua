
print("SimpleLeaderboard - Shared - Leaderboard - Loading")

local Leaderboard = {}

local Constants = require("SimpleLeaderboard/Constants")
local mod_name = Constants.MOD_NAME


Leaderboard.MODULE_PREFIX = "Leaderboard"
Leaderboard.TABLE_PREFIX = mod_name..Leaderboard.MODULE_PREFIX

Leaderboard.LEADERS_TABLE_NAME_SUFFIX = "Leaders"
Leaderboard.RECORDS_TABLE_NAME_SUFFIX = "Records"

Leaderboard.registered_leaderboards = Leaderboard.registered_leaderboards or {}

---@public
---@class
---@param o table
---@return table
function Leaderboard:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end


---@public
---@return nil
function Leaderboard:sortLeaders()
    table.sort(self.leaders_table, function(a, b) return a[2] < b[2] end)
end


---@public
---@param steam_id long
---@return boolean
function Leaderboard:isLeader(steam_id)
    return self.leaders_table[steam_id] ~= nil
end


---@public
---@return nil
function Leaderboard:setup()
    self.LEADERS_TABLE_NAME = self.TABLE_PREFIX .. self.LEADERS_TABLE_NAME_SUFFIX
    self.RECORDS_TABLE_NAME = self.TABLE_PREFIX .. self.RECORDS_TABLE_NAME_SUFFIX

    Events.OnInitGlobalModData.Add(function(newGame)
        self.leaders_table = ModData.getOrCreate(self.LEADERS_TABLE_NAME)
        self.records_table = ModData.getOrCreate(self.RECORDS_TABLE_NAME)
    end)

    table.insert(Leaderboard.registered_leaderboards, self)
end

return Leaderboard
