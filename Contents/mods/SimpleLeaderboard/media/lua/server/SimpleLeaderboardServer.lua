--- SimpleLeaderboard Server

local Constants = SimpleLeaderboard.Constants
local MOD_NAME = Constants.MOD_NAME

local Commands = require("SimpleLeaderboard/Client/Commands")

local Util = SimpleLeaderboard.Util

---@class SimpleLeaderboardServer
local SimpleLeaderboardServer = {}


---@public
---@param module string
---@param command string
---@param player IsoPlayer
---@param args table
---@return nil
local function onClientCommand(module, command, player, args)
    print("[".. MOD_NAME .."] onClientCommand")
    print("\tmodule = "..module)
    print("\tcommand = "..command)
    print("\tsteamID = "..player:getSteamID())
    if module == MOD_NAME then
        local command_handler = Commands[command]
        local playerName = player:getUsername()
        if command_handler then
            print("[".. MOD_NAME .."] Running command \""..command.."\" for player \""..playerName.."\".")
            command_handler(player, args)
        else
            print("[".. MOD_NAME .."] Unknown command \""..command.."\" from player \""..playerName.."\"!")
        end
    end
end
Events.OnClientCommand.Add(onClientCommand)


return SimpleLeaderboardServer
