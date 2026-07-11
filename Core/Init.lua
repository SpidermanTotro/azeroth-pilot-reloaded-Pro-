-- Azeroth Pilot Reloaded Pro - Core Initialization
-- Version: 1.0.0

-- Create global addon namespace
AzerothPilot = AzerothPilot or {}
AzerothPilot.Version = "1.1.0"
AzerothPilot.BuildDate = "2026-07-11"

-- Backwards/forwards compatibility: some modules reference QuestMasterPro while core uses AzerothPilot.
-- Ensure a shared table exists so both sets of modules work regardless of folder name.
if not QuestMasterPro then
    QuestMasterPro = AzerothPilot
end

-- Enhanced UI modules use the shorter QMP namespace.
-- Keep it pointed at the same shared addon table to avoid nil-global failures.
QMP = QMP or QuestMasterPro

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
    if self.Initialized then
        return
    end

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

    -- Keep compatibility SavedVariables synchronized after WoW has loaded them.
    QuestMasterProDB = AzerothPilotDB
    QuestMasterProCharDB = AzerothPilotCharDB
    self.Initialized = true

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
        -- Support both release folder names. PLAYER_LOGIN below remains the
        -- reliable fallback for GitHub ZIPs or other renamed addon folders.
        if addonName == "AzerothPilotReloadedPro" or addonName == "QuestMasterPro" then
            AzerothPilot:Initialize()
        end
    elseif event == "PLAYER_LOGIN" then
        -- A renamed addon folder changes the ADDON_LOADED name. Ensure saved
        -- variables and defaults exist before any login-time module uses them.
        AzerothPilot:Initialize()
        AzerothPilot:OnPlayerLogin()
    end
end)

-- OnPlayerLogin is implemented in Main.lua (single authoritative implementation)
