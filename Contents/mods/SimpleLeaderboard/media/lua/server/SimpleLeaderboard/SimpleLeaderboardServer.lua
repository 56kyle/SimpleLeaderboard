--- SimpleLeaderboard Server

local Constants = SimpleLeaderboard.Constants
local SimpleLeaderboardShared = require("SimpleLeaderboard/SimpleLeaderboardShared")
local SimpleLeaderboardIgnore = require("SimpleLeaderboard/SimpleLeaderboardIgnore")
local Util = SimpleLeaderboard.Util

---@module SimpleLeaderboardServer
local SimpleLeaderboardServer = {}


---@public
---@param module string
---@param command string
---@param player IsoPlayer
---@param args table
---@return nil
local function onClientCommand(module, command, player, args)
    print("Commands.onClientCommand")
    print("\tmodule = "..module)
    print("\tcommand = "..command)
    print("\tsteamID = "..player:getSteamID())
    if module == mod_name then
        local command_handler = Commands[command]
        local playerName = player:getUsername()
        if command_handler then
            print("[".. mod_name .."] Running command \""..command.."\" for player \""..playerName.."\".")
            command_handler(player, args)
        else
            print("[".. mod_name .."] Unknown command \""..command.."\" from player \""..playerName.."\"!")
        end
    end
end
Events.OnClientCommand.Add(onClientCommand)


return SimpleLeaderboardServer
