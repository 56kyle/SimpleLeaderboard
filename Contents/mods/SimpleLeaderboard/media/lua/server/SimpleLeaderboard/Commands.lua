
print("SimpleLeaderboard - Server - Commands - Top")
if not isServer() then return end
if not SimpleLeaderboard then return end
if not SimpleLeaderboard.Server then return end
print("SimpleLeaderboard - Server - Commands - Loading")

SimpleLeaderboard.Server.Commands = SimpleLeaderboard.Commands
local ServerCommands = SimpleLeaderboard.Server.Commands
local mod_name = SimpleLeaderboard.MOD_NAME

---@public
---@param module string
---@param command string
---@param args table
---@return nil
local function onServerCommand(module, command, args)
    if module == mod_name then
        args = args or {}
        local command_handler = ServerCommands[command]
        if command_handler then
            print("[".. mod_name .."] Running command \""..command.."\".")
            command_handler(args)
        else
            print("[".. mod_name .."] Unknown command \""..command.."\"!")
        end
    end
end


Events.OnServerCommand.Add(onServerCommand)

return ServerCommands
