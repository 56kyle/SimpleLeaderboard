
print("SimpleLeaderboard - Shared - Main - Top")
SimpleLeaderboard = SimpleLeaderboard or {
    Constants = {},
    Factions = {},
    Leaderboard = {},
    Players = {},
    Settings = {},
    Util = {},
}

SimpleLeaderboard.Constants = require("SimpleLeaderboard/Constants")
SimpleLeaderboard.Settings = require("SimpleLeaderboard/Settings")
SimpleLeaderboard.Util = require("SimpleLeaderboard/Util")
SimpleLeaderboard.Players = require("SimpleLeaderboard/Players")
SimpleLeaderboard.Factions = require("SimpleLeaderboard/Factions")
SimpleLeaderboard.Leaderboard = require("SimpleLeaderboard/Leaderboard")

print("SimpleLeaderboard - Shared - Main - Done Loading")
