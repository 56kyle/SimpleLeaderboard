
print("SimpleLeaderboard - Shared - Settings - Loading")

local Settings = {}

Settings.leaderboard_size = SandboxVars.SimpleLeaderboard.LeaderboardSize
Settings.max_data_request_interval = SandboxVars.SimpleLeaderboard.MaxDataRequestInterval
Settings.data_broadcast_interval = SandboxVars.SimpleLeaderboard.DataBroadcastInterval
Settings.data_intake_interval = SandboxVars.SimpleLeaderboard.DataIntakeInterval
Settings.archive_sweep_interval = SandboxVars.SimpleLeaderboard.ArchiveSweepInterval
Settings.archive_inactivity_threshold = SandboxVars.SimpleLeaderboard.ArchiveInactivityThreshold

return Settings
