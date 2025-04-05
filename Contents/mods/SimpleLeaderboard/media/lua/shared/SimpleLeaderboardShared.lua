
print("SimpleLeaderboard - Shared - Main - Top")

---@module SimpleLeaderboard
---@field Constants SimpleLeaderboard.Constants
---@field Factions SimpleLeaderboard.Factions
---@field Leaderboard SimpleLeaderboard.Leaderboard
---@field Players SimpleLeaderboard.Players
---@field Settings SimpleLeaderboard.Settings
---@field Util SimpleLeaderboard.Util
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
