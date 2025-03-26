
print("SimpleLeaderboard - Shared - Leaderboard - Loading")

local Leaderboard = {}

local Constants = require("SimpleLeaderboard/Constants")
local mod_name = Constants.MOD_NAME


Leaderboard.MODULE_PREFIX = "Leaderboard"
Leaderboard.TABLE_PREFIX = mod_name..Leaderboard.MODULE_PREFIX

Leaderboard.REGISTERED_LEADERBOARDS_TABLE_SUFFIX = "RegisteredLeaderboards"
Leaderboard.REGISTERED_LEADERBOARDS_TABLE_NAME = mod_name..Leaderboard.REGISTERED_LEADERBOARDS_TABLE_SUFFIX

Leaderboard.PLAYER_LEADERS_TABLE_NAME_SUFFIX = "Leaders"
Leaderboard.PLAYER_RECORDS_TABLE_NAME_SUFFIX = "PlayerRecords"

Leaderboard.FACTION_LEADERS_TABLE_NAME_SUFFIX = "FactionLeaders"
Leaderboard.FACTION_RECORDS_TABLE_NAME_SUFFIX = "FactionRecords"


Leaderboard.registered_leaderboards = Leaderboard.registered_leaderboards or {}



-- Requirements
-- for the factions leaderboard, we should only track the stats a player acquired while in a faction
-- for the players leaderboard, it should be the players stats overall regardless of faction
-- try to keep the data as clean and efficient as possible, the goal is to have minimal overhead from requesting and transmitting data
-- the leaderboard should be able to handle a large number of players and stats
-- the default size of the leaderboard will be limited by Settings.MAX_LEADERBOARD_SIZE, while each new leaderboard mod may adjust this using their own mod settings
-- the leaderboard will only send info to clients by request, and will not broadcast data to clients
-- the leaderboard will be able to handle any data type, but will default to using integers
-- the leaderboard will be able to handle any number of leaderboards, each with their own unique data
-- the leaderboard should make use of ModData to store and transfer data between the server and clients
-- the leaderboard should be able to distinguish the breakdown of player contributions to a faction, and apply that to the factions leaderboard

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
    self.PLAYER_LEADERS_TABLE_NAME = self.TABLE_PREFIX .. self.PLAYER_LEADERS_TABLE_NAME_SUFFIX
    self.PLAYER_RECORDS_TABLE_NAME = self.TABLE_PREFIX .. self.PLAYER_RECORDS_TABLE_NAME_SUFFIX

    self.FACTION_LEADERS_TABLE_NAME = self.TABLE_PREFIX .. self.FACTION_LEADERS_TABLE_NAME_SUFFIX
    self.FACTION_RECORDS_TABLE_NAME = self.TABLE_PREFIX .. self.FACTION_RECORDS_TABLE_NAME_SUFFIX

    Events.OnInitGlobalModData.Add(function(newGame)

        ---@type table<string, int>
        self.player_leaders_table = ModData.getOrCreate(self.PLAYER_LEADERS_TABLE_NAME)
        ---@type table<string, int>
        self.player_records_table = ModData.getOrCreate(self.PLAYER_RECORDS_TABLE_NAME)

        ---@type table<string, int>
        self.faction_leaders_table = ModData.getOrCreate(self.FACTION_LEADERS_TABLE_NAME)
        self.faction_records_table = ModData.getOrCreate(self.FACTION_RECORDS_TABLE_NAME)
    end)

    self:register()
end


---@public
---@return nil
function Leaderboard:register()
    table.insert(Leaderboard.registered_leaderboards, self)
end


---@public
---@param player IsoPlayer
---@param value int
---@return nil
function Leaderboard:updateRecord(player, value)
    local faction = Faction:getPlayerFaction(player)

    if faction then
        self:updateFactionRecord(faction, value)
    end
    self:updatePlayerRecord(player, value)
end


---@public
---@param faction IsoFaction
---@param value int
---@return nil
function Leaderboard:updateFactionRecord(faction, value)
    local factionID = faction:getID()
end


---@public
---@param player IsoPlayer
---@param value int
---@return nil
function Leaderboard:updatePlayerRecord(player, value)
    local steamID = player:getSteamID()
end



---@private
---@param newGame boolean
---@return nil
local function onInitGlobalModData(newGame)
    Leaderboard.registered_leaderboards = ModData.getOrCreate(Leaderboard.REGISTERED_LEADERBOARDS_TABLE_NAME)
end
Events.OnInitGlobalModData.Add(onInitGlobalModData)


return Leaderboard
