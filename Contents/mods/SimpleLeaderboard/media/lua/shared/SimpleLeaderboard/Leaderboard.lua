
if not SimpleLeaderboard then return end

local Leaderboard = SimpleLeaderboard.Leaderboard

local mod_name = SimpleLeaderboard.MOD_NAME


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
function Leaderboard:setup()
    self.LEADERS_TABLE_NAME = self.TABLE_PREFIX .. self.LEADERS_TABLE_NAME_SUFFIX
    self.RECORDS_TABLE_NAME = self.TABLE_PREFIX .. self.RECORDS_TABLE_NAME_SUFFIX

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

--
-----@private
-----@return fun(key: string, data: table|false)
--function Leaderboard:getUpdateRecordCallback()
--    ---@private
--    ---@param key string
--    ---@param data table|false
--    ---@return nil
--    local function updateLeadersOnRecordChange(key, data)
--        if key:find(self.) then
--
--        end
--
--    end
--end
