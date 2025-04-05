
print("SimpleLeaderboard - Shared - Util - Loading")

---@class SimpleLeaderboard.Util
---@field secondsToHours fun(seconds: long): number
---@field inKeys fun(obj: table, key: any): boolean
---@field inValues fun(obj: table, value: any): boolean
---@field shallowPrint fun(obj: table): nil
---@field truncateArray fun(arr: table, maxSize: number): nil
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


---@public
---@param arr table
---@param maxSize number
---@return nil
function Util.truncateArray(arr, maxSize)
    if not maxSize or maxSize <= 0 then return end
    while #arr > maxSize do
        table.remove(arr)
    end
end

return Util
