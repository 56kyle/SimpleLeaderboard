
print("SimpleLeaderboard - Shared - Settings - Loading")

---@module SimpleLeaderboard.Settings
---@field defaultLeaderboard LeaderboardSettings
---@field getLeaderboardSettings fun(leaderboardID: LeaderboardID): LeaderboardSettings
local Settings = {}

---@class LeaderboardSettings : table
---@field leaderboardSize int
---@field clientMaxRequestInterval GameHours
---@field dataBroadcastInterval GameHours
---@field dataIntakeInterval GameHours
Settings.defaultLeaderboard = {
    LeaderboardSize = SandboxVars.SimpleLeaderboard.LeaderboardSize,
    ClientMaxRequestInterval = SandboxVars.SimpleLeaderboard.ClientMaxRequestInterval,
    DataBroadcastInterval = SandboxVars.SimpleLeaderboard.DataBroadcastInterval,
    DataIntakeInterval = SandboxVars.SimpleLeaderboard.DataIntakeInterval,
}

---@public
---@param leaderboardID LeaderboardID
---@return LeaderboardSettings
function Settings.getLeaderboardSettings(leaderboardID)
    SandboxVars[leaderboardID] = SandboxVars[leaderboardID] or {}
    for settingName, defaultValue in pairs(Settings.defaultLeaderboard) do
        SandboxVars[leaderboardID][settingName] = SandboxVars[leaderboardID][settingName] or defaultValue
    end
    return SandboxVars[leaderboardID]
end


---@class ArchiveSettings : table
---@field ArchiveSweepInterval GameHours
---@field ArchiveInactivityThreshold GameDays
Settings.ArchiveSweepInterval = SandboxVars.SimpleLeaderboard.ArchiveSweepInterval
Settings.ArchiveInactivityThreshold = SandboxVars.SimpleLeaderboard.ArchiveInactivityThreshold

return Settings
