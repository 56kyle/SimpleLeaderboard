
---@alias PlayerRecord any
---@alias PlayerRecordsTable table<LeaderboardID, PlayerRecord>


print("SimpleLeaderboard - Shared - Players - Loading")


---@class SimpleLeaderboard.Players
---@field MODULE_PREFIX string
---@field TABLE_PREFIX string
---@field RECORDS_TABLE_SUFFIX string
---@field RECORDS_TABLE_NAME string
---@field records table<SteamID, PlayerRecordsTable>
---@field getPlayerLeaderboardRecord fun(steamID: SteamID, leaderboardID: LeaderboardID): PlayerRecord
---@field setPlayerLeaderboardRecord fun(steamID: SteamID, leaderboardID: LeaderboardID, value: any): void
---@field registerModData fun(newGame: boolean): nil
local Players = {}

local Constants = require("SimpleLeaderboard/Constants")
local mod_name = Constants.MOD_NAME

Players.MODULE_PREFIX = "Players"
Players.TABLE_PREFIX = mod_name..Players.MODULE_PREFIX

Players.RECORDS_TABLE_SUFFIX = "Records"
Players.RECORDS_TABLE_NAME = Players.TABLE_PREFIX..Players.RECORDS_TABLE_SUFFIX


---@public
---@generic T
---@param steamID SteamID
---@return PlayerRecord
function Players.getPlayerRecord(steamID)
    local playerRecords = Players.records[steamID]
    if not playerRecords then
        playerRecords = {}
        Players.records[steamID] = playerRecords
    end
    return playerRecords
end

---@public
---@generic T
---@param steamID SteamID
---@param leaderboardID LeaderboardID
---@return T | nil
function Players.getPlayerLeaderboardRecord(steamID, leaderboardID)
    local playerRecords = Players.getPlayerRecord(steamID)
    return playerRecords[leaderboardID]
end

---@public
---@generic T
---@param steamID SteamID
---@param leaderboardID LeaderboardID
---@return nil
function Players.setPlayerLeaderboardRecord(steamID, leaderboardID, value)
    local playerRecords = Players.records[steamID]
    playerRecords[leaderboardID] = value
end


---@public
---@param newGame boolean
---@return nil
function Players.registerModData(newGame)
    Players.records = ModData:getOrCreate(Players.RECORDS_TABLE_NAME)
end
Events.OnInitGlobalModData:Add(Players.registerModData)


return Players
