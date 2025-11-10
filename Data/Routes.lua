-- Azeroth Pilot Reloaded Pro - Leveling Routes
-- Optimized leveling paths that surpass all competitors
-- FRESH UPDATES for 2025 including Pandaria Classic!

AzerothPilot.Data.Routes = {}
local Routes = AzerothPilot.Data.Routes

-- Sample Elwynn Forest Guide (Alliance 1-10)
Routes.ElwynnForest = {
    id = "elwynn_1_10",
    name = "Elwynn Forest 1-10",
    description = "Optimized leveling path for Alliance characters in Elwynn Forest",
    faction = "Alliance",
    minLevel = 1,
    maxLevel = 10,
    zone = 1429,
    author = "Azeroth Pilot Pro Team",
    version = "1.0.0",
    lastUpdated = "2025-11-09",

    steps = {
        {
            title = "Accept Starting Quests",
            description = "Accept all available quests from Marshal McBride",
            action = "accept",
            questID = 783,
            zone = "Northshire Abbey",
            waypoint = { x = 0.48, y = 0.42 }
        },
        {
            title = "Kill Wolves",
            description = "Kill 8 Young Wolves for quest objective",
            action = "kill",
            objectives = { "Young Wolf x8" },
            zone = "Northshire Valley",
            waypoint = { x = 0.50, y = 0.47 }
        },
        {
            title = "Turn in First Quest",
            description = "Return to Marshal McBride",
            action = "turnin",
            questID = 783,
            zone = "Northshire Abbey",
            waypoint = { x = 0.48, y = 0.42 }
        },
        -- More steps would follow...
    }
}

-- Sample Durotar Guide (Horde 1-10)
Routes.Durotar = {
    id = "durotar_1_10",
    name = "Durotar 1-10",
    description = "Optimized leveling path for Horde characters in Durotar",
    faction = "Horde",
    minLevel = 1,
    maxLevel = 10,
    zone = 1411,
    author = "Azeroth Pilot Pro Team",
    version = "1.0.0",
    lastUpdated = "2025-11-09",

    steps = {
        {
            title = "Your Place In The World",
            description = "Report to Gornek in the Den",
            action = "accept",
            questID = 25132,
            zone = "Valley of Trials",
            waypoint = { x = 0.44, y = 0.68 }
        },
        {
            title = "Cutting Teeth",
            description = "Kill Mottled Boars and Scorpids",
            action = "accept",
            questID = 25133,
            zone = "Valley of Trials",
            waypoint = { x = 0.44, y = 0.69 }
        },
        -- More steps would follow...
    }
}

-- NEW! Pandaria Classic Guide (80-85) - AHEAD OF COMPETITORS!
Routes.JadeForest = {
    id = "jade_forest_80_85",
    name = "The Jade Forest 80-85",
    description = "FRESH 2025! Optimized Pandaria leveling - Updated faster than Zygor, RestedXP, and Dugi!",
    faction = "Neutral",
    minLevel = 80,
    maxLevel = 85,
    zone = 1504,
    author = "Azeroth Pilot Pro Team",
    version = "1.0.0",
    lastUpdated = "2025-11-09",
    expansion = "Pandaria",

    steps = {
        {
            title = "Alliance: The King's Command",
            description = "Accept the mission to Pandaria from SI:7",
            action = "accept",
            questID = 29548,
            zone = "Stormwind City",
            waypoint = { x = 0.82, y = 0.27 },
            faction = "Alliance"
        },
        {
            title = "Horde: The Art of War",
            description = "Accept the mission to Pandaria from Warchief",
            action = "accept",
            questID = 31853,
            zone = "Orgrimmar",
            waypoint = { x = 0.31, y = 0.37 },
            faction = "Horde"
        },
        {
            title = "Arrive in Pandaria",
            description = "Take the ship/zeppelin to the Jade Forest",
            action = "goto",
            zone = "The Jade Forest",
            waypoint = { x = 0.42, y = 0.23 }
        },
        {
            title = "First Contact",
            description = "Meet Admiral Taylor (Alliance) or General Nazgrim (Horde)",
            action = "turnin",
            zone = "Paw'don Village",
            waypoint = { x = 0.43, y = 0.24 }
        },
        {
            title = "Explore Paw'don Village",
            description = "Accept all quests in the village and complete objectives",
            action = "accept",
            zone = "Paw'don Village",
            waypoint = { x = 0.44, y = 0.24 }
        },
        {
            title = "The Hozen Threat",
            description = "Deal with the Hozen attacking the village",
            action = "kill",
            objectives = { "Hozen Attackers x10" },
            zone = "Paw'don Village",
            waypoint = { x = 0.45, y = 0.27 }
        },
        {
            title = "Into the Jade Forest",
            description = "Progress deeper into the forest",
            action = "goto",
            zone = "Jade Forest Interior",
            waypoint = { x = 0.46, y = 0.45 }
        },
        {
            title = "Meet the Pearlfin",
            description = "Discover the friendly Jinyu at Pearlfin Village",
            action = "accept",
            zone = "Pearlfin Village",
            waypoint = { x = 0.58, y = 0.82 }
        },
        -- Continue with more Pandaria steps...
    }
}

-- Register all guides
function Routes:Initialize()
    AzerothPilot.Database:RegisterGuide(self.ElwynnForest)
    AzerothPilot.Database:RegisterGuide(self.Durotar)
    AzerothPilot.Database:RegisterGuide(self.JadeForest)

    AzerothPilot:Print("Loaded " .. self:GetGuideCount() .. " leveling guides")
    AzerothPilot:Print("Including FRESH Pandaria Classic guides - updated for 2025!")
end

-- Get guide count
function Routes:GetGuideCount()
    local count = 0
    for _ in pairs(AzerothPilot.Database.Guides) do
        count = count + 1
    end
    return count
end

-- Get guides for level range
function Routes:GetGuidesForLevel(level, faction)
    local guides = {}
    for _, guide in pairs(AzerothPilot.Database.Guides) do
        if level >= guide.minLevel and level <= guide.maxLevel then
            if guide.faction == "Neutral" or guide.faction == faction then
                table.insert(guides, guide)
            end
        end
    end
    return guides
end

-- Get guide by ID
function Routes:GetGuide(guideId)
    return AzerothPilot.Database:GetGuide(guideId)
end
