--- SimpleLeaderboard Server
-- @module SimpleLeaderboardServer

local SimpleLeaderboardShared = require("SimpleLeaderboard/SimpleLeaderboardShared")
local SimpleLeaderboardSandboxVars = require("SimpleLeaderboard/SimpleLeaderboardSandboxVars")
local SimpleLeaderboardIgnore = require("SimpleLeaderboard/SimpleLeaderboardIgnore")
local Util = require("SimpleLeaderboard/Util")

local SimpleLeaderboardServer = {}

local boardDirty = {}
local lastUpdateTime = {}

---@public
---@param playerNum int
---@param player IsoPlayer
local function recordPlayer(playerNum, player)
    if not player then return end
    local data = SimpleLeaderboardShared.getOrCreateModData()
    local statsTable = data.PersistentStats

    local steamID = player:getSteamID()
    if not steamID or steamID == "" then
        steamID = "NonSteam_" .. (player:getUsername() or ("p_" .. player:getPlayerNum()))
    end

    if not statsTable[steamID] then
        statsTable[steamID] = {
            steamID = steamID,
            username = player:getUsername() or "Unknown",
            factionName = nil
        }
    else
        statsTable[steamID].username = player:getUsername() or statsTable[steamID].username
    end
end
Events.OnCreatePlayer.Add(recordPlayer)

local function buildFactionScoreboard(playerData, persistentStats)
    local factionMap = {}
    for _, row in ipairs(playerData) do
        local sid = row.steamID
        if sid and not SimpleLeaderboardIgnore.isIgnored(sid) then
            local stats = persistentStats[sid]
            if stats then
                local fName = stats.factionName or "NoFaction"
                factionMap[fName] = (factionMap[fName] or 0) + (row.score or 0)
            end
        end
    end

    local factionArr = {}
    for name, total in pairs(factionMap) do
        table.insert(factionArr, { factionName = name, score = total })
    end
    table.sort(factionArr, function(a, b)
        return (a.score or 0) > (b.score or 0)
    end)
    return factionArr
end

local function updateBoard(leaderboardName)
    local data = SimpleLeaderboardShared.getOrCreateModData()
    local boards = SimpleLeaderboardShared.getRegisteredLeaderboards()
    local sbVars = SandboxVars.SimpleLeaderboard
    local info = boards[leaderboardName]
    if not info then return end

    local raw = info.updateFunc(data.PersistentStats) or {}
    local filtered = {}
    for _, entry in ipairs(raw) do
        local sid = entry.steamID
        if sid and not SimpleLeaderboardIgnore.isIgnored(sid) then
            table.insert(filtered, entry)
        end
    end

    table.sort(filtered, function(a, b)
        return (a.score or 0) > (b.score or 0)
    end)

    local maxSize = info.maxSize or sbVars.default_leaderboard_size
    Util.truncateArray(filtered, maxSize)
    data.leaderboards[leaderboardName] = filtered

    if info.enableFaction then
        local factionData = buildFactionScoreboard(filtered, data.PersistentStats)
        Util.truncateArray(factionData, maxSize)
        data.leaderboards[leaderboardName .. "_Faction"] = factionData
    end

    boardDirty[leaderboardName] = false
    lastUpdateTime[leaderboardName] = getGameTime():getWorldAgeHours()
    print("SimpleLeaderboard: Updated board " .. leaderboardName)
end

function SimpleLeaderboardServer.scheduleBoardUpdate(leaderboardName)
    boardDirty[leaderboardName] = true
    print("SimpleLeaderboard: Marked " .. leaderboardName .. " as dirty")
end

local function updateAllLeaderboardsIfNeeded()
    local sbVars = SandboxVars.SimpleLeaderboard
    local interval = sbVars.update_interval
    local boards = SimpleLeaderboardShared.getRegisteredLeaderboards()
    local nowHours = getGameTime():getWorldAgeHours()

    for lbName, info in pairs(boards) do
        local lastTime = lastUpdateTime[lbName] or -999
        local timeReady = (math.floor(nowHours * (60 / interval)) > math.floor(lastTime * (60 / interval)))

        if info.timedUpdate and timeReady then
            boardDirty[lbName] = true
        end

        if boardDirty[lbName] and timeReady then
            updateBoard(lbName)
        end
    end
end

local function onClientCommand(module, command, player, args)
    if module ~= "SimpleLeaderboard" then
        return
    end

    if command == "RequestLeaderboard" then
        local lbName = args.leaderboard_name
        local scoreboard = SimpleLeaderboardShared.getLeaderboardData(lbName) or {}
        local boards = SimpleLeaderboardShared.getRegisteredLeaderboards()
        local info = boards[lbName]
        local displayFunc = info and info.displayFunc
        local sb = SandboxVars.SimpleLeaderboard
        local limit = sb.send_entries_limit
        local finalData = {}

        for i = 1, math.min(limit, #scoreboard) do
            local copy = {}
            for k, v in pairs(scoreboard[i]) do
                copy[k] = v
            end
            if copy.score and displayFunc then
                copy.displayScore = displayFunc(copy.score)
            else
                copy.displayScore = tostring(copy.score or 0)
            end
            table.insert(finalData, copy)
        end

        sendServerCommand(player, "SimpleLeaderboard", "SendLeaderboardData", {
            leaderboard_name = lbName,
            leaderboard_data = finalData
        })

    elseif command == "RequestLeaderboardList" then
        local list = SimpleLeaderboardShared.getRegisteredLeaderboardNames()
        sendServerCommand(player, "SimpleLeaderboard", "SendLeaderboardList", { board_names = list })

    elseif command == "DebugCheck" then
        sendServerCommand(player, "SimpleLeaderboard", "DebugResponse", {
            message = "SimpleLeaderboard is running."
        })
    end
end
Events.OnClientCommand.Add(onClientCommand)

local function onServerStart()
    SimpleLeaderboardSandboxVars.init()
    SimpleLeaderboardShared.getOrCreateModData()

    local boards = SimpleLeaderboardShared.getRegisteredLeaderboards()
    for name, _info in pairs(boards) do
        boardDirty[name] = false
        lastUpdateTime[name] = -999
    end

    updateAllLeaderboardsIfNeeded()

    Events.EveryTenMinutes.Add(function()
        updateAllLeaderboardsIfNeeded()
    end)
end
Events.OnPostMapLoad.Add(onServerStart)




return SimpleLeaderboardServer
