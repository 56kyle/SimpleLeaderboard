
print("SimpleLeaderboard - Shared - Settings - Top")
if not SimpleLeaderboard then return end
print("SimpleLeaderboard - Shared - Settings - Loading")

local Settings = SimpleLeaderboard.Settings

Settings.leaderboard_size = SandboxOptions.SimpleLeaderboard.leaderboard_size
Settings.max_data_request_interval = SandboxOptions.SimpleLeaderboard.max_data_request_interval
Settings.data_broadcast_interval = SandboxOptions.SimpleLeaderboard.data_broadcast_interval
Settings.data_intake_interval = SandboxOptions.SimpleLeaderboard.data_intake_interval
Settings.archive_sweep_interval = SandboxOptions.SimpleLeaderboard.player_archive_sweep_interval
Settings.archive_inactivity_threshold = SandboxOptions.SimpleLeaderboard.archive_inactivity_threshold


return Settings
