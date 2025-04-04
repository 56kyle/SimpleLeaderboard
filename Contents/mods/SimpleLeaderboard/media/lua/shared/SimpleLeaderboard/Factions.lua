
---@alias FactionName string

---@generic T
---@alias LeaderboardRecord table<FactionName, LeaderboardFactionRecord<T>>

---@generic T
---@class LeaderboardFactionRecord
---@field public players table<SteamID, LeaderboardFactionPlayerRecord<T>>
---@field public record T

---@generic T
---@class LeaderboardFactionPlayerRecord
---@field public historicalTotal T
---@field public initialValue T
---@field public currentValue T

---@module SimpleLeaderboard.Factions
---@generic T
---@field public MODULE_PREFIX string
---@field public TABLE_PREFIX string
---@field public RECORDS_TABLE_SUFFIX string
---@field public RECORDS_TABLE_NAME string
---@field public recordsTable table<LeaderboardID, LeaderboardRecord>
---@field public getLeaderboardFactionPlayerRecord fun(leaderboardID: LeaderboardID, factionName: FactionName, steamID: SteamID): LeaderboardFactionPlayerRecord<T>
---@field public setLeaderboardFactionPlayerRecord fun(leaderboardID: LeaderboardID, factionName: FactionName, steamID: SteamID, value: any): void
---@field public getLeaderboardFactionRecord fun(leaderboardID: LeaderboardID, factionName: FactionName): LeaderboardFactionRecord<T>
---@field public setLeaderboardFactionRecord fun(leaderboardID: LeaderboardID, factionName: FactionName, value: T): void
---@field public getLeaderboardRecord fun(leaderboardID: LeaderboardID): LeaderboardRecord<T>
---@field public registerModData fun(newGame: boolean): nil
local Factions = {}

local Constants = require("SimpleLeaderboard/Constants")
local mod_name = Constants.MOD_NAME

Factions.MODULE_PREFIX = "Factions"
Factions.TABLE_PREFIX = mod_name..Factions.MODULE_PREFIX

Factions.RECORDS_TABLE_SUFFIX = "Records"
Factions.RECORDS_TABLE_NAME = Factions.TABLE_PREFIX..Factions.RECORDS_TABLE_SUFFIX

---@public
---@generic T
---@param leaderboardID LeaderboardID
---@param factionName FactionName
---@param steamID SteamID
---@return LeaderboardFactionPlayerRecord<T>
function Factions.getLeaderboardFactionPlayerRecord(leaderboardID, factionName, steamID)
    local factionRecord = Factions.getLeaderboardFactionRecord(leaderboardID, factionName)
    Factions.recordsTable[leaderboardID][factionName][steamID] = factionRecord.players[steamID] or {
        historicalTotal = 0,
        initialValue = 0,
        currentValue = 0
    }
    return Factions.recordsTable[leaderboardID][factionName][steamID]
end

---@public
---@generic T
---@param leaderboardID LeaderboardID
---@param factionName FactionName
---@param steamID SteamID
---@param value any
function Factions.setLeaderboardFactionPlayerRecord(leaderboardID, factionName, steamID, value)
    local playerRecord = Factions.getLeaderboardFactionPlayerRecord(leaderboardID, factionName, steamID)
    playerRecord.currentValue = value
end

---@public
---@generic T
---@param leaderboardID LeaderboardID
---@param factionName FactionName
---@return LeaderboardFactionRecord<T>
function Factions.getLeaderboardFactionRecord(leaderboardID, factionName)
    local leaderboardRecord = Factions.getLeaderboardRecord(leaderboardID)
    Factions.recordsTable[leaderboardID][factionName] = leaderboardRecord[factionName] or {
        players = {},
        record = 0
    }
    return Factions.recordsTable[leaderboardID][factionName]
end

---@public
---@generic T
---@param leaderboardID LeaderboardID
---@param factionName FactionName
---@param value T
function Factions.setLeaderboardFactionRecord(leaderboardID, factionName, value)
    local factionRecord = Factions.getLeaderboardFactionRecord(leaderboardID, factionName)
    factionRecord.record = value
end

---@public
---@generic T
---@param leaderboardID LeaderboardID
---@return LeaderboardRecord<T>
function Factions.getLeaderboardRecord(leaderboardID)
    Factions.recordsTable[leaderboardID] = Factions.recordsTable[leaderboardID] or {}
    return Factions.recordsTable[leaderboardID]
end


---@private
---@param newGame boolean
---@return nil
function Factions.registerModData(newGame)
    Factions.recordsTable = ModData:getOrCreate(Factions.RECORDS_TABLE_NAME)
end
Events.OnInitGlobalModData.Add(Factions.registerModData)


return Factions
