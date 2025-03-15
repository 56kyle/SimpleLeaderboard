
SimpleLeaderboard = SimpleLeaderboard or {
    Client = {
        Commands = {},
        Leaderboard = {},
        UI = {
            Menu = {},
            Panel = {},
            Tab = {},
            Table = {}
        },
    },
    Server = {
        Archive = {},
        Commands = {},
        Leaderboard = {},
    },
    Archive = {},
    Ignore = {},
    Leaderboard = {},
    Settings = {},
    Util = {},
    MOD_NAME = "SimpleLeaderboard",
}


require "SimpleLeaderboard/Archive"
require "SimpleLeaderboard/Ignore"
require "SimpleLeaderboard/Settings"
require "SimpleLeaderboard/Leaderboard"
require "SimpleLeaderboard/Util"
