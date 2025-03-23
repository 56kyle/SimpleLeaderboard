
print("SimpleLeaderboard - Shared - Util - Loading")

local Util = {}


---@public
---@param seconds long
---@return number
function Util.secondsToHours(seconds)
    return math.floor(seconds / 3600)
end


---@public
---@param obj table
---@param key any
---@return boolean
function Util.inKeys(obj, key)
    for k, _ in pairs(obj) do
        if k == key then
            return true
        end
    end
    return false
end


---@public
---@param obj table
---@param value any
---@return boolean
function Util.inValues(obj, value)
    for _, v in pairs(obj) do
        if v == value then
            return true
        end
    end
    return false
end


---@public
---@param obj table
---@return nil
function Util.shallowPrint(obj)
    for k, v in pairs(obj) do
        print(k.." - "..v)
    end
end


return Util
