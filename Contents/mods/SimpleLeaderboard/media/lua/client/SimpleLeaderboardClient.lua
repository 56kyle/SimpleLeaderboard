-- media/lua/client/SimpleLeaderboard/SimpleLeaderboardClient.lua
local Constants = SimpleLeaderboard.Constants
local MOD_NAME = Constants.MOD_NAME

local SimpleLeaderboardClientUI = require("SimpleLeaderboard/ClientUI")
local Commands = require("SimpleLeaderboard/Commands")

local SimpleLeaderboardClient = {}


local function onServerCommand(module, command, args)
    if module ~= MOD_NAME then return end
    local callback = Commands[command]
    local player = getPlayer()
    local playerName = player:getUsername()
    if callback then
        print("[".. MOD_NAME .."] Running command \""..command.."\" for player \""..playerName.."\".")
        callback(args)
    else
        print("[".. MOD_NAME .."] Unknown command \""..command.."\" sent to player \""..playerName.."\"!")
    end
end
Events.OnServerCommand.Add(onServerCommand)

local function onGameStart()
    SimpleLeaderboardClient.requestLeaderboardList()
end
Events.OnGameStart.Add(onGameStart)

local function onCreatePlayer()
    SimpleLeaderboardClientUI.addToolbarButton()
end
Events.OnCreatePlayer.Add(onCreatePlayer)

return SimpleLeaderboardClient
