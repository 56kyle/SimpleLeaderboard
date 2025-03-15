
if not isClient() then return end
if not SimpleLeaderboard then return end
if not SimpleLeaderboard.Client then return end

local ClientLeaderboard = SimpleLeaderboard.Client.Leaderboard


---@public
---@return nil
function ClientLeaderboard:requestLeadersTable()
    return ModData.request(self.leaders_table)
end


---@public
---@param player IsoPlayer
---@param changes table
---@return nil
function ClientLeaderboard:submitPlayerChanges(player, changes)
    local username = player.getUsername()
    local pending_player_changes = self.pending_changes_table.getOrCreate(username)
    pending_player_changes.append()
    table.insert(changes)
    self.pending_changes_table.add()
end



