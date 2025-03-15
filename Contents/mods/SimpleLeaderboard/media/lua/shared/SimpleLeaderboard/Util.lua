
if not SimpleLeaderboard then return end

local Util = SimpleLeaderboard.Util


---@public
---@param seconds long
---@return number
function Util.secondsToHours(seconds)
    return math.floor(seconds / 3600)
end

