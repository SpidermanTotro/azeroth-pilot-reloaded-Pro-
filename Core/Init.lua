-- Core/Init.lua - Minimal initialization for QuestMaster Pro (rewrite)

QuestMasterPro.Core = QuestMasterPro.Core or {}
local Core = QuestMasterPro.Core

function Core:Init()
    -- Basic event frame
    local frame = CreateFrame("Frame", "QMP_CoreFrame")
    frame:RegisterEvent("PLAYER_LOGIN")
    frame:SetScript("OnEvent", function(self, event, ...)
        if event == "PLAYER_LOGIN" then
            -- Restore saved vars
            QuestMasterProDB = QuestMasterProDB or {}
            QuestMasterProCharDB = QuestMasterProCharDB or {}
            if QuestMasterProDB.debug then
                print("[QuestMaster Pro] Debug enabled")
            end
            -- Initialize UI if available
            if QuestMasterPro.UI and QuestMasterPro.UI.MainFrame and QuestMasterPro.UI.MainFrame.Init then
                QuestMasterPro.UI.MainFrame:Init()
            end
        end
    end)
end

return Core
-- Azeroth Pilot Reloaded Pro - Core Initialization
-- Version: 1.0.0

-- Create global addon namespace
AzerothPilot = AzerothPilot or {}
AzerothPilot.Version = "1.0.0"
AzerothPilot.BuildDate = "2025-11-09"

-- Backwards/forwards compatibility: some modules reference QuestMasterPro while core uses AzerothPilot.
-- Ensure a shared table exists so both sets of modules work regardless of folder name.
if not QuestMasterPro then
    QuestMasterPro = AzerothPilot
end

-- SavedVariables aliasing (safe no-op if globals already assigned by TOC)
if not QuestMasterProDB and AzerothPilotDB then QuestMasterProDB = AzerothPilotDB end
if not QuestMasterProCharDB and AzerothPilotCharDB then QuestMasterProCharDB = AzerothPilotCharDB end

-- Initialize core modules
AzerothPilot.Core = {}
AzerothPilot.UI = {}
AzerothPilot.Guides = {}
AzerothPilot.Data = {}

-- Debug flag (will be loaded from saved variables on Initialize).
-- Default to false so debug output is disabled unless the user enables it.
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

    -- Load debug setting from saved variables so the user's preference persists
    if AzerothPilotDB.debug == nil then
        AzerothPilotDB.debug = false
    end
    self.Debug = AzerothPilotDB.debug

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
    print("|cFF00FF00[QuestMaster Pro]|r " .. tostring(msg))
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

AzerothPilot.EventFrame:SetScript("OnEvent", function(_, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        -- support both old and new folder names so users can rename the folder without breaking
        if addonName == "AzerothPilotReloadedPro" or addonName == "QuestMasterPro" then
            AzerothPilot:Initialize()
        end
    elseif event == "PLAYER_LOGIN" then
        AzerothPilot:OnPlayerLogin()
    end
end)

-- OnPlayerLogin is implemented in Main.lua (single authoritative implementation)
