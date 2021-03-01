local _, dc = ...

dc.oribos = {}

local oribos = dc.oribos
local isEmpty = true
oribos.emptyCovenants = {}
oribos.covenants = {}

function oribos:getCovenantIcon(covenantID)
    if covenantID > 0 and covenantID < 5 then
        local covenantMap = {
            [1] = "kyrian",
            [2] = "venthyr",
            [3] = "night_fae",
            [4] = "necrolord",
        }

        return "|T".."Interface\\AddOns\\Details_Covenants\\resources\\"..covenantMap[covenantID]..".tga:"..DCovenant["iconSize"]..":"..DCovenant["iconSize"].."|t"
    end

    return ""
end

function oribos:fillCovenants()
    oribos.emptyCovenants = {}
    local numGroupMembers = GetNumGroupMembers()
    for groupindex = 1, numGroupMembers do
        local name = GetRaidRosterInfo(groupindex)

        if name and not oribos.covenants[name] then
            oribos.emptyCovenants[name] = 0
        end
    end
end

function oribos:addCovenantForPlayer(covenantID, playerName, playerClass)
    if covenantID then 
        if playerName ~= UnitName("player") then
            isEmpty = false

            if DCovenant["chat"] == true and not oribos.covenants[playerName] then 
                local coloredName = "|CFFe5a472Details_Covenants|r"
                local _, _, _, classColor = GetClassColor(playerClass)
                print(coloredName.." covenant defined: "..oribos:getCovenantIcon(covenantID).." |C"..classColor..playerName.."|r")
            end
        end

        local playerData = {}
        playerData.covenantID = covenantID
        playerData.class = playerClass
        oribos.covenants[playerName] = playerData
        oribos.emptyCovenants[playerName] = nil
    end
end

function oribos:sendCovenantInfo(playerName)
    if playerName and oribos.covenants[playerName] then 
        local message = playerName..":"..oribos.covenants[playerName].covenantID..":"..oribos.covenants[playerName].class
        C_ChatInfo.SendAddonMessage(dc.addonPrefix, message, "PARTY")
        C_ChatInfo.SendAddonMessage(dc.addonPrefix, message, "RAID")
    end 
end

function oribos:hasPlayerWithEmptyCovenant()
    return not dc.utils:isEmpty(oribos.emptyCovenants)
end

function oribos:isCovenantsEmpty()
    return isEmpty
end

function oribos:log()
    local log = "|CFFe5a472Details_Covenants|r list of logged characters:"
    for key, data in pairs(oribos.covenants) do
        local _, _, _, classColor = GetClassColor(data.class)
        log = log.."\n    "..oribos:getCovenantIcon(data.covenantID).." |C"..classColor..key.."|r"
    end

    print(log)
end


-- Public 
_G.Oribos = {}
local publicOribos = _G.Oribos

function publicOribos:getCovenantIconForPlayer(playerName)
    local covenantID = oribos.covenants[playerName].covenantID

    if covenantID then
        return oribos:getCovenantIcon(covenantID)
    else
        return ""
    end 
end