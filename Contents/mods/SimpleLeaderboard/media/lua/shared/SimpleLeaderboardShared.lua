
print("SimpleLeaderboard - Shared - Main - Top")
SimpleLeaderboard = SimpleLeaderboard or {
    Client = {
        Commands = {},
        Leaderboard = {},
        UI = {
            Menu = {},
            Panel = {},
            Tab = {},
            Table = {}
        },
    },
    Server = {
        Archive = {},
        Commands = {},
        Leaderboard = {},
        Players = {},
    },
    Archive = {},
    Ignore = {},
    Leaderboard = {},
    Players = {},
    Settings = {},
    Util = {},
    MOD_NAME = "SimpleLeaderboard",
}

SimpleLeaderboard.Settings = require("SimpleLeaderboard/Settings")
SimpleLeaderboard.Util = require("SimpleLeaderboard/Util")
SimpleLeaderboard.Players = require("SimpleLeaderboard/Players")
SimpleLeaderboard.Archive = require("SimpleLeaderboard/Archive")
SimpleLeaderboard.Ignore = require("SimpleLeaderboard/Ignore")
SimpleLeaderboard.Leaderboard = require("SimpleLeaderboard/Leaderboard")

print("SimpleLeaderboard - Shared - Main - Done Loading")

return SimpleLeaderboard
