-- Core/Utils.lua - Small utility helpers used by the scaffold

QuestMasterPro.Core = QuestMasterPro.Core or {}
local Core = QuestMasterPro.Core

Core.Utils = Core.Utils or {}
local Utils = Core.Utils

function Utils.HexColor(color)
    if not color then return "FFFFFF" end
    return string.format("%02X%02X%02X", math.floor((color.r or 1) * 255), math.floor((color.g or 1) * 255), math.floor((color.b or 1) * 255))
end

function Utils.DebugPrint(...)
    if QuestMasterProDB and QuestMasterProDB.debug then
        print("|cFF00D4FF[QuestMaster Pro]|r", ...)
    end
end

return Utils
-- Azeroth Pilot Reloaded Pro - Utility Functions
-- Common utility functions used throughout the addon

AzerothPilot.Utils = {}
local Utils = AzerothPilot.Utils

-- Calculate distance between two points
function Utils:GetDistance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

-- Get player position
function Utils:GetPlayerPosition()
    local mapID = C_Map.GetBestMapForUnit("player")
    if not mapID then
        return nil, nil, nil
    end

    local position = C_Map.GetPlayerMapPosition(mapID, "player")
    if not position then
        return nil, nil, nil
    end

    return position:GetXY(), mapID
end

-- Format coordinates
function Utils:FormatCoords(x, y)
    if not x or not y then
        return "Unknown"
    end
    return string.format("%.1f, %.1f", x * 100, y * 100)
end

-- Get distance to waypoint
function Utils:GetDistanceToWaypoint(waypointX, waypointY)
    local playerX, playerY = self:GetPlayerPosition()
    if not playerX or not waypointX then
        return nil
    end

    return self:GetDistance(playerX, playerY, waypointX, waypointY)
end

-- Check if player is in range of waypoint
function Utils:IsInRange(waypointX, waypointY, range)
    local distance = self:GetDistanceToWaypoint(waypointX, waypointY)
    if not distance then
        return false
    end

    return distance <= (range or 0.02) -- Default ~20 yards in map coordinates
end

-- Get quest info
function Utils:GetQuestInfo(questID)
    if not questID then
        return nil
    end

    local questInfo = C_QuestLog.GetInfo(C_QuestLog.GetLogIndexForQuestID(questID))
    return questInfo
end

-- Check if quest is complete
function Utils:IsQuestComplete(questID)
    if not questID then
        return false
    end

    return C_QuestLog.IsComplete(questID)
end

-- Check if quest is in log
function Utils:IsQuestInLog(questID)
    if not questID then
        return false
    end

    return C_QuestLog.GetLogIndexForQuestID(questID) ~= nil
end

-- Color code text
function Utils:ColorText(text, color)
    if not color then
        color = "FFFFFF"
    end
    return "|cFF" .. color .. text .. "|r"
end

-- Get zone name
function Utils:GetZoneName()
    return GetZoneText() or "Unknown"
end

-- Get subzone name
function Utils:GetSubZoneName()
    return GetSubZoneText() or ""
end
