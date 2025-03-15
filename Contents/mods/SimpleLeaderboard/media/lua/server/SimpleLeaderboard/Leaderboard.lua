
if not isClient() then return end
if not SimpleLeaderboard then return end
if not SimpleLeaderboard.Server then return end

SimpleLeaderboard.Server.Leaderboard = SimpleLeaderboard.Leaderboard
local ServerLeaderboard = SimpleLeaderboard.Server.Leaderboard
