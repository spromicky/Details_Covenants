local _, dc = ...

local coloredName = "|CFFe5a472Details_Covenants|r"
SLASH_DETAILSCOVENANT1, SLASH_DETAILSCOVENANT2 = '/dc', '/dcovenants';
local function commandLineHandler(msg, editBox)
    if string.match(msg, "icon ") then
        print(msg)
        local _, numberValue = dc.utils:splitCommand(msg)
        if dc.utils:isNumeric(numberValue) then 
            local size = tonumber(numberValue)
            if size > 10 and size < 48 then 
                DCovenant["iconSize"] = math.floor(size / 2) * 2
                print(coloredName.." icon size has been set to: |CFF9fd78a"..DCovenant["iconSize"].."|r")
            else
                print("|CFFd77c7aError:|r Please enter value between |CFF9fd78a10|r and |CFF9fd78a48|r") 
            end 
        else
            print("|CFFd77c7aError:|r Please enter value between |CFF9fd78a10|r and |CFF9fd78a48|r") 
        end 
    elseif msg == "chat on" then
        DCovenant["chat"] = true
        print(coloredName.." chat logs is |CFF9fd78aon|r")
    elseif msg == "chat off" then
        DCovenant["chat"] = false
        print(coloredName.." chat logs is |CFFd77c7aoff|r")
    elseif msg == "log" then
        dc.oribos:log()
    else 
        local coloredCommand = "  |CFFc0a7c7/dc|r |CFFf3ce87"
        local currentChatOption = ""

        if DCovenant[chat] == true then
            currentChatOption = "|CFF9fd78aon|r"
        else
            currentChatOption = "|CFFd77c7aoff|r"
        end
        print(coloredName.." usage info:\n"..coloredCommand.."icon [number]:|r change size of icons (currently: |CFF9fd78a"..DCovenant["iconSize"].."|r)\n"..coloredCommand.."chat [on|off]:|r log a new character's covenant to chat (currently: "..currentChatOption..")\n"..coloredCommand.."log:|r print all collected data")
    end
end
SlashCmdList["DETAILSCOVENANT"] = commandLineHandler;