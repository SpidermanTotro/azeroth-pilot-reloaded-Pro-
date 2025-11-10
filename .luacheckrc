return {
    -- World of Warcraft addons target Lua 5.1 semantics
    std = "lua51",

    -- Allow common WoW API and addon globals used across the codebase
    globals = {
    -- Add addon/core globals
    "AzerothPilot", "QuestMasterPro", "AzerothPilotDB", "AzerothPilotCharDB", "QuestMasterProDB", "QuestMasterProCharDB",

        -- WoW UI / API
        "CreateFrame", "UIParent", "WorldMapFrame", "Minimap", "GameTooltip", "TomTom",
        "C_QuestLog", "C_Timer", "C_Map",
        "UnitXP", "UnitXPMax", "UnitLevel", "UnitExists", "UnitGUID", "UnitName", "UnitClass",
    "UnitFactionGroup",
        "GetTime", "GetZoneText", "GetSubZoneText", "GetPlayerFacing", "GetItemCooldown", "GetBindLocation",
    "GetBuildInfo", "GetRealmName", "GetQuestID", "GetQuestLogRewardXP", "GetQuestLogRewardInfo", "GetQuestLogItemLink",
    "GetItemInfo", "GetNumQuestLogRewards", "GetSpecialization", "GetSpecializationInfo",
    "GetInventoryItemLink", "GetItemStats", "GetNumQuestLogRewards",
    "PlaySound", "SOUNDKIT", "FlashClientIcon", "CombatLogGetCurrentEventInfo", "strsplit",
    "time", "date", "IsInGroup",

    -- UI frame helpers
    "UIFrameFadeIn", "UIFrameFadeOut",

        -- Interface helpers
        "InterfaceOptions_AddCategory", "InterfaceOptionsFrame_OpenToCategory", "Settings",

        -- Slash command globals
        "SlashCmdList", "SLASH_QMPTRAVEL1", "SLASH_QMPTRAVEL2", "SLASH_QMPXP1", "SLASH_QMPXP2",
        "SLASH_QMPSKIP1", "SLASH_QMPSKIP2", "SLASH_QMPNOTIFY1", "SLASH_QMPNOTIFY2",
        "SLASH_AZEROTHPILOT1", "SLASH_AZEROTHPILOT2", "SLASH_AZEROTHPILOT3",
        "SLASH_QUESTMASTER1", "SLASH_QUESTMASTER2", "SLASH_QUESTMASTER3",
    -- Additional SLASH globals used in the codebase
    "SLASH_QMPGEAR1", "SLASH_QMPGEAR2", "SLASH_APRPTR1",

        -- Frame globals used by UI files
        "AzerothPilotMainFrame", "AzerothPilotMainFrameTitle", "AzerothPilotMainFrameNextButton", "AzerothPilotMainFramePrevButton",
    "AzerothPilotMainFrameStepText", "AzerothPilotMainFrameCoordText",
    },

    -- Keep a reasonably permissive max line length since many data files contain long strings
    max_line_length = 140,

    -- Skip linting large data files to focus on code logic warnings
    ignore = {"Data/*.lua"},

    -- Common Lua globals sometimes used in WoW addons
}
