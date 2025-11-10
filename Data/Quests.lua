-- Azeroth Pilot Reloaded Pro - Quest Database
-- Modern quest tracking database - updated faster than competitors!

AzerothPilot.Data.Quests = {}
local Quests = AzerothPilot.Data.Quests

-- Quest database structure
Quests.database = {}

-- Register a quest
function Quests:Register(questData)
    if not questData or not questData.id then
        return false
    end

    self.database[questData.id] = questData
    return true
end

-- Get quest data
function Quests:Get(questID)
    return self.database[questID]
end

-- Sample quest data (can be expanded with full database)
-- This demonstrates our superior data structure

-- Elwynn Forest Quests (Alliance)
Quests:Register({
    id = 783,
    name = "A Swift Message",
    level = 1,
    zone = 1429, -- Elwynn Forest
    faction = "Alliance",
    objectives = { "Deliver message to Stormwind" },
    coordinates = { x = 0.48, y = 0.42 }
})

Quests:Register({
    id = 5261,
    name = "Eagan Peltskinner",
    level = 1,
    zone = 1429,
    faction = "Alliance",
    objectives = { "Speak with Eagan Peltskinner" },
    coordinates = { x = 0.48, y = 0.40 }
})

-- Durotar Quests (Horde)
Quests:Register({
    id = 25132,
    name = "Your Place In The World",
    level = 1,
    zone = 1411, -- Durotar
    faction = "Horde",
    objectives = { "Report to Gornek" },
    coordinates = { x = 0.44, y = 0.68 }
})

Quests:Register({
    id = 25133,
    name = "Cutting Teeth",
    level = 1,
    zone = 1411,
    faction = "Horde",
    objectives = { "Kill Mottled Boars" },
    coordinates = { x = 0.44, y = 0.69 }
})

-- Pandaria Quests (FRESH - 2025!)
Quests:Register({
    id = 29548,
    name = "The King's Command",
    level = 80,
    zone = 1519, -- Stormwind
    faction = "Alliance",
    objectives = { "Report to SI:7 for Pandaria briefing" },
    coordinates = { x = 0.82, y = 0.27 },
    expansion = "Pandaria"
})

Quests:Register({
    id = 29611,
    name = "The Mission",
    level = 80,
    zone = 1504, -- Jade Forest
    faction = "Alliance",
    objectives = { "Speak with Admiral Taylor" },
    coordinates = { x = 0.42, y = 0.23 },
    expansion = "Pandaria"
})

Quests:Register({
    id = 31765,
    name = "A Stranger in a Strange Land",
    level = 85,
    zone = 1504, -- Jade Forest
    faction = "Neutral",
    objectives = { "Explore the Jade Forest" },
    coordinates = { x = 0.46, y = 0.45 },
    expansion = "Pandaria"
})

-- Quest chain tracking
Quests.chains = {
    -- Elwynn Forest starter chain
    ElwynnStarter = { 783, 5261, 33, 34, 35 },

    -- Durotar starter chain
    DurotarStarter = { 25132, 25133, 25134, 25135 },

    -- Pandaria intro chain (Alliance)
    PandariaIntroAlliance = { 29548, 29611, 29612, 29615 },

    -- Pandaria intro chain (Horde)
    PandariaIntroHorde = { 31853, 31854, 31855 }
}

-- Get quest chain
function Quests:GetChain(chainName)
    return self.chains[chainName]
end

-- Check if quest is part of a chain
function Quests:IsPartOfChain(questID)
    for chainName, chain in pairs(self.chains) do
        for _, qID in ipairs(chain) do
            if qID == questID then
                return chainName, chain
            end
        end
    end
    return nil, nil
end

-- Get next quest in chain
function Quests:GetNextInChain(questID)
    local chainName, chain = self:IsPartOfChain(questID)
    if not chain then
        return nil
    end

    for i, qID in ipairs(chain) do
        if qID == questID and i < #chain then
            return chain[i + 1]
        end
    end

    return nil
end

-- Get quest prerequisites
function Quests:GetPrerequisites(questID)
    local questData = self:Get(questID)
    if questData then
        return questData.prerequisites or {}
    end
    return {}
end

-- Check if player meets quest requirements
function Quests:MeetsRequirements(questID)
    local questData = self:Get(questID)
    if not questData then
        return false
    end

    -- Check level
    local playerLevel = UnitLevel("player")
    if questData.level and playerLevel < questData.level then
        return false
    end

    -- Check faction
    if questData.faction then
        local playerFaction = UnitFactionGroup("player")
        if questData.faction ~= "Neutral" and questData.faction ~= playerFaction then
            return false
        end
    end

    return true
end

-- Export quest data for guide creation
function Quests:ExportForGuide(questIDs)
    local exportData = {}
    for _, questID in ipairs(questIDs) do
        local questData = self:Get(questID)
        if questData then
            table.insert(exportData, questData)
        end
    end
    return exportData
end
