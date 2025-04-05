---@alias PlayerRecord any

---@alias PlayerRecordsTable table<SteamID, PlayerRecord>


print("SimpleLeaderboard - Shared - Players - Loading")
---@module SimpleLeaderboard.Players
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
---@param leaderboardID LeaderboardID
---@return T
function Players.getPlayerLeaderboardRecord(steamID, leaderboardID)
    local playerRecords = Players.records[steamID]
    if not playerRecords then
        playerRecords = {}
        Players.records[steamID] = playerRecords
    end
    local playerLeaderboardRecords = playerRecords[leaderboardID]
    if not playerLeaderboardRecords then
        playerLeaderboardRecords = {}
        playerRecords[leaderboardID] = playerLeaderboardRecords
    end
end


function Players.setPlayerLeaderboardRecord(steamID, leaderboardID, value)
    local playerRecords = Players
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
