---@class SimpleExampleLeaderboard.ExampleLeaderboard

---@type Leaderboard
local Leaderboard = require("SimpleLeaderboard/Leaderboard")


---@class ExampleLeaderboard : Leaderboard
local ExampleLeaderboard = Leaderboard:derive("Example")

function ExampleLeaderboard:adjustFactionPlayerRecord(faction, player, record)
    print("ExampleLeaderboard:adjustFactionPlayerRecord")
end

ExampleLeaderboard:setup()
return ExampleLeaderboard
