-- Core/Init.lua - Minimal initialization for QuestMaster Pro (rewrite)

QuestMasterPro.Core = QuestMasterPro.Core or {}
local Core = QuestMasterPro.Core

function Core:Init()
    -- Basic event frame for the scaffold
    local frame = CreateFrame("Frame", "QMP_CoreFrame")
    frame:RegisterEvent("PLAYER_LOGIN")
    frame:SetScript("OnEvent", function(_, event, ...)
        if event == "PLAYER_LOGIN" then
            QuestMasterProDB = QuestMasterProDB or {}
            QuestMasterProCharDB = QuestMasterProCharDB or {}
            if QuestMasterProDB.debug then
                print("[QuestMaster Pro] Debug enabled")
            end
            if QuestMasterPro.UI and QuestMasterPro.UI.MainFrame and QuestMasterPro.UI.MainFrame.Init then
                QuestMasterPro.UI.MainFrame:Init()
            end
        end
    end)
end

return Core
