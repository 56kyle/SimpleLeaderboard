
if not SimpleLeaderboard then return end

local Leaderboard = SimpleLeaderboard.Leaderboard

Leaderboard.name = "SimpleLeaderboard"
Leaderboard.leaders_table_name_suffix = "Leaders"
Leaderboard.records_table_name_suffix = "Records"

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
function Leaderboard:setup()
    self.leaders_table_name = self.name .. self.leaders_table_name_suffix
    self.records_table_name = self.name .. self.records_table_name_suffix

    self.leaders_table = ModData.getOrCreate(self.leaders_table_name)
    self.records_table = ModData.getOrCreate(self.records_table_name)

    Leaderboard.registered_leaderboards.insert(self)
end


---@public
---@return nil
function Leaderboard:sortLeaders()
    table.sort(self.leaders_table, function(a, b) return a[2] < b[2] end)
end


---@public
---@param username string
---@return boolean
function Leaderboard:isLeader(username)
    return self.leaders_table.exists(username)
end


---@private
---@return fun(key: string, data: table|false)
function Leaderboard:getUpdateRecordCallback()
    ---@private
    ---@param key string
    ---@param data table|false
    ---@return nil
    local function updateLeadersOnRecordChange(key, data)
        if key == self.records_table_name

    end
end

Events.OnReceiveGlobalModData.Add()

