-- media/lua/client/SimpleLeaderboard/SimpleLeaderboardClient.lua
local Constants = SimpleLeaderboard.Constants
local MOD_NAME = Constants.MOD_NAME

local SimpleLeaderboardClientUI = require("SimpleLeaderboard/ClientUI")
local Commands = require("SimpleLeaderboard/Commands")
local API = require("SimpleLeaderboard/API")

local SimpleLeaderboardClient = {}


local function onServerCommand(module, command, args)
    if module ~= MOD_NAME then return end
    print("[" .. MOD_NAME .. "] onServerCommand")
    local callback = Commands[command]
    local player = getPlayer()
    local playerName = player:getUsername()
    if callback then
        print("[".. MOD_NAME .."] Running command \""..command.."\" for player \""..playerName.."\".")
        callback(player, args)
    else
        print("[".. MOD_NAME .."] Unknown command \""..command.."\" sent to player \""..playerName.."\"!")
    end
end
Events.OnServerCommand.Add(onServerCommand)

local function onGameStart()
    print("[".. MOD_NAME .."] onGameStart")
    API.requestLeaderboardList()
end
Events.OnGameStart.Add(onGameStart)

local function onCreatePlayer()
    print("[".. MOD_NAME .."] onCreatePlayer")
    SimpleLeaderboardClientUI.createToggleButton()
end
Events.OnCreatePlayer.Add(onCreatePlayer)

return SimpleLeaderboardClient
