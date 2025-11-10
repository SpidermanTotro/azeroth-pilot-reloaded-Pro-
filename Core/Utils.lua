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
