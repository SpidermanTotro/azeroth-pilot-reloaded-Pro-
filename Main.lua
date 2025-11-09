-- Azeroth Pilot Reloaded Pro - Main Entry Point
-- The superior alternative to AAP, Zygor, RestedXP, and Dugi Guides!

-- Slash command handlers
SLASH_AZEROTHPILOT1 = "/ap"
SLASH_AZEROTHPILOT2 = "/azerothpilot"
SLASH_AZEROTHPILOT3 = "/app"

function SlashCmdList.AZEROTHPILOT(msg)
    local command, arg = msg:match("^(%S*)%s*(.-)$")
    command = command:lower()
    
    if command == "" or command == "help" then
        AzerothPilot:ShowHelp()
    elseif command == "start" then
        AzerothPilot:StartGuideCommand(arg)
    elseif command == "stop" then
        AzerothPilot.Guides.Engine:StopGuide()
    elseif command == "next" then
        AzerothPilot.Guides.Engine:NextStep()
    elseif command == "prev" or command == "previous" then
        AzerothPilot.Guides.Engine:PreviousStep()
    elseif command == "show" then
        AzerothPilot.UI.MainFrame:Show()
    elseif command == "hide" then
        AzerothPilot.UI.MainFrame:Hide()
    elseif command == "toggle" then
        AzerothPilot.UI.MainFrame:Toggle()
    elseif command == "config" or command == "settings" then
        AzerothPilot:OpenSettings()
    elseif command == "guides" or command == "list" then
        AzerothPilot:ListGuides()
    elseif command == "reset" then
        AzerothPilot:ResetProgress()
    elseif command == "debug" then
        AzerothPilot.Debug = not AzerothPilot.Debug
        AzerothPilot:Print("Debug mode: " .. (AzerothPilot.Debug and "ON" or "OFF"))
    elseif command == "version" or command == "v" then
        AzerothPilot:ShowVersion()
    else
        AzerothPilot:Print("Unknown command: " .. command)
        AzerothPilot:ShowHelp()
    end
end

-- Show help text
function AzerothPilot:ShowHelp()
    self:Print("=== Azeroth Pilot Reloaded Pro Commands ===")
    print("|cFFFFFF00/ap help|r - Show this help")
    print("|cFFFFFF00/ap start [guide]|r - Start a leveling guide")
    print("|cFFFFFF00/ap stop|r - Stop current guide")
    print("|cFFFFFF00/ap next|r - Go to next step")
    print("|cFFFFFF00/ap prev|r - Go to previous step")
    print("|cFFFFFF00/ap show|r - Show guide window")
    print("|cFFFFFF00/ap hide|r - Hide guide window")
    print("|cFFFFFF00/ap toggle|r - Toggle guide window")
    print("|cFFFFFF00/ap guides|r - List available guides")
    print("|cFFFFFF00/ap config|r - Open settings")
    print("|cFFFFFF00/ap reset|r - Reset progress")
    print("|cFFFFFF00/ap version|r - Show addon version")
end

-- Start guide command
function AzerothPilot:StartGuideCommand(guideId)
    if guideId == "" or not guideId then
        -- Auto-detect appropriate guide
        local level = UnitLevel("player")
        local faction = UnitFactionGroup("player")
        
        if level <= 10 then
            if faction == "Alliance" then
                guideId = "elwynn_1_10"
            else
                guideId = "durotar_1_10"
            end
        elseif level >= 80 and level <= 85 then
            guideId = "jade_forest_80_85"
        else
            self:Print("No guide auto-detected for your level. Use /ap guides to see all guides.")
            return
        end
        
        self:Print("Auto-detected guide: " .. guideId)
    end
    
    AzerothPilot.Guides.Engine:StartGuide(guideId)
    AzerothPilot.UI.MainFrame:Show()
end

-- List available guides
function AzerothPilot:ListGuides()
    self:Print("=== Available Guides ===")
    local guides = AzerothPilot.Database:GetAllGuides()
    
    if #guides == 0 then
        print("No guides loaded!")
        return
    end
    
    for _, guide in ipairs(guides) do
        local color = guide.faction == "Alliance" and "0080FF" or (guide.faction == "Horde" and "FF0000" or "FFFF00")
        print(string.format("|cFF%s[%d-%d]|r %s |cFFAAAAAA(%s)|r", 
            color, guide.minLevel, guide.maxLevel, guide.name, guide.id))
        if guide.expansion then
            print("  |cFF00FF00" .. guide.expansion .. " Content - FRESH 2025!|r")
        end
    end
    
    print(" ")
    print("Use |cFFFFFF00/ap start [guide-id]|r to start a guide")
end

-- Open settings
function AzerothPilot:OpenSettings()
    -- Open interface options to our panel
    if Settings and Settings.OpenToCategory then
        Settings.OpenToCategory("Azeroth Pilot Pro")
    elseif InterfaceOptionsFrame_OpenToCategory then
        InterfaceOptionsFrame_OpenToCategory("Azeroth Pilot Pro")
    end
end

-- Reset progress
function AzerothPilot:ResetProgress()
    AzerothPilotCharDB.currentGuide = nil
    AzerothPilotCharDB.currentStep = 1
    AzerothPilotCharDB.completedSteps = {}
    
    if AzerothPilot.Guides.Engine.activeGuide then
        AzerothPilot.Guides.Engine:StopGuide()
    end
    
    self:Print("Progress reset!")
end

-- Show version
function AzerothPilot:ShowVersion()
    self:Print("=== Azeroth Pilot Reloaded Pro ===")
    self:Print("Version: " .. self.Version)
    self:Print("Build Date: " .. self.BuildDate)
    self:Print(" ")
    self:Print("|cFF00FF00The SUPERIOR alternative to:|r")
    self:Print("  - Azeroth Auto Pilot (deprecated)")
    self:Print("  - Zygor Guides (slow updates)")
    self:Print("  - RestedXP (limited features)")
    self:Print("  - Dugi Guides (paid only)")
    self:Print(" ")
    self:Print("|cFFFFFF00Fresh updates for 2025!|r")
    self:Print("Including Pandaria Classic guides!")
end

-- Initialize all systems when player logs in
function AzerothPilot:OnPlayerLogin()
    -- Initialize all modules
    AzerothPilot.Data.Routes:Initialize()
    AzerothPilot.Guides.Engine:Initialize()
    AzerothPilot.Guides.QuestTracker:Initialize()
    AzerothPilot.Guides.Waypoints:Initialize()
    AzerothPilot.UI.Arrow:Initialize()
    AzerothPilot.UI.Settings:Initialize()
    
    -- Show welcome message
    self:Print("Welcome! Type |cFFFFFF00/ap|r for commands")
    self:Print("|cFF00FF00The superior leveling addon - updated for 2025!|r")
    
    -- Resume guide if active
    if AzerothPilotCharDB.currentGuide then
        local guide = AzerothPilot.Database:GetGuide(AzerothPilotCharDB.currentGuide)
        if guide then
            AzerothPilot.Guides.Engine.activeGuide = guide
            AzerothPilot.Guides.Engine.currentStepIndex = AzerothPilotCharDB.currentStep or 1
            AzerothPilot.Guides.Engine:UpdateCurrentStep()
            self:Print("Resumed guide: " .. guide.name)
        end
    end
end
