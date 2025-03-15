
if not isClient() then return end
if not SimpleLeaderboard then return end
if not SimpleLeaderboard.Server then return end

local Archive = SimpleLeaderboard.Server.Archive

Archive.archived_players_table_name = "SimpleLeaderboardArchivedPlayers"
Archive.archived_players = ModData.getOrCreate(Archive.archived_players_table_name)


function Archive.archiveInactivePlayers()
    return
end



