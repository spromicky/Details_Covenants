local _, dc = ...

DCovenant = {
    ["iconSize"] = 16,
}

local frame = CreateFrame("FRAME", "DetailsCovenantFrame");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");

local function registerCombatEvent()
    if dc.utils:isEmpty(dc.oribos.emptyCovenants) then 
        frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    else
        frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
        for key, _ in pairs(dc.oribos.emptyCovenants) do
            print("|CFFFF0000Still not exists:|r "..key)
        end
    end
end

local function updateGroupRoster()
    dc.oribos:fillCovenants()
    registerCombatEvent()
end

local function init()
    local isDeteilsLoaded = _G._detalhes ~= nil
    local isSkadaLoaded = _G.Skada ~= nil
    dc.oribos:addCovenantForPlayer(C_Covenants.GetActiveCovenantID(), UnitName("player"))

    if isDeteilsLoaded or isSkadaLoaded then
        frame:RegisterEvent("GROUP_ROSTER_UPDATE");
        updateGroupRoster()
    else
        frame:UnregisterEvent("GROUP_ROSTER_UPDATE");
        frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    end
end

local function eventHandler(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        print("|CFF00FFFFTriggered|r")
        local _, subevent, _, sourceGUID, sourceName = CombatLogGetCurrentEventInfo()

        if not dc.utils:isEmpty(dc.oribos.emptyCovenants) and dc.oribos.emptyCovenants[sourceName] then
            if subevent == "SPELL_CAST_SUCCESS" then
                local _, englishClass = GetPlayerInfoByGUID(sourceGUID)
                local classAbilityMap = dc.spellMaps.abilityMap[englishClass]

                if classAbilityMap then
                    local spellID = select(12, CombatLogGetCurrentEventInfo())
                    local covenantIDByAbility = classAbilityMap[spellID]
                    local covenantIDByUtility = dc.spellMaps.utilityMap[spellID]

                    dc.oribos:addCovenantForPlayer(covenantIDByAbility, sourceName)
                    dc.oribos:addCovenantForPlayer(covenantIDByUtility, sourceName)
                    registerCombatEvent()
                end
            end
        end
    elseif event == "GROUP_ROSTER_UPDATE" then
        updateGroupRoster()
    elseif event == "PLAYER_ENTERING_WORLD" then
        init()
        dc:replaceDetailsImplmentation()
        dc:replaceSkadaImplmentation()
        frame:UnregisterEvent("PLAYER_ENTERING_WORLD");
    end
end

frame:SetScript("OnEvent", eventHandler);