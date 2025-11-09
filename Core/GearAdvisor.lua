-- GearAdvisor.lua - Intelligent gear upgrade system
-- Analyzes and recommends gear upgrades

QuestMasterPro.GearAdvisor = QuestMasterPro.GearAdvisor or {}

local GearAdvisor = QuestMasterPro.GearAdvisor

-- Configuration
GearAdvisor.config = {
    autoCompareRewards = true,
    showUpgradePercent = true,
    highlightBestReward = true,
    considerSecondaryStats = true,
    notifyOnUpgrade = true,
}

-- Stat weights by class/spec (simplified - would be expanded)
GearAdvisor.statWeights = {
    WARRIOR = {
        Arms = {Strength = 1.0, CritStrike = 0.8, Haste = 0.7, Mastery = 0.6, Versatility = 0.5},
        Fury = {Strength = 1.0, Haste = 0.9, CritStrike = 0.8, Mastery = 0.6, Versatility = 0.5},
        Protection = {Stamina = 1.0, Strength = 0.8, Haste = 0.7, Mastery = 0.6, Versatility = 0.6},
    },
    PALADIN = {
        Holy = {Intellect = 1.0, CritStrike = 0.8, Haste = 0.7, Mastery = 0.6, Versatility = 0.5},
        Protection = {Stamina = 1.0, Strength = 0.8, Haste = 0.9, Mastery = 0.7, Versatility = 0.6},
        Retribution = {Strength = 1.0, Haste = 0.9, CritStrike = 0.8, Versatility = 0.6, Mastery = 0.5},
    },
    HUNTER = {
        ["Beast Mastery"] = {Agility = 1.0, Haste = 0.8, CritStrike = 0.7, Mastery = 0.7, Versatility = 0.5},
        Marksmanship = {Agility = 1.0, CritStrike = 0.9, Haste = 0.7, Mastery = 0.6, Versatility = 0.5},
        Survival = {Agility = 1.0, Haste = 0.8, CritStrike = 0.8, Versatility = 0.6, Mastery = 0.6},
    },
    -- Would continue for all classes/specs
}

-- Get player's current spec
function GearAdvisor:GetPlayerSpecialization()
    local specIndex = GetSpecialization()
    if not specIndex then return nil end
    
    local specID, specName = GetSpecializationInfo(specIndex)
    return specName
end

-- Get stat weights for current spec
function GearAdvisor:GetStatWeights()
    local _, class = UnitClass("player")
    local spec = self:GetPlayerSpecialization()
    
    if not class or not spec then
        -- Default weights
        return {Strength = 1, Agility = 1, Intellect = 1, Stamina = 0.8}
    end
    
    if self.statWeights[class] and self.statWeights[class][spec] then
        return self.statWeights[class][spec]
    end
    
    -- Fallback
    return {Strength = 1, Agility = 1, Intellect = 1, Stamina = 0.8}
end

-- Calculate item score based on stats
function GearAdvisor:CalculateItemScore(itemLink)
    if not itemLink then return 0 end
    
    local stats = GetItemStats(itemLink)
    if not stats then return 0 end
    
    local weights = self:GetStatWeights()
    local score = 0
    
    -- Primary stats
    score = score + (stats["ITEM_MOD_STRENGTH_SHORT"] or 0) * (weights.Strength or 0)
    score = score + (stats["ITEM_MOD_AGILITY_SHORT"] or 0) * (weights.Agility or 0)
    score = score + (stats["ITEM_MOD_INTELLECT_SHORT"] or 0) * (weights.Intellect or 0)
    score = score + (stats["ITEM_MOD_STAMINA_SHORT"] or 0) * (weights.Stamina or 0)
    
    -- Secondary stats
    if self.config.considerSecondaryStats then
        score = score + (stats["ITEM_MOD_CRIT_RATING_SHORT"] or 0) * (weights.CritStrike or 0)
        score = score + (stats["ITEM_MOD_HASTE_RATING_SHORT"] or 0) * (weights.Haste or 0)
        score = score + (stats["ITEM_MOD_MASTERY_RATING_SHORT"] or 0) * (weights.Mastery or 0)
        score = score + (stats["ITEM_MOD_VERSATILITY"] or 0) * (weights.Versatility or 0)
    end
    
    return score
end

-- Compare two items
function GearAdvisor:CompareItems(newItemLink, currentItemLink)
    if not newItemLink then return 0, "No item to compare" end
    if not currentItemLink then return 100, "No item equipped (huge upgrade!)" end
    
    local newScore = self:CalculateItemScore(newItemLink)
    local currentScore = self:CalculateItemScore(currentItemLink)
    
    if currentScore == 0 then return 100, "Empty slot (equip immediately!)" end
    
    local percentChange = ((newScore - currentScore) / currentScore) * 100
    
    if percentChange > 0 then
        return percentChange, string.format("%.1f%% upgrade!", percentChange)
    elseif percentChange < 0 then
        return percentChange, string.format("%.1f%% downgrade", math.abs(percentChange))
    else
        return 0, "Sidegrade (no change)"
    end
end

-- Get currently equipped item in slot
function GearAdvisor:GetEquippedItem(slotID)
    local itemLink = GetInventoryItemLink("player", slotID)
    return itemLink
end

-- Analyze quest rewards
function GearAdvisor:AnalyzeQuestRewards(questID)
    if not self.config.autoCompareRewards then return end
    
    local numRewards = GetNumQuestLogRewards(questID)
    if numRewards == 0 then return end
    
    local bestReward = nil
    local bestUpgrade = -999
    local recommendations = {}
    
    for i = 1, numRewards do
        local name, texture, numItems, quality, isUsable = GetQuestLogRewardInfo(i, questID)
        if name and isUsable then
            local itemLink = GetQuestLogItemLink("reward", i)
            if itemLink then
                local _, _, _, _, _, _, _, _, equipSlot = GetItemInfo(itemLink)
                
                -- Get slot ID from equipSlot
                local slotID = self:GetSlotIDFromEquipSlot(equipSlot)
                if slotID then
                    local currentItem = self:GetEquippedItem(slotID)
                    local percentChange, message = self:CompareItems(itemLink, currentItem)
                    
                    table.insert(recommendations, {
                        index = i,
                        name = name,
                        itemLink = itemLink,
                        percentChange = percentChange,
                        message = message,
                    })
                    
                    if percentChange > bestUpgrade then
                        bestUpgrade = percentChange
                        bestReward = i
                    end
                end
            end
        end
    end
    
    -- Display recommendations
    if #recommendations > 0 then
        print("|cff00ff00[QuestMaster Pro]|r Quest Reward Analysis:")
        for _, rec in ipairs(recommendations) do
            local color
            if rec.percentChange > 15 then
                color = "|cff00ff00" -- Green for big upgrades
            elseif rec.percentChange > 5 then
                color = "|cffffff00" -- Yellow for small upgrades
            elseif rec.percentChange > 0 then
                color = "|cffaaaaaa" -- Gray for tiny upgrades
            else
                color = "|cffff0000" -- Red for downgrades
            end
            
            print(string.format("  %s%s|r - %s", color, rec.name, rec.message))
        end
        
        if bestReward and bestUpgrade > 5 then
            print(string.format("|cff00ff00>>> BEST CHOICE: Reward #%d (%.1f%% upgrade) <<<|r", bestReward, bestUpgrade))
        end
    end
end

-- Convert equipSlot to inventory slot ID
function GearAdvisor:GetSlotIDFromEquipSlot(equipSlot)
    local slotMap = {
        INVTYPE_HEAD = 1,
        INVTYPE_NECK = 2,
        INVTYPE_SHOULDER = 3,
        INVTYPE_BODY = 4,
        INVTYPE_CHEST = 5,
        INVTYPE_ROBE = 5,
        INVTYPE_WAIST = 6,
        INVTYPE_LEGS = 7,
        INVTYPE_FEET = 8,
        INVTYPE_WRIST = 9,
        INVTYPE_HAND = 10,
        INVTYPE_FINGER = 11, -- First ring
        INVTYPE_TRINKET = 13, -- First trinket
        INVTYPE_CLOAK = 15,
        INVTYPE_WEAPON = 16,
        INVTYPE_2HWEAPON = 16,
        INVTYPE_WEAPONMAINHAND = 16,
        INVTYPE_WEAPONOFFHAND = 17,
        INVTYPE_SHIELD = 17,
        INVTYPE_HOLDABLE = 17,
        INVTYPE_RANGED = 18,
        INVTYPE_RANGEDRIGHT = 18,
    }
    
    return slotMap[equipSlot]
end

-- Check item on loot/receive
function GearAdvisor:CheckItemUpgrade(itemLink)
    if not itemLink then return end
    
    local _, _, _, _, _, _, _, _, equipSlot = GetItemInfo(itemLink)
    if not equipSlot or equipSlot == "" then return end
    
    local slotID = self:GetSlotIDFromEquipSlot(equipSlot)
    if not slotID then return end
    
    local currentItem = self:GetEquippedItem(slotID)
    local percentChange, message = self:CompareItems(itemLink, currentItem)
    
    if percentChange > 10 and self.config.notifyOnUpgrade then
        -- Significant upgrade
        if QuestMasterPro.Notifications and QuestMasterPro.Notifications.ShowNotification then
            QuestMasterPro.Notifications:ShowNotification(
                "GEAR UPGRADE!",
                string.format("%s\n%s", itemLink, message),
                8,
                "Interface\\Icons\\INV_Misc_Gem_Bloodstone_01"
            )
        end
        
        print(string.format("|cff00ff00[GEAR UPGRADE]|r %s - %s", itemLink, message))
    end
end

-- Initialize
function GearAdvisor:Initialize()
    print("|cff00ff00[QuestMaster Pro]|r Gear Advisor loaded!")
    
    -- Hook quest complete events
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("QUEST_COMPLETE")
    frame:RegisterEvent("CHAT_MSG_LOOT")
    
    frame:SetScript("OnEvent", function(self, event, ...)
        if event == "QUEST_COMPLETE" then
            local questID = ...
            if questID then
                C_Timer.After(0.5, function()
                    GearAdvisor:AnalyzeQuestRewards(questID)
                end)
            end
        elseif event == "CHAT_MSG_LOOT" then
            local message = ...
            -- Parse item link from loot message
            local itemLink = string.match(message, "(|c%x+|H.+|h%[.+%]|h|r)")
            if itemLink then
                GearAdvisor:CheckItemUpgrade(itemLink)
            end
        end
    end)
end

-- Slash commands
SLASH_QMPGEAR1 = "/qmpgear"
SLASH_QMPGEAR2 = "/gear"
SlashCmdList["QMPGEAR"] = function(msg)
    if msg == "compare" then
        print("|cff00ff00[QuestMaster Pro]|r Hover over items to compare...")
        -- Could implement hover comparison here
    elseif msg == "toggle" then
        GearAdvisor.config.autoCompareRewards = not GearAdvisor.config.autoCompareRewards
        print(string.format("|cff00ff00[QuestMaster Pro]|r Auto gear comparison: %s",
            GearAdvisor.config.autoCompareRewards and "|cff00ff00ON|r" or "|cffff0000OFF|r"))
    else
        print("|cff00ff00[QuestMaster Pro Gear Advisor]|r Commands:")
        print("  /gear compare - Compare items")
        print("  /gear toggle - Toggle auto comparison")
    end
end

return GearAdvisor
