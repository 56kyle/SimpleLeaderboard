
print("SimpleLeaderboard - Server - Ignore - Top")
if not isServer() then return end
print("SimpleLeaderboard - Server - Ignore - Loading")

local Ignore = {}

local mod_name = SimpleLeaderboard.Constants.MOD_NAME

Ignore.MODULE_PREFIX = "Ignore"
Ignore.TABLE_PREFIX = mod_name..Ignore.MODULE_PREFIX
Ignore.IGNORED_PLAYERS_TABLE_NAME_SUFFIX = "IgnoredPlayers"
Ignore.IGNORED_PLAYERS_TABLE_NAME = Ignore.TABLE_PREFIX..Ignore.IGNORED_PLAYERS_TABLE_NAME_SUFFIX

---@public
---@param steam_id long
---@return boolean
function Ignore.isIgnored(steam_id)
    return Ignore.ignored_players[steam_id] == true
end

---@public
---@param steam_id long
---@return nil
function Ignore.ignorePlayer(steam_id)
    if not Ignore.ignored_players[steam_id] then
        Ignore.ignored_players[steam_id] = true
    end
    ModData:transmit(Ignore.IGNORED_PLAYERS_TABLE_NAME)
end

---@public
---@param steam_id long
---@return nil
function Ignore.unIgnorePlayer(steam_id)
    if Ignore.ignored_players[steam_id] then
        Ignore.ignored_players[steam_id] = nil
    end
    ModData:transmit(Ignore.IGNORED_PLAYERS_TABLE_NAME)
end

---@public
---@param newGame boolean
---@return nil
function Ignore.registerModData(newGame)
    Ignore.ignored_players = ModData:getOrCreate(Ignore.IGNORED_PLAYERS_TABLE_NAME)
end
Events.OnInitGlobalModData:Add(Ignore.registerModData)

return Ignore
