-- UI/MainFrame.lua - Minimal main frame for QuestMaster Pro scaffold

QuestMasterPro.UI = QuestMasterPro.UI or {}
QuestMasterPro.UI.MainFrame = QuestMasterPro.UI.MainFrame or {}
local MainFrame = QuestMasterPro.UI.MainFrame

function MainFrame:Init()
    if self.frame then return end
    local f = CreateFrame("Frame", "QuestMasterPro_MainFrame", UIParent)
    f:SetSize(400, 300)
    f:SetPoint("CENTER")
    f:Hide()

    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    f.title:SetPoint("TOP", 0, -10)
    f.title:SetText("QuestMaster Pro")

    self.frame = f
end

function MainFrame:Toggle()
    if not self.frame then self:Init() end
    if self.frame:IsShown() then self.frame:Hide() else self.frame:Show() end
end

return MainFrame
-- Azeroth Pilot Reloaded Pro - Main Frame UI Logic
-- Modern UI that surpasses AAP and competitors

AzerothPilot.UI.MainFrame = {}
local MainFrame = AzerothPilot.UI.MainFrame

-- OnLoad handler
function MainFrame:OnLoad()
    -- Set up the frame
    AzerothPilotMainFrame:SetMovable(true)
    AzerothPilotMainFrame:EnableMouse(true)
    AzerothPilotMainFrame:RegisterForDrag("LeftButton")

    -- Set title
    AzerothPilotMainFrameTitle:SetText("Azeroth Pilot Pro")

    -- Set button texts
    AzerothPilotMainFrameNextButton:SetText("Next >>")
    AzerothPilotMainFramePrevButton:SetText("<< Prev")

    -- Initial update
    self:UpdateStep(nil)

    AzerothPilot:DebugPrint("Main frame loaded")
end

-- Update step display
function MainFrame:UpdateStep(step)
    if not step then
        AzerothPilotMainFrameStepText:SetText("No active guide\n\nUse /ap start to begin a leveling guide!")
        AzerothPilotMainFrameCoordText:SetText("")
        return
    end

    -- Build step text
    local text = ""

    -- Add step number
    if AzerothPilot.Guides.Engine.activeGuide then
        local current = AzerothPilot.Guides.Engine.currentStepIndex
        local total = #AzerothPilot.Guides.Engine.activeGuide.steps
        text = text .. "|cFFFFD700Step " .. current .. " of " .. total .. "|r\n\n"
    end

    -- Add step title
    if step.title then
        text = text .. "|cFF00FF00" .. step.title .. "|r\n\n"
    end

    -- Add description
    if step.description then
        text = text .. step.description .. "\n\n"
    end

    -- Add quest info
    if step.questID then
        local questName = C_QuestLog.GetTitleForQuestID(step.questID)
        if questName then
            text = text .. "|cFFFFFF00Quest:|r " .. questName .. "\n"
        end
    end

    -- Add objective type
    if step.action == "accept" then
        text = text .. "|cFF88FF88Action:|r Accept quest\n"
    elseif step.action == "turnin" then
        text = text .. "|cFF88FF88Action:|r Turn in quest\n"
    elseif step.action == "goto" then
        text = text .. "|cFF88FF88Action:|r Go to location\n"
    elseif step.action == "grind" then
        text = text .. "|cFF88FF88Action:|r Grind to level " .. (step.level or "?") .. "\n"
    end

    AzerothPilotMainFrameStepText:SetText(text)

    -- Update coordinates
    if step.waypoint then
        local coords = AzerothPilot.Utils:FormatCoords(step.waypoint.x, step.waypoint.y)
        local zone = step.zone or "Unknown Zone"
        AzerothPilotMainFrameCoordText:SetText(zone .. " - " .. coords)
    else
        AzerothPilotMainFrameCoordText:SetText("")
    end
end

-- Next button click handler
function MainFrame:OnNextButtonClick()
    if AzerothPilot.Guides.Engine.activeGuide then
        AzerothPilot.Guides.Engine:NextStep()
    else
        AzerothPilot:Print("No active guide. Use /ap start")
    end
end

-- Previous button click handler
function MainFrame:OnPrevButtonClick()
    if AzerothPilot.Guides.Engine.activeGuide then
        AzerothPilot.Guides.Engine:PreviousStep()
    else
        AzerothPilot:Print("No active guide. Use /ap start")
    end
end

-- Show the frame
function MainFrame:Show()
    AzerothPilotMainFrame:Show()
end

-- Hide the frame
function MainFrame:Hide()
    AzerothPilotMainFrame:Hide()
end

-- Toggle visibility
function MainFrame:Toggle()
    if AzerothPilotMainFrame:IsShown() then
        self:Hide()
    else
        self:Show()
    end
end
