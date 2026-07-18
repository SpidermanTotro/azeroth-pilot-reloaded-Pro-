-- Minimal World of Warcraft API shim for testing addon startup outside the game.

local scheduledCallbacks = {}
local settingsCalls = {
    canvas = 0,
    addon = 0,
    opened = nil,
}

unpack = unpack or table.unpack

local function newUiObject()
    local object = {
        scripts = {},
        events = {},
    }

    return setmetatable(object, {
        __index = function(self, key)
            if key == "Text" then
                local textObject = newUiObject()
                rawset(self, key, textObject)
                return textObject
            elseif key == "CreateTexture"
                or key == "CreateFontString"
                or key == "CreateAnimationGroup"
                or key == "CreateAnimation" then
                return function()
                    return newUiObject()
                end
            elseif key == "SetScript" then
                return function(target, event, callback)
                    target.scripts[event] = callback
                end
            elseif key == "GetScript" then
                return function(target, event)
                    return target.scripts[event]
                end
            elseif key == "RegisterEvent" then
                return function(target, event)
                    target.events[event] = true
                end
            elseif key == "GetCanvas" then
                return function(target)
                    if not target.canvas then
                        target.canvas = newUiObject()
                    end
                    return target.canvas
                end
            elseif key == "GetXY" then
                return function()
                    return 0.5, 0.5
                end
            elseif key == "GetWidth" or key == "GetHeight" then
                return function()
                    return 1000
                end
            elseif key == "GetScale" then
                return function()
                    return 1
                end
            elseif key == "GetChecked" or key == "IsShown" then
                return function()
                    return false
                end
            end

            return function()
                return nil
            end
        end,
    })
end

UIParent = newUiObject()
WorldMapFrame = newUiObject()
Minimap = newUiObject()
GameTooltip = newUiObject()
SlashCmdList = {}
SOUNDKIT = { ALARM_CLOCK_WARNING_3 = 1 }

function CreateFrame(_, name)
    local frame = newUiObject()
    if name then
        _G[name] = frame
    end
    return frame
end

Settings = {
    RegisterCanvasLayoutCategory = function(panel, name)
        assert(panel, "settings panel is required")
        assert(name == "Azeroth Pilot Pro", "unexpected settings category name")
        settingsCalls.canvas = settingsCalls.canvas + 1
        return { id = 1 }
    end,
    RegisterAddOnCategory = function(category)
        assert(category and category.id == 1, "settings category was not returned")
        settingsCalls.addon = settingsCalls.addon + 1
    end,
    OpenToCategory = function(name)
        settingsCalls.opened = name
    end,
}

C_Timer = {
    After = function(_, callback)
        table.insert(scheduledCallbacks, callback)
    end,
    NewTicker = function(_, callback)
        table.insert(scheduledCallbacks, callback)
        return newUiObject()
    end,
}

C_Map = {
    GetBestMapForUnit = function()
        return 1
    end,
    GetPlayerMapPosition = function()
        return newUiObject()
    end,
    GetMapInfo = function()
        return { name = "Smoke Test Zone" }
    end,
}

C_QuestLog = {
    AddQuestWatch = function() end,
    GetAllCompletedQuestIDs = function() return {} end,
    GetInfo = function() return nil end,
    GetLogIndexForQuestID = function() return nil end,
    GetNextWaypointForMap = function() return nil, nil end,
    GetNumQuestLogEntries = function() return 0 end,
    GetQuestObjectives = function() return {} end,
    GetTitleForQuestID = function() return nil end,
    IsComplete = function() return false end,
    RemoveQuestWatch = function() end,
}

function GetBuildInfo()
    return "12.0.7", "12345", "Jul 1 2026", 120007
end

function GetRealmName() return "Smoke Test Realm" end
function GetTime() return 100 end
function GetZoneText() return "Smoke Test Zone" end
function GetSubZoneText() return "Smoke Test Subzone" end
function GetPlayerFacing() return 0 end
function GetBindLocation() return "Smoke Test Inn" end
function GetItemCooldown() return 0, 0, 1 end
function GetQuestID() return 0 end
function GetQuestLogRewardXP() return 0 end
function GetQuestLogRewardInfo() return nil end
function GetQuestLogItemLink() return nil end
function GetNumQuestLogRewards() return 0 end
function GetSpecialization() return 1 end
function GetSpecializationInfo() return 71, "Smoke", nil, nil, "DAMAGER" end
function GetInventoryItemLink() return nil end
function GetItemInfo() return nil end
function GetItemStats() return {} end
function UnitXP() return 100 end
function UnitXPMax() return 1000 end
function UnitLevel() return 10 end
function UnitExists() return false end
function UnitGUID() return "Player-1-00000001" end
function UnitName() return "Smoke Tester" end
function UnitClass() return "Warrior", "WARRIOR" end
function UnitFactionGroup() return "Alliance" end
function IsInGroup() return false end
function PlaySound() end
function FlashClientIcon() end
function CombatLogGetCurrentEventInfo() return nil end
function UIFrameFadeIn() end
function UIFrameFadeOut() end
function time() return 100 end
function date() return "2026-07-19" end
function strsplit(separator, value)
    local fields = {}
    local pattern = string.format("([^%s]+)", separator)
    for field in string.gmatch(value, pattern) do
        table.insert(fields, field)
    end
    return unpack(fields)
end

local loadedFiles = 0
for _, path in ipairs(arg) do
    local chunk, loadError = loadfile(path)
    assert(chunk, string.format("could not load %s: %s", path, loadError or "unknown error"))

    local ok, runtimeError = pcall(chunk)
    assert(ok, string.format("error while loading %s: %s", path, runtimeError))
    loadedFiles = loadedFiles + 1
end

assert(loadedFiles > 0, "pass the TOC's Lua files to the smoke test")
assert(AzerothPilot == QuestMasterPro, "addon compatibility namespaces diverged")
assert(AzerothPilot.EventFrame, "core event frame was not created")

local onEvent = AzerothPilot.EventFrame:GetScript("OnEvent")
assert(onEvent, "core event handler was not installed")

onEvent(AzerothPilot.EventFrame, "ADDON_LOADED", "QuestMasterPro")
onEvent(AzerothPilot.EventFrame, "PLAYER_LOGIN")

assert(AzerothPilot.Initialized, "addon initialization did not complete")
assert(settingsCalls.canvas == 1, "retail settings category was not registered")
assert(settingsCalls.addon == 1, "retail addon settings entry was not registered")

AzerothPilot:OpenSettings()
assert(settingsCalls.opened == "Azeroth Pilot Pro", "settings category could not be opened")

print(string.format("startup smoke test passed (%d Lua files)", loadedFiles))
