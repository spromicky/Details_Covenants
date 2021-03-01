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

function utils:split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result[1], result[2]
end