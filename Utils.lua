local _, dc = ...
dc.utils = {}

local utils = dc.utils

function utils:isEmpty(table)
    for _, _ in pairs(table) do
        return false
    end
    return true
end

function utils:isNumeric(x)
    if tonumber(x) ~= nil then
        return true
    end
    return false
end