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
    local numGroupMembers = GetNumGroupMembers()
    for groupindex = 1, numGroupMembers do
        local name = GetRaidRosterInfo(groupindex)

        if name and not oribos.covenants[name] and not oribos.emptyCovenants[name]then
            oribos.emptyCovenants[name] = 0
            oribos:askCovenantInfo(name)
        end
    end
end

function oribos:addCovenantForPlayer(covenantID, playerName, playerClass)
    if covenantID then 
        if playerName ~= UnitName("player") then
            isEmpty = false

            if DCovenantLog == true and not oribos.covenants[playerName] then 
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

function oribos:askCovenantInfo(playerName)
    local message = dc.askMessage
    C_ChatInfo.SendAddonMessage(dc.addonPrefix, message, "WHISPER", playerName)
end

function oribos:sendCovenantInfo(playerName, toPlayerName)
    if playerName and oribos.covenants[playerName] then 
        local message = playerName..":"..oribos.covenants[playerName].covenantID..":"..oribos.covenants[playerName].class
        C_ChatInfo.SendAddonMessage(dc.addonPrefix, message, "WISPER", toPlayerName)
    end 
end

function oribos:hasPlayerWithEmptyCovenant()
    return not dc.utils:isEmpty(oribos.emptyCovenants)
end

function oribos:isCovenantsEmpty()
    return isEmpty
end

function oribos:log()
    print("|CFFe5a472Details_Covenants|r List of logged characters:")

    for key, data in pairs(oribos.covenants) do
        local _, _, _, classColor = GetClassColor(data.class)
        print(oribos:getCovenantIcon(data.covenantID).." |C"..classColor..key.."|r")
    end
end

function oribos:logParty()
    local numGroupMembers = GetNumGroupMembers()
    if numGroupMembers > 0 then 
        print("|CFFe5a472Details_Covenants|r Party covenants:")

        for groupindex = 1, numGroupMembers do
            local name = GetRaidRosterInfo(groupindex)

            local playerData = oribos.covenants[name]
            if name and playerData then
                local _, _, _, classColor = GetClassColor(playerData.class)
                print(oribos:getCovenantIcon(playerData.covenantID).." |C"..classColor..name.."|r")
            end  
        end
    else 
        print("|CFFe5a472Details_Covenants|r You are not currently in group.")
    end 
end


-- Public 
_G.Oribos = {}
local publicOribos = _G.Oribos

function publicOribos:getCovenantIconForPlayer(playerName)
    local covenantData = oribos.covenants[playerName]

    if covenantData and covenantData.covenantID then
        return oribos:getCovenantIcon(covenantData.covenantID)
    else
        return ""
    end 
end