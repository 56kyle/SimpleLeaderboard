
print("SimpleLeaderboard - Shared - Main - Top")
SimpleLeaderboard = SimpleLeaderboard or {
    Client = {},
    Commands = {},
    Constants = {},
    Leaderboard = {},
    Players = {},
    Server = {},
    Settings = {},
    Util = {},
}

SimpleLeaderboard.Constants = require("SimpleLeaderboard/Constants")
SimpleLeaderboard.Settings = require("SimpleLeaderboard/Settings")
SimpleLeaderboard.Util = require("SimpleLeaderboard/Util")
SimpleLeaderboard.Players = require("SimpleLeaderboard/Players")
SimpleLeaderboard.Leaderboard = require("SimpleLeaderboard/Leaderboard")

print("SimpleLeaderboard - Shared - Main - Done Loading")
