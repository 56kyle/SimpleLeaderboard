-- media/lua/client/SimpleLeaderboard/SimpleLeaderboardClient.lua

local SimpleLeaderboardClientUI = require("SimpleLeaderboard/ClientUI")

local SimpleLeaderboardClient = {}
local leaderboardWindow = SimpleLeaderboardClientUI.getLeaderboardWindow()

function SimpleLeaderboardClient.requestLeaderboardList()
    sendClientCommand("SimpleLeaderboard", "RequestLeaderboardList", {})
end

function SimpleLeaderboardClient.debugCheck()
    sendClientCommand("SimpleLeaderboard", "DebugCheck", {})
end

local function onServerCommand(module, command, args)
    if module ~= "SimpleLeaderboard" then return end

    if command == "SendLeaderboardList" then
        local boards = args.board_names or {}
        leaderboardWindow:updateLeaderboardList(boards)

    elseif command == "SendLeaderboardData" then
        local lbName = args.leaderboard_name
        local data = args.leaderboard_data
        leaderboardWindow:updateLeaderboardData(lbName, data)

    elseif command == "DebugResponse" then
        print("Server says: " .. (args.message or "No message"))
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
