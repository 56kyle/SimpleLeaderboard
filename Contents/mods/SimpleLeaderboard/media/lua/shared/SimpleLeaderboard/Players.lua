
print("SimpleLeaderboard - Shared - Players - Loading")


local Players = {}


local Constants = require("SimpleLeaderboard/Constants")
local mod_name = Constants.MOD_NAME


Players.MODULE_PREFIX = "Players"
Players.TABLE_PREFIX = mod_name..Players.MODULE_PREFIX

Players.ALL_PLAYERS_TABLE_SUFFIX = "AllPlayers"
Players.ALL_PLAYERS_TABLE_NAME = Players.TABLE_PREFIX..Players.ALL_PLAYERS_TABLE_SUFFIX


---@public
---@param newGame boolean
---@return nil
function Players.registerModData(newGame)
    Players.all_players = ModData:getOrCreate(Players.ALL_PLAYERS_TABLE_NAME)
end
Events.OnInitGlobalModData.Add(Players.registerModData)


return Players
