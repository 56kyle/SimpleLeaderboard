
print("SimpleLeaderboard - Client - Commands - Top")
if not isClient() then return end
if not SimpleLeaderboard then return end
if not SimpleLeaderboard.Client then return end
print("SimpleLeaderboard - Client - Commands - Loading")

local ClientCommands = SimpleLeaderboard.Client.Commands

local Leaderboard = SimpleLeaderboard.Client.Leaderboard
local mod_name = SimpleLeaderboard.MOD_NAME



function ClientCommands.printLeaderboard(player, args)
    print(Leaderboard.leaders_table)
end


---@public
---@param module string
---@param command string
---@param player IsoPlayer
---@param args table
---@return nil
local function onClientCommand(module, command, player, args)
    if module == mod_name then
        local command_handler = ClientCommands[command]
        if command_handler then
            print("[".. mod_name .."] Running command \""..command.."\" for player \""..player:getUsername().."\".")
            command_handler(player, args)
        else
            print("[".. mod_name .."] Unknown command \""..command.."\" from player \""..player:getUsername().."\"!")
        end
    end
end


Events.OnClientCommand.Add(onClientCommand)

return ClientCommands
