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


---@alias SteamID string
---@alias LeaderboardID string

---@module SimpleLeaderboard.Leaderboard
print("SimpleLeaderboard - Shared - Leaderboard - Loading")

---@generic T
---@class FactionLeadersTable
---@field public players PlayerRecordsTable
---@field public record T



---@generic T
---@class Leaderboard<T>
---@field public REGISTERED_LEADERBOARDS_TABLE_SUFFIX string
---@field public REGISTERED_LEADERBOARDS_TABLE_NAME string
---@field public ID LeaderboardID
---@field public MODULE_PREFIX string
---@field public TABLE_PREFIX string
---@field public PLAYER_LEADERS_TABLE_NAME_SUFFIX string
---@field public PLAYER_RECORDS_TABLE_NAME_SUFFIX string
---@field public FACTION_LEADERS_TABLE_NAME_SUFFIX string
---@field public FACTION_RECORDS_TABLE_NAME_SUFFIX string
---@field public PLAYER_LEADERS_TABLE_NAME string
---@field public PLAYER_RECORDS_TABLE_NAME string
---@field public FACTION_LEADERS_TABLE_NAME string
---@field public FACTION_RECORDS_TABLE_NAME string
---@field public registered_leaderboards table<LeaderboardID, Leaderboard<T>>
---@field public player_leaders_table PlayerLeadersTable
---@field public faction_leaders_table FactionLeadersTable
local Leaderboard = {}

local Constants = require("SimpleLeaderboard/Constants")
local mod_name = Constants.MOD_NAME

local Settings = require("SimpleLeaderboard/Settings")

local Factions = require("SimpleLeaderboard/Factions")

Leaderboard.REGISTERED_LEADERBOARDS_TABLE_SUFFIX = "RegisteredLeaderboards"
Leaderboard.REGISTERED_LEADERBOARDS_TABLE_NAME = mod_name..Leaderboard.REGISTERED_LEADERBOARDS_TABLE_SUFFIX

Leaderboard.ID = "Base"
Leaderboard.MODULE_PREFIX = "Leaderboard"

Leaderboard.PLAYER_LEADERS_TABLE_NAME_SUFFIX = "Leaders"
Leaderboard.PLAYER_RECORDS_TABLE_NAME_SUFFIX = "PlayerRecords"

Leaderboard.FACTION_LEADERS_TABLE_NAME_SUFFIX = "FactionLeaders"
Leaderboard.FACTION_RECORDS_TABLE_NAME_SUFFIX = "FactionRecords"


Leaderboard.registered_leaderboards = Leaderboard.registered_leaderboards or {}

---@public
---@param leaderboardID LeaderboardID
---@return Leaderboard
function Leaderboard:derive(leaderboardID)
    --- Usage should be MyLeaderboard = Leaderboard:derive("MyLeaderboard")
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.ID = leaderboardID
    return o
end

---@public
---@generic T
---@param leaderboardID string
---@return Leaderboard<T>
function Leaderboard.getLeaderboard(leaderboardID)
    local leaderboard = Leaderboard.registered_leaderboards[leaderboardID]
    if leaderboard == nil then
        error("SimpleLeaderboard: Attempted to get a leaderboard that does not exist: "..leaderboardID)
    end
    return leaderboard
end

---@public
---@return nil
function Leaderboard:setup()
    --- Usage should be MyLeaderboard:setup() right before returning the module
    self.TABLE_PREFIX = mod_name..self.ID..self.MODULE_PREFIX

    self.PLAYER_LEADERS_TABLE_NAME = self.TABLE_PREFIX .. self.PLAYER_LEADERS_TABLE_NAME_SUFFIX
    self.PLAYER_RECORDS_TABLE_NAME = self.TABLE_PREFIX .. self.PLAYER_RECORDS_TABLE_NAME_SUFFIX

    self.FACTION_LEADERS_TABLE_NAME = self.TABLE_PREFIX .. self.FACTION_LEADERS_TABLE_NAME_SUFFIX
    self.FACTION_RECORDS_TABLE_NAME = self.TABLE_PREFIX .. self.FACTION_RECORDS_TABLE_NAME_SUFFIX

    Events.OnInitGlobalModData:Add(function(newGame)
        self.player_leaders_table = ModData:getOrCreate(self.PLAYER_LEADERS_TABLE_NAME)
        self.faction_leaders_table = ModData:getOrCreate(self.FACTION_LEADERS_TABLE_NAME)
    end)

    self.settings = Settings.getLeaderboardSettings(self.ID)
    self:register()
end

---@private
---@return nil
function Leaderboard:register()
    --- Please do not manually call this function, use Leaderboard:setup() instead
    table.insert(Leaderboard.registered_leaderboards, self)
end


---@public
---@generic T
---@param player IsoPlayer
---@param value T
---@return nil
function Leaderboard:updateRecord(player, value)
    local faction = Faction:getPlayerFaction(player)

    if faction ~= nil then
        self:updateFactionPlayerRecord(faction, player, value)
    end
    self:updatePlayerRecord(player, value)
end

---@public
---@generic T
---@param faction Faction
---@param player IsoPlayer
---@param value T
---@return nil
function Leaderboard:updateFactionPlayerRecord(faction, player, value)
    local factionID = faction:getID()
    local steamID = player:getSteamID()
    Factions.setLeaderboardFactionPlayerRecord(self.ID, factionID, steamID, value)
    self:adjustFactionPlayerRecord(faction, player, value)
    self:calculateFactionRecord(faction, value)
end

---@public
---@generic T
---@param faction Faction
---@param player IsoPlayer
---@param value T
---@return nil
function Leaderboard:adjustFactionPlayerRecord(faction, player, value)
    local factionID = faction:getName()
    local steamID = player:getSteamID()
    local playerRecord = Factions.getLeaderboardFactionPlayerRecord(self.ID, factionID, steamID)
    local deltaValue = playerRecord.currentValue - playerRecord.initialValue
    playerRecord.adjustedValue = playerRecord.historicalValue + deltaValue
end

---@public
---@param faction Faction
---@return nil
function Leaderboard:calculateFactionRecord(faction)
    local factionID = Faction:getName()
    local factionRecords = Factions.getLeaderboardFactionRecord(self.ID, factionID)
    totalValue = 0
    for _, playerRecord in pairs(factionRecords.players) do
        totalValue = totalValue + playerRecord.currentValue
    end
    return totalValue
end

---@public
---@param player IsoPlayer
---@param value int
---@return nil
function Leaderboard:updatePlayerRecord(player, value)
    local steamID = player:getSteamID()
    Players.setPlayerRecord(steamID, self.ID, value)
end

---@public
---@generic T
---@param playerA T
---@param playerB T
---@return boolean
function Leaderboard:comparePlayerRecords(playerA, playerB)
    --- Compare two records, used to determine record sorting
    return playerA.record > playerB.record
end

---@private
---@param newGame boolean
---@return nil
local function onInitGlobalModData(newGame)
    Leaderboard.registered_leaderboards = ModData:getOrCreate(Leaderboard.REGISTERED_LEADERBOARDS_TABLE_NAME)
end
Events.OnInitGlobalModData:Add(onInitGlobalModData)

return Leaderboard
