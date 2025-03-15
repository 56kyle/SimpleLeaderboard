
if not isClient() then return end
if not SimpleLeaderboard then return end
if not SimpleLeaderboard.Client then return end

require "SimpleLeaderboard/Menu"
require "SimpleLeaderboard/Panel"
require "SimpleLeaderboard/Tab"
require "SimpleLeaderboard/Table"


local ClientUI = SimpleLeaderboard.Client.UI

---@public
---@return nil
function ClientUI.setup()
    return
end
