
print("SimpleLeaderboard - Client - Main - Top")
if not isClient() then return end
print("SimpleLeaderboard - Client - Main - Loading")


local Client = SimpleLeaderboard.Client

Client.Commands = require("SimpleLeaderboard/Commands")
Client.Leaderboard = require("SimpleLeaderboard/Leaderboard")

return Client
