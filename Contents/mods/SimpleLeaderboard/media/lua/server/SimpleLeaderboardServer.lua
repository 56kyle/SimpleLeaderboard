
print("SimpleLeaderboard - Server - Main - Top")
if not isServer() then return end
print("SimpleLeaderboard - Server - Main - Loading")

local Server = SimpleLeaderboard.Server

Server.Commands = require("SimpleLeaderboard/Commands")
Server.Players = require("SimpleLeaderboard/Players")
Server.Archive = require("SimpleLeaderboard/Archive")
Server.Ignore = require("SimpleLeaderboard/Ignore")
Server.Leaderboard = require("SimpleLeaderboard/Leaderboard")

return Server
