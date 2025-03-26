
print("SimpleLeaderboard - Server - Commands - Top")
if not isServer() then return end
print("SimpleLeaderboard - Server - Commands - Loading")


local Commands = SimpleLeaderboard.Commands
local Leaderboard = SimpleLeaderboard.Leaderboard
local mod_name = SimpleLeaderboard.Constants.MOD_NAME

---@public
---@param player IsoPlayer
---@param args table
---@return nil
function Commands.printLeaderboard(player, args)
    print("Commands.printLeaderboard")
    for k, v in pairs(Leaderboard.player_leaders_table) do
        print("\t"..k.." - "..v)
    end
end


---@public
---@param module string
---@param command string
---@param player IsoPlayer
---@param args table
---@return nil
local function onClientCommand(module, command, player, args)
    print("Commands.onClientCommand")
    print("\tmodule = "..module)
    print("\tcommand = "..command)
    print("\t player = "..player:getSteamID())
    if module == mod_name then
        local command_handler = Commands[command]
        if command_handler then
            print("[".. mod_name .."] Running command \""..command.."\" for player \""..player:getUsername().."\".")
            command_handler(player, args)
        else
            print("[".. mod_name .."] Unknown command \""..command.."\" from player \""..player:getUsername().."\"!")
        end
    end
end


Events.OnClientCommand.Add(onClientCommand)


-----@public
-----@param module string
-----@param command string
-----@param args table
-----@return nil
--local function onServerCommand(module, command, args)
--    print("ServerCommands.onServerCommand")
--    if module == mod_name then
--        args = args or {}
--        local command_handler = ServerCommands[command]
--        if command_handler then
--            print("[".. mod_name .."] Running command \""..command.."\".")
--            command_handler(args)
--        else
--            print("[".. mod_name .."] Unknown command \""..command.."\"!")
--        end
--    end
--end
--
--
--Events.OnServerCommand.Add(onServerCommand)

return Commands
