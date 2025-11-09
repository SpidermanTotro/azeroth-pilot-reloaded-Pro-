-- Azeroth Pilot Reloaded Pro - Core Initialization
-- Version: 1.0.0

-- Create global addon namespace
AzerothPilot = AzerothPilot or {}
AzerothPilot.Version = "1.0.0"
AzerothPilot.BuildDate = "2025-11-09"

-- Initialize core modules
AzerothPilot.Core = {}
AzerothPilot.UI = {}
AzerothPilot.Guides = {}
AzerothPilot.Data = {}

-- Debug flag
AzerothPilot.Debug = false

-- Initialization function
function AzerothPilot:Initialize()
    self:Print("Azeroth Pilot Reloaded Pro v" .. self.Version .. " loaded!")
    self:Print("The ultimate leveling guide - ahead of the game for 2025!")
    
    -- Initialize database
    if not AzerothPilotDB then
        AzerothPilotDB = {
            enabled = true,
            autoAccept = false,
            autoTurnIn = false,
            showArrow = true,
            arrowScale = 1.0,
            soundEnabled = true,
        }
    end
    
    if not AzerothPilotCharDB then
        AzerothPilotCharDB = {
            currentGuide = nil,
            currentStep = 1,
            completedSteps = {},
        }
    end
    
    self:DebugPrint("Initialization complete")
end

-- Print function
function AzerothPilot:Print(msg)
    print("|cFF00FF00[Azeroth Pilot Pro]|r " .. tostring(msg))
end

-- Debug print function
function AzerothPilot:DebugPrint(msg)
    if self.Debug then
        print("|cFFFF8800[AP Debug]|r " .. tostring(msg))
    end
end

-- Event handler frame
AzerothPilot.EventFrame = CreateFrame("Frame")
AzerothPilot.EventFrame:RegisterEvent("ADDON_LOADED")
AzerothPilot.EventFrame:RegisterEvent("PLAYER_LOGIN")

AzerothPilot.EventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "AzerothPilotReloadedPro" then
            AzerothPilot:Initialize()
        end
    elseif event == "PLAYER_LOGIN" then
        AzerothPilot:OnPlayerLogin()
    end
end)

function AzerothPilot:OnPlayerLogin()
    self:Print("Welcome! Type /ap or /azerothpilot for commands")
    
    -- Auto-start guide if configured
    if AzerothPilotDB.enabled and AzerothPilotCharDB.currentGuide then
        self:DebugPrint("Resuming guide: " .. tostring(AzerothPilotCharDB.currentGuide))
    end
end
