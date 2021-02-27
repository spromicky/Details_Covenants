local _, dc = ...

dc.oribos = {}

local oribos = dc.oribos
oribos.emptyCovenants = {}

local covenantID = C_Covenants.GetActiveCovenantID()
local playerName = UnitName("player")
oribos.covenants = { [playerName] = covenantID }

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
    print("|CFFFFFF00Numbers:|r "..numGroupMembers)
    for groupindex = 1, numGroupMembers do
        local name = GetRaidRosterInfo(groupindex)

        if name then
            local covenantID = oribos.covenants[name]
            if not covenantID then
                print("|CFFFF0000Not exists:|r "..name)
                oribos.emptyCovenants[name] = 0
            end
        end
    end
end

function oribos:addCovenantForPlayer(covenantID, playerName)
    if covenantID then 
        oribos.covenants[playerName] = covenantID
        oribos.emptyCovenants[playerName] = nil
        print("|CFF00FF00Add new character covenant:|r "..playerName.." "..covenantID)
    end
end


-- Public 
_G.Oribos = {}
local publicOribos = _G.Oribos

function publicOribos:getCovenantIconForPlayer(playerName)
    local covenantID = oribos.covenants[playerName]

    if covenantID then
        return oribos:getCovenantIcon(covenantID)
    else
        return ""
    end 
end