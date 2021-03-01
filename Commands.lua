local _, dc = ...

SLASH_DETAILSCOVENANT1, SLASH_DETAILSCOVENANT2 = '/dc', '/dcovenants';
local function commandLineHandler(msg, editBox)
    if dc.utils:isNumeric(msg) then
        local numberValue = tonumber(msg)
        if numberValue > 10 and numberValue < 48 then 
            DCovenant["iconSize"] = math.floor(numberValue / 2) * 2
            print("Details! Covenant icon size has been set to "..DCovenant["iconSize"])
        else
            print("Please enter value between 10 and 48") 
        end 
    elseif msg == "log" then
        dc.oribos:log()
    else 
        print("Details! Covenant icon size: "..DCovenant["iconSize"])
    end
end
SlashCmdList["DETAILSCOVENANT"] = commandLineHandler;